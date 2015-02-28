package winston

import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.springframework.util.StringUtils
import sk.upjs.winston.User
import sk.upjs.winston.groovy.DatasetAttributeParser
import sk.upjs.winston.groovy.converter.CSV2ArffConverter

@Transactional
class DatasetService {
    public static final int SALT_LENGTH = 9
    def fileUploadService

    public static final String DEFAULT_DELIMITER = ","
    private String delimiter = DEFAULT_DELIMITER

    public def saveDataset(User user, def title, def description, def file, def missingValuePattern) {
        println "Dataset file: ${file}"
        String originalFilename = null
        if (file != null && file.size() != 0) {
            originalFilename = file.getName()
            println "Dataset filename: ${originalFilename}"
        }

        String filename = originalFilename
        int extensionIndex = originalFilename.lastIndexOf(".")
        if (extensionIndex >= 0) {
            filename = originalFilename.substring(0,extensionIndex) + generateRandomSalt() + originalFilename.substring(extensionIndex, originalFilename.length())
        } else {

        }

        println "SALT: ${generateRandomSalt()}"

        //get storage path
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath(FileUploadService.DATASET_UPLOAD_DIRECTORY)

        //upload file
        def filePath = fileUploadService.uploadFile(file, filename, FileUploadService.DATASET_UPLOAD_DIRECTORY)

        File csv = new File("${filePath}")
        File arff = createArffFileFromCsv(csv)

        //initialize dataset instance
        Dataset datasetInstance = new Dataset()
        datasetInstance.setUser(user)
        datasetInstance.setTitle(title)
        datasetInstance.setOriginalFilename(originalFilename)
        datasetInstance.setDataFile(filename)
        datasetInstance.setArffDataFile(arff.getName())
        datasetInstance.setDescription(description)
        datasetInstance.setMissingValuePattern(missingValuePattern)
        datasetInstance.setNumberOfMissingValues(getNumberOfMissingValues(file, missingValuePattern))

        //parse file and get attributes
        DatasetAttributeParser dap = new DatasetAttributeParser(file, missingValuePattern, delimiter)
        datasetInstance.setNumberOfInstances(dap.getNumberOfInstances())
        List<Attribute> attrs = dap.getAttributes()
        for (int i = 0; i < attrs.size(); i++) {
            def attr = attrs.get(i)
            attr.save()
            datasetInstance.addToAttributes(attr)
        }

        return datasetInstance.save(flush: true)
    }

    public def deleteDatasetFiles(Long id) {
        def datasetInstance = Dataset.get(id)
        deleteDataFile(datasetInstance.getDataFile())
        deleteDataFile(datasetInstance.getArffDataFile())
    }

    /** HELPER METHODS*/

    private File createArffFileFromCsv(File csvFile) {
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath(FileUploadService.DATASET_UPLOAD_DIRECTORY)
        String filepath = storagePath + "/" + csvFile.getName()
        filepath = filepath.replace(".csv", ".arff")
        File arffFile = new File(filepath)
        if (arffFile.exists()) {
            arffFile.delete()
        }
        arffFile.createNewFile()

        CSV2ArffConverter converter = new CSV2ArffConverter()
        converter.convertCsvToArff(csvFile, arffFile)

        return arffFile
    }

    private def getNumberOfMissingValues(def file, String missingValuePattern) {
        if (missingValuePattern == null || missingValuePattern.length() == 0) {
            return 0
        }
        def data = new String(file.getText())
        //		println "DATA SIZE: ${data.class}"
        StringUtils.countOccurrencesOf(data, missingValuePattern)
    }

    private void deleteDataFile(String filename) {
        //get storage path
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath(FileUploadService.DATASET_UPLOAD_DIRECTORY)

        File file = new File("${storagePath}/${filename}")
        if (file.exists()) {
            file.delete()
        }
    }

    private String generateRandomSalt() {
        def generator = { String alphabet, int n ->
            new Random().with {
                (1..n).collect { alphabet[nextInt(alphabet.length())] }.join()
            }
        }
        return "(${generator((('A'..'Z') + ('0'..'9') + ('a'..'z')).join(), SALT_LENGTH)})"
    }

}
