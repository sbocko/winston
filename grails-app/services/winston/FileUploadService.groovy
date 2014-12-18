package winston

import grails.transaction.Transactional
import org.apache.commons.io.FileUtils
import org.codehaus.groovy.grails.web.context.ServletContextHolder

/**
 *
 * @author Stefan Bocko
 * This class uploads file from user to the appropriate directory on the server.
 *
 */
@Transactional
class FileUploadService {
//	public static final String DATASET_UPLOAD_DIRECTORY = "/Volumes/Seagate HDD/winston/resources"
    public static final String DATASET_UPLOAD_DIRECTORY = "/datasets"

    def String uploadFile(def file, String name, String destinationDirectory) {

//		get storage path
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath(destinationDirectory)

//		Create storage path directory if it does not exist
        def storagePathDirectory = new File(storagePath)
        if (!storagePathDirectory.exists()) {
            print "CREATING DIRECTORY ${storagePath}"
            if (storagePathDirectory.mkdirs()) {
                println "SUCCESS"
            } else {
                println "FAILED"
            }
        }

        println "storing file...";

//		Store file
        if (file != null && file.size() != 0) {
            File uploadedFile = new File("${storagePath}/${name}")
            FileUtils.copyFile(file, uploadedFile);
            println "Saved file ${storagePath}/${name} - size: ${uploadedFile.size()}"

            return "${storagePath}/${name}"
        } else {
            println "File ${file} was empty!"
            return null
        }
    }
}
