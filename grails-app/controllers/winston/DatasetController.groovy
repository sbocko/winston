package winston

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.dao.DataIntegrityViolationException
import sk.upjs.winston.Role
import sk.upjs.winston.User

@Secured([Role.ROLE_USER])
class DatasetController {
    def datasetService
    private static final double MIN_PERCENT_OF_DISTINCT_VALUES = 0.05

//    static allowedMethods = [save: "POST", delete: "POST"]

    def springSecurityService

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        User user = springSecurityService.getCurrentUser()
//        List<Dataset> datasetList = Dataset.findAllByUser(user)

        List<Dataset> datasetList = Dataset.createCriteria().list(
                sort:params.sort,
                order:params.order,
//                max:params.max,
//                offset:params.offset
        ) {
            eq ("deleted", false)
            eq ("user.id", user.getId())
        }

        [datasetInstanceList: datasetList, datasetInstanceTotal: datasetList.size(), params: params]
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
        def missingValuePattern = params.get(Dataset.MISSING_VALUE_PATTERN_VAR)
        String title = params.get(Dataset.TITLE_VAR)
        def description = params.get(Dataset.DESCRIPTION_VAR)
        User user = springSecurityService.getCurrentUser()

        if(title == null || title.trim().length() == 0){
            flash.error = "Field title cannot be empty!"
            redirect(action: "create", params: params)
            return
        }

        //get dataset attribute values
        def file = request.getFile(Dataset.DATA_FILE_VAR)
        File myFile = new File("/tmp/"+file.getOriginalFilename())
        try {
            file.transferTo(myFile)
        } catch (IOException e){
            println "DIRECTORY: ${myFile.getAbsolutePath()}"
            e.printStackTrace()
            flash.error = "Field Data File can not be empty!"
            redirect(action: "create", params: params)
            return
        }
//        def myFile = file
//        if(myFile.empty){
//            println "DIRECTORY: ${myFile.getAbsolutePath()}"
//            e.printStackTrace()
//            flash.error = "Field Data File can not be empty!"
//            redirect(action: "create", params: params)
//            return
//        }

        def datasetInstance;
        try {
            datasetInstance = datasetService.saveDataset(user, title, description, myFile, missingValuePattern)
        } catch (Exception e){
            flash.message = "Unable to process file. Check if data are in the correct form."
            redirect(action: "create", params: params)
            return
        }


        //if some error occures
        if (!datasetInstance) {
            render(view: "create", params:params,  model: [datasetInstance: datasetInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [
                message(code: 'dataset.label', default: 'Dataset'),
                datasetInstance.getTitle()
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
                    datasetInstance.getTitle()
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
                datasetInstance.getTitle()
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

        def title = datasetInstance.getTitle();
        try {
//            datasetService.deleteDatasetFiles(id)
//            datasetInstance.delete(flush: true)
            datasetInstance.setDeleted(true)
            datasetInstance.save(flush: true)

            flash.message = message(code: 'default.deleted.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    title
            ])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [
                    message(code: 'dataset.label', default: 'Dataset'),
                    title
            ])
            redirect(action: "show", id: id)
        }
    }

}
