package winston

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.dao.DataIntegrityViolationException
import sk.upjs.winston.Role
import sk.upjs.winston.User

@Secured([Role.ROLE_USER])
class DatasetController {
    def datasetService
    private static final double MIN_PERCENT_OF_DISTINCT_VALUES = 0.05

    static allowedMethods = [save: "POST", delete: "POST"]

    def springSecurityService

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        User user = springSecurityService.getCurrentUser()
        List<User> datasetList = Dataset.findAllByUser(user)
        [datasetInstanceList: datasetList, datasetInstanceTotal: datasetList.size()]
//        [datasetInstanceList: Dataset.list(params), datasetInstanceTotal: Dataset.count()]
    }

    def create() {
        [datasetInstance: new Dataset(params)]
    }

    /**
     * Parses form for creating new dataset, creates attributes and counts missing values...
     * Saves this dataset to database.
     *
     */
    def save() {
        //get dataset attribute values
        def file = request.getFile(Dataset.DATA_FILE_VAR)
        File myFile = new File(file.getOriginalFilename())
        file.transferTo(myFile)
        def missingValuePattern = params.get(Dataset.MISSING_VALUE_PATTERN_VAR)
        def title = params.get(Dataset.TITLE_VAR)
        def description = params.get(Dataset.DESCRIPTION_VAR)
        User user = springSecurityService.getCurrentUser()

        def datasetInstance = datasetService.saveDataset(user, title, description, myFile, missingValuePattern)

        //println "dataset ${datasetInstance}"

        //if some error occures
        if (!datasetInstance) {
            render(view: "create", model: [datasetInstance: datasetInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [
                message(code: 'dataset.label', default: 'Dataset'),
                datasetInstance.id
        ])
        redirect(action: "show", id: datasetInstance.id)
    }

    def show(Long id) {
        def datasetInstance = Dataset.get(id)
        if (!datasetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    id
            ])
            redirect(action: "list")
            return
        }

        [datasetInstance: datasetInstance, analysisInstances: datasetInstance.getTopAnalyzes(Dataset.NUMBER_OF_RESULTS_TO_SHOW)]
    }

    def edit(Long id) {
        def datasetInstance = Dataset.get(id)
        if (!datasetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    id
            ])
            redirect(action: "list")
            return
        }

        [datasetInstance: datasetInstance]
    }

    def update(Long id, Long version) {
        def datasetInstance = Dataset.get(id)
        if (!datasetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    id
            ])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (datasetInstance.version > version) {
                datasetInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [
                                message(code: 'dataset.label', default: 'Dataset')] as Object[],
                        "Another user has updated this Dataset while you were editing")
                render(view: "edit", model: [datasetInstance: datasetInstance])
                return
            }
        }
        datasetInstance.properties = params

        if (!datasetInstance.save(flush: true)) {
            render(view: "edit", model: [datasetInstance: datasetInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [
                message(code: 'dataset.label', default: 'Dataset'),
                datasetInstance.id
        ])
        redirect(action: "show", id: datasetInstance.id)
    }

    def delete(Long id) {
        def datasetInstance = Dataset.get(id)
        if (!datasetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    id
            ])
            redirect(action: "list")
            return
        }

        try {
            datasetService.deleteDatasetFiles(id)
            datasetInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    id
            ])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    id
            ])
            redirect(action: "show", id: id)
        }
    }

}
