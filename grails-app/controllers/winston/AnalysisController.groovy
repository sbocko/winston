package winston

import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import sk.upjs.winston.Role

import static org.springframework.http.HttpStatus.*

@Secured([Role.ROLE_USER])
class AnalysisController {
    private static final double MIN_PERCENT_OF_DISTINCT_VALUES = 0.05

    def preprocessingService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Analysis.list(params), model: [analysisInstanceCount: Analysis.count()]
    }

    def show(Analysis analysisInstance) {
        respond analysisInstance, model: [analysisResults: analysisInstance.getTopAnalysisResults(Analysis.NUMBER_OF_RESULTS_TO_SHOW)]
    }

    def create(Long id) {
//        respond new Analysis(params)

        def datasetInstance = Dataset.get(id)
        if (!datasetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    id
            ])
            redirect(controller: "Dataset", action: "list")
            return
        }

        render(view: "create", model: [datasetInstance: datasetInstance])
    }

    @Transactional
    def save(Analysis analysisInstance) {
        if (analysisInstance == null) {
            notFound()
            return
        }

        if (analysisInstance.hasErrors()) {
            respond analysisInstance.errors, view: 'create'
            return
        }

        analysisInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'analysis.label', default: 'Analysis'), analysisInstance.id])
                redirect analysisInstance
            }
            '*' { respond analysisInstance, [status: CREATED] }
        }
    }

    def edit(Analysis analysisInstance) {
        respond analysisInstance
    }

    @Transactional
    def update(Analysis analysisInstance) {
        if (analysisInstance == null) {
            notFound()
            return
        }

        if (analysisInstance.hasErrors()) {
            respond analysisInstance.errors, view: 'edit'
            return
        }

        analysisInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Analysis.label', default: 'Analysis'), analysisInstance.id])
                redirect analysisInstance
            }
            '*' { respond analysisInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Analysis analysisInstance) {

        if (analysisInstance == null) {
            notFound()
            return
        }

        deleteAnalysisDataFiles(analysisInstance)

        analysisInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Analysis.label', default: 'Analysis'), analysisInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    private void deleteAnalysisDataFiles(Analysis analysisInstance) {
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath(PreprocessingService.PREPARED_DATAFILES_DIRECTORY)
        def storagePathDirectory = new File(storagePath)
        deleteFileForFilePath("${storagePathDirectory}/${analysisInstance.getCsvDataFile()}")
        storagePath = servletContext.getRealPath(PreprocessingService.PREPARED_ARFF_DATAFILES_DIRECTORY)
        storagePathDirectory = new File(storagePath)
        deleteFileForFilePath("${storagePathDirectory}/${analysisInstance.getArffDataFile()}")
    }

    private void deleteFileForFilePath(String filepath) {
        def file = new File(filepath)
        if (file.exists()) {
            file.delete()
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'analysis.label', default: 'Analysis'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def getTargetAttribute(Long id) {
        def datasetInstance = Dataset.get(id)
        if (!datasetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    id
            ])
            redirect(controller: "dataset", action: "list")
            return
        }

        def answer = params.targetAttributeRadioGroup

        def targetAttributeId
        datasetInstance.attributes.each { attr ->
            if (attr.id == Long.parseLong(answer)) {
                targetAttributeId = attr.id
            }
        }

        forward(action: "preprocessing", id: params.id, params:[targetAttributeId: targetAttributeId]);
    }

    def preprocessing(Long id) {
        def datasetInstance = Dataset.get(id)
        if (!datasetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    id
            ])
            redirect(controller: "dataset", action: "list")
            return
        }

        def attrIdList = new ArrayList<Attribute>()
        /*
         * get attributes, which has less than MIN_PERCENT_OF_DISTINCT_VALUES
         */
        def minCount = datasetInstance.getNumberOfInstances() * MIN_PERCENT_OF_DISTINCT_VALUES
        Long targetAttributeId = Long.parseLong(params.targetAttributeId)
        datasetInstance.attributes.each { attr ->
            if (attr instanceof NumericAttribute && attr.getNumberOfDistinctValues() < minCount && attr.id != targetAttributeId) {
                attrIdList.add(attr)
            }
        }

        render(view: "preprocessing", model: [datasetInstance: datasetInstance, attrIdList: attrIdList, targetAttributeId: targetAttributeId])
    }

    def analyze(Long id) {
        def datasetInstance = Dataset.get(id)

        if (!datasetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    id
            ])
            redirect(action: "list")
            return
        }
        Long targetAttributeId = Long.parseLong(params.targetAttributeId)
        Attribute target = Attribute.get(targetAttributeId)

        /*
         * check which attributes will be splitted based on user input
         */
        Map<Attribute, Boolean> attributesToSplit = new HashMap<Attribute, Boolean>()
        datasetInstance.attributes.each { attr ->
            if (params.get('radioGroup' + attr.getId()) == "1") {
                attributesToSplit.put(attr, true)
            } else {
                attributesToSplit.put(attr, false)
            }
        }

        Analysis analysis = preprocessingService.createAnalysis(datasetInstance, attributesToSplit, target)

        redirect(controller: "Analysis", action: "show", id: analysis.getId())
    }

    /** HELPER METHODS */
}
