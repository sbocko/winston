package winston

import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.context.ServletContextHolder

@Transactional
class BackgroundService {
    private static final String BACKEND_SERVER_IP = "localhost"
//    private static final String BACKEND_SERVER_IP = "master.exp.upjs.sk"
    private static final int BACKEND_SERVER_PORT = 4322

    private static final String RETURN_CODE_OK = "200: OK"
    private static final String RETURN_CODE_ERR = "400: ERR"

    private static final String COMMAND_PREPROCESS = "preprocess"
    private static final String COMMAND_GRID_SEARCH = "grid_search"
    private static final String COMMAND_FILE_REQUEST = "file_request"

    def analysisService

    def preprocessDataOnBackground(Dataset dataset, String task, Attribute target, Map<Attribute, Boolean> attributesToSplit) {
        println "sending data for background preprocessing"
        Socket backend = connectToBackendServer()

        OutputStream out = backend.getOutputStream()
        DataOutputStream dataOutput = new DataOutputStream(out)

        writePreprocessingParameters(dataOutput, dataset, task, target, attributesToSplit)
        backend.shutdownOutput()

        InputStream input = backend.getInputStream()
        DataInputStream dataInput = new DataInputStream(input)
        String response = dataInput.readUTF()
        println "return code: $response"

        dataInput.close()
        input.close()
        dataOutput.close()
        out.close()
        backend.close()
    }

    def performGridSearchForAnalysis(Analysis analysis) {
        println "sending data for background grid search analysis"
        runAsync {
            Socket backend = connectToBackendServer()

            OutputStream out = backend.getOutputStream();
            DataOutputStream dataOutput = new DataOutputStream(out);

            writeGridSearchParameters(dataOutput, analysis)

            dataOutput.close()
            out.close()
            backend.close()
        }
    }

    public File getAnalysisFile(Analysis analysis) {
        println "sending request for file ${analysis.getDataFile()}"
        Socket backend = connectToBackendServer()

        OutputStream out = backend.getOutputStream()
        DataOutputStream dataOutput = new DataOutputStream(out)

        writeFileRequestParameters(dataOutput, analysis.getDataFile())
        backend.shutdownOutput()

        InputStream input = backend.getInputStream()
        DataInputStream dataInput = new DataInputStream(input)
        File received = receiveDataFile(backend, dataInput, analysis.getDataFile())

        dataInput.close()
        input.close()
        dataOutput.close()
        out.close()
        backend.close()

        return received
    }

/** HELPER METHODS */

    private File receiveDataFile(Socket connection, DataInputStream dataInput, String filename) throws IOException {
        // get storage path
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath(AnalysisService.PREPARED_DATAFILES_DIRECTORY)
        //	Create storage path directory if it does not exist
        def storagePathDirectory = new File(storagePath)
        if (!storagePathDirectory.exists()) {
            print "CREATING DIRECTORY ${storagePath}"
            if (storagePathDirectory.mkdirs()) {
                println "SUCCESS"
            } else {
                println "FAILED"
            }
        }

        File received = new File("${storagePathDirectory}/${filename}");
        received.createNewFile();

        FileOutputStream fos = new FileOutputStream(received);
        BufferedOutputStream bos = new BufferedOutputStream(fos);

        int bufferSize = connection.getReceiveBufferSize();
        byte[] bytes = new byte[bufferSize];
        int count;
        while ((count = dataInput.read(bytes)) > 0) {
            bos.write(bytes, 0, count);
        }

        bos.flush();
        bos.close();
        fos.close();
        return received;
    }

    private void writeFileRequestParameters(DataOutputStream dataOutput, String filename) {
        dataOutput.writeUTF(COMMAND_FILE_REQUEST)
        dataOutput.writeUTF(filename)
        dataOutput.flush()
    }

    private void writeGridSearchParameters(DataOutputStream dataOutput, Analysis analysis) {
        dataOutput.writeUTF(COMMAND_GRID_SEARCH)
        dataOutput.writeLong(analysis.getId())
        dataOutput.flush()
    }

    private void writePreprocessingParameters(DataOutputStream dataOutput, Dataset dataset, String task, Attribute target, Map<Attribute, Boolean> attributesToSplit) {
        dataOutput.writeUTF(COMMAND_PREPROCESS)
        //write dataset ID
        dataOutput.writeLong(dataset.getId())
        //write modeling task
        dataOutput.writeUTF(task)
        //write target attribute ID
        dataOutput.writeLong(target.getId())

        int numberOfAttributesToSplit = calculateNumberOfAttributesToSplit(attributesToSplit)
        //write number of attribute IDs to split
        dataOutput.writeInt(numberOfAttributesToSplit)

        //write IDs of attributes to split
        for (Map.Entry<Attribute, Boolean> entry : attributesToSplit.entrySet()) {
            if (entry.value) {
                dataOutput.writeLong(entry.key.getId())
            }
        }

        println "sending file"
        sendDataFile(dataset, dataOutput)
        println "file sent"

        dataOutput.flush()
    }

    private void sendDataFile(Dataset dataset, DataOutputStream dataOutput) {
        File file = analysisService.getDatasetFileForFileName(dataset.arffDataFile)
        long length = file.length()
        if (length > Integer.MAX_VALUE) {
            System.out.println("File is too large.")
            return
        }

        byte[] bytes = new byte[(int) length]
        FileInputStream fis = new FileInputStream(file)
        BufferedInputStream bis = new BufferedInputStream(fis)

        int count
        while ((count = bis.read(bytes)) > 0) {
            dataOutput.write(bytes, 0, count)
        }

        dataOutput.flush()
        fis.close()
        bis.close()
    }

    private Socket connectToBackendServer() {
        Socket backend = new Socket(BACKEND_SERVER_IP, BACKEND_SERVER_PORT)
        return backend
    }

    private int calculateNumberOfAttributesToSplit(Map<Attribute, Boolean> attributesToSplit) {
        int numberOfAttributesToSplit = 0
        for (Boolean split : attributesToSplit.values()) {
            if (split) {
                numberOfAttributesToSplit++
            }
        }
        return numberOfAttributesToSplit
    }

}
