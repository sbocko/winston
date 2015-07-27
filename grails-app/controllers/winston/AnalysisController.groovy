package winston

import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import sk.upjs.winston.Role

import static org.springframework.http.HttpStatus.*

@Secured([Role.ROLE_USER])
class AnalysisController {
    private static final double MIN_PERCENT_OF_DISTINCT_VALUES = 0.05
    public static final String TASK_CLASSIFICATION = "CLASSIFICATION"
    public static final String TASK_REGRESSION = "REGRESSION"
    public static final String TASK_PATTERN_MINING = "PATTERN_MINING"

    def analysisService
    def modellingService
    def backgroundService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        redirect(controller: "dataset", action: "list")
//        respond Analysis.list(params), model: [analysisInstanceCount: Analysis.count()]
    }

    def show(Analysis analysisInstance) {
        respond analysisInstance, model: [analysisResults: analysisInstance.getTopAnalysisResults(Analysis.NUMBER_OF_RESULTS_TO_SHOW)]
    }

    def create(Long id) {
//        respond new Analysis(params)

        def datasetInstance = Dataset.get(id)
        if (!datasetInstance) {
            flash.message = "Dataset not found!"
            redirect(controller: "dataset", action: "list")
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

    @Transactional
    def gridSearch(Analysis analysisInstance) {
        analysisInstance.setGridSearchAnalysisInProgress(true)
        analysisInstance.save(flush: true)
//        modellingService.performGridsearchAnalysisForFile(analysisInstance)
        backgroundService.performGridSearchForAnalysis(analysisInstance)

        flash.message = message(code: 'default.gridSearch.message', default: "Grid successfully search started. You will be notified by an email when it finishes."
                , args: [message(code: 'Analysis.label', default: 'Analysis'), analysisInstance.id])
        redirect(action: "show", id: analysisInstance.id)
    }

    def edit(Analysis analysisInstance) {
        respond analysisInstance
    }

    def downloadFile(Analysis analysisInstance) {
        def file = getAnalysisFile(analysisInstance)

        if (file.exists()) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "filename=${file.name}")
            response.outputStream << file.bytes
            return
        }
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
        def storagePath = servletContext.getRealPath(analysisService.PREPARED_DATAFILES_DIRECTORY)
        def storagePathDirectory = new File(storagePath)
        deleteFileForFilePath("${storagePathDirectory}/${analysisInstance.getDataFile()}")
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

    def classification(Long id) {
        def datasetInstance = Dataset.get(id)
        if (!datasetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    id
            ])
            redirect(controller: "dataset", action: "list")
            return
        }

        render(view: "classification_details_selection", model: [datasetInstance: datasetInstance, task: TASK_CLASSIFICATION])
    }

    def regression(Long id) {
        def datasetInstance = Dataset.get(id)
        if (!datasetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    id
            ])
            redirect(controller: "dataset", action: "list")
            return
        }

        render(view: "regression_details_selection", model: [datasetInstance: datasetInstance, task: TASK_REGRESSION])
    }

    def patternMining(Long id) {
        def datasetInstance = Dataset.get(id)
        if (!datasetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    id
            ])
            redirect(controller: "dataset", action: "list")
            return
        }

        // TODO implement me
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
        def task = params.task

        if(!answer) {
            flash.error = "Target attribute has to be chosen."
            println("PARAMS: " + params)
            if(task.toString().equals(TASK_CLASSIFICATION)){
                redirect(controller: "analysis", action: "classification", id: datasetInstance.getId())
            } else if(task.toString().equals(TASK_REGRESSION)) {
                redirect(controller: "analysis", action: "regression", id: datasetInstance.getId())
            } else {
                println("UNKNOWN TASK")
                redirect(controller: "analysis", action: "create", id: datasetInstance.getId())
            }
            return
        }

        def targetAttributeId
        datasetInstance.attributes.each { attr ->
            if (attr.id == Long.parseLong(answer)) {
                targetAttributeId = attr.id
            }
        }

        forward(action: "preprocessing", id: params.id, params: [targetAttributeId: targetAttributeId]);
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

        if(!attrIdList || attrIdList.size() == 0) {
            forward(action: "analyze", id: params.id, params: [targetAttributeId: targetAttributeId, task: params.task]);
        }

        render(view: "preprocessing", model: [datasetInstance: datasetInstance, attrIdList: attrIdList, targetAttributeId: targetAttributeId, task: params.task])
    }

    def analyze(Long id) {
        def datasetInstance = Dataset.get(id)

        if (!datasetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    id
            ])
            redirect(controller: "dataset", action: "list")
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

        String task = params.task

//        Analysis analysis = preprocessingService.createAnalysis(datasetInstance, attributesToSplit, target)
        analysisService.generateAnalyzes(datasetInstance, task, attributesToSplit, target)

        flash.message = "We have started several analyzes, we think can perform well on your data. " +
                "The first one is already done. You can view it in the table at the end of this page. " +
                "More analyzes will be there over time. We will notify you by an email."
        redirect(controller: "dataset", action: "show", id: datasetInstance.getId())
    }

    /** HELPER METHODS */

    private File getAnalysisFile(Analysis analysis) {
//        def servletContext = ServletContextHolder.servletContext
//        def storagePath = servletContext.getRealPath(AnalysisService.PREPARED_DATAFILES_DIRECTORY)
//        String filepath = storagePath + "/" + analysis.getDataFile()
//        return new File(filepath)
        backgroundService.getAnalysisFile(analysis)
    }
}
