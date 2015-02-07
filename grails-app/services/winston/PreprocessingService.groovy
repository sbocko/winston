package winston

import grails.transaction.Transactional
import org.apache.commons.io.FileUtils
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import sk.upjs.winston.groovy.DatasetAttributeParser
import weka.core.AttributeStats
import weka.core.Instances
import weka.core.converters.ArffSaver

@Transactional
class PreprocessingService {
    def analyzeService
    def missingValuesHandlingService
    public static final String PREPARED_DATAFILES_DIRECTORY = "/prepared-datasets"
    private static final String CONTAINS_ATTRIBUTE_VALUE = "1"
    private static final String DOES_NOT_CONTAIN_ATTRIBUTE_VALUE = "0"

    public List<Analysis> generateAnalyzes(Dataset dataset, Map<Attribute, Boolean> attributesToSplit, Attribute target) {
        List<Analysis> analyzes = new ArrayList<>()
        List<Instances> replaced = replaceMissingValues(dataset)

        for (Instances instances : replaced) {
            saveInstancesToFiles(instances, dataset.getTitle())
        }

        return analyzes
    }

    public Analysis createAnalysis(Dataset dataset, Map<Attribute, Boolean> attributesToSplit, Attribute target) {
        String[][] datasetAttributesData = getDatasetAttributesData(dataset)
        List<String[]> dataToSave = splitAttributes(datasetAttributesData, attributesToSplit, target)

        String csvFileName = saveDataToFile(dataToSave, dataset.getTitle())
        File arffFile = createArffFileFromCsv(getDatasetFileForFileName(csvFileName))
        String arffFileName = arffFile.getName()

        String dataType = getDataTypeForData(arffFile)

        Analysis analysis = new Analysis(dataset: dataset, csvDataFile: csvFileName, arffDataFile: arffFileName, dataType: dataType, numberOfAttributes: dataToSave.size())
        analysis.save(flush: true)
        analysis.refresh()

        analyzeService.performAnalysisWithDefaultHyperparameters(analysis)
        analyzeService.performRecommendedDataMiningMethodForAnalysis(analysis)

        analyzeService.performGridsearchAnalysisForFile(analysis)

        return analysis
    }

    /** HELPER METHODS */

    private void saveInstancesToFiles(Instances toSave, String datasetTitle) {
        ArffSaver saver = new ArffSaver();
        saver.setInstances(toSave);
        saver.setFile(generateEmptyFileForDatasetAnalysis(datasetTitle));
        saver.writeBatch();
    }

    private File generateEmptyFileForDatasetAnalysis(String datasetTitle) {
        // get storage path
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath(PREPARED_DATAFILES_DIRECTORY)
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

        int analysisNumber = 1
        boolean stop = false
        File file
        while (!stop) {
            file = new File("${storagePathDirectory}/${datasetTitle}-analysis_${analysisNumber}.csv");
            if (!file.exists()) {
                stop = true
            }
            analysisNumber++
        }
        file.createNewFile();
        return file
    }

    private List<Instances> replaceMissingValues(Dataset dataset) {
        File arff = getDatasetFileForFileName(dataset.getArffDataFile())
        BufferedReader r = new BufferedReader(
                new FileReader(arff))
        Instances original = new Instances(r)
        r.close()

        List<Instances> replaced = new ArrayList<Instances>()
        replaced.add(makeClone(original))

        for (Attribute datasetAttribute : dataset.getAttributes()) {
            if(datasetAttribute.getNumberOfMissingValues() == 0){
                continue
            }

            int positionInDataFile = datasetAttribute.getPositionInDataFile()
            weka.core.Attribute attribute = original.attribute(positionInDataFile)

            Instances toAdd = null

            for (Instances actual : replaced) {
                //nahrad chybajuce hodnoty
                if (datasetAttribute.instanceOf(NumericAttribute)) {
                    missingValuesHandlingService.replaceMissingValuesByMeanInNumericAttribute(original, actual, (NumericAttribute) datasetAttribute)
                    Instances alternative = makeClone(actual)
                    alternative = missingValuesHandlingService.replaceMissingValuesByMajorValueInNumericAttribute(original, alternative, (NumericAttribute) datasetAttribute)
                    toAdd = alternative
                } else if (datasetAttribute.instanceOf(StringAttribute)) {
                    missingValuesHandlingService.replaceMissingValuesByMajorValueInStringAttribute(original, actual, (StringAttribute) datasetAttribute)
                } else if (datasetAttribute.instanceOf(BooleanAttribute)) {
                    missingValuesHandlingService.replaceMissingValuesByMajorInBooleanAttribute(original, actual, (BooleanAttribute) datasetAttribute)
                }
            }

            if (toAdd != null) {
                replaced.addAll(toAdd)
            }
        }

        return replaced
    }

    private Instances makeClone(Instances source) {
        Instances destination = new Instances(source)
        return destination
    }

    private String getDataTypeForData(File arffFile) {
        BufferedReader r = new BufferedReader(
                new FileReader(arffFile))
        Instances instances = new Instances(r)
        r.close()

        boolean wasInt = false
        boolean wasReal = false
        boolean wasCategorical = false

        int numberOfAttributes = instances.numAttributes()
        def CLASSIFICATION_ATTRIBUTE_POSITION = numberOfAttributes - 1

        for (int i = 0; i < numberOfAttributes; i++) {
            AttributeStats attributeStats = instances.attributeStats(i)
            if (i != CLASSIFICATION_ATTRIBUTE_POSITION) {
                boolean isNominal = instances.attribute(i).isNominal()
                if (attributeStats.intCount != 0 && attributeStats.realCount == 0 && !isNominal) {
                    if (attributeStats.intCount == 2) {
                        wasCategorical = true
                    } else {
                        wasInt = true
                    }
                } else if (attributeStats.realCount != 0 && !isNominal) {
                    wasReal = true
                } else {
                    wasCategorical = true
                }
            }
        }

        if ((wasCategorical && wasInt) || (wasCategorical && wasReal) || (wasReal && wasInt)) {
            return Analysis.DATA_TYPE_MULTIVARIATE
        } else if (wasCategorical) {
            return Analysis.DATA_TYPE_CATEGORICAL
        } else if (wasReal) {
            return Analysis.DATA_TYPE_REAL
        } else if (wasInt) {
            return Analysis.DATA_TYPE_INTEGER
        }

    }

    private String saveDataToFile(List<String[]> data, String datasetTitle) {
//        // get storage path
//        def servletContext = ServletContextHolder.servletContext
//        def storagePath = servletContext.getRealPath(PREPARED_DATAFILES_DIRECTORY)
//        //	Create storage path directory if it does not exist
//        def storagePathDirectory = new File(storagePath)
//        if (!storagePathDirectory.exists()) {
//            print "CREATING DIRECTORY ${storagePath}"
//            if (storagePathDirectory.mkdirs()) {
//                println "SUCCESS"
//            } else {
//                println "FAILED"
//            }
//        }
//
//        int analysisNumber = 1
//        boolean stop = false
//        def file
//        while (!stop) {
//            file = new File("${storagePathDirectory}/${datasetTitle}-analysis_${analysisNumber}.csv");
//            if (!file.exists()) {
//                stop = true
//            }
//            analysisNumber++
//        }
//        file.createNewFile();

        File file = generateEmptyFileForDatasetAnalysis(datasetTitle)

        for (int i = 0; i < data.get(0).length; i++) {
            String toWrite = ""
            for (int j = 0; j < data.size() - 1; j++) {
                toWrite += data.get(j)[i] + DatasetService.DEFAULT_DELIMITER
            }
            //last line without new line character
            if (i == data.get(0).length - 1) {
                toWrite += data.get(data.size() - 1)[i]
            } else {
                toWrite += data.get(data.size() - 1)[i] + "\n"
            }
            FileUtils.writeStringToFile(file, toWrite, true)
        }

        return file.getName()
    }

    private File getDatasetFileForFileName(String filename) {
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath(FileUploadService.DATASET_UPLOAD_DIRECTORY)
        String filepath = storagePath + "/" + filename
        return new File(filepath)
    }


    private List<String[]> splitAttributes(String[][] datasetAttributesData, Map<Attribute, Boolean> attributesToSplit, Attribute target) {
        List<String[]> result = new ArrayList<String[]>()

        for (int i = 0; i < datasetAttributesData.length; i++) {
            attributesToSplit.each { attr, split ->
                if (attr.getPositionInDataFile() == i) {
                    if (attr.id != target.id) {
                        result.addAll(getNewAttributeData(datasetAttributesData[i], attr, split))
                    }
                }
            }
        }
        result.addAll(getNewAttributeData(datasetAttributesData[target.getPositionInDataFile()], target, false))

        return result
    }

    /*
     *  @param splitAttribute null if this attribute should not be devided
     */

    private List<String[]> getNewAttributeData(String[] attributeData, Attribute splitAttribute, boolean split) {
        List<String[]> result = new ArrayList<String[]>()

        if (!split) {
            String[] data = addAttributeTitleToData(attributeData, splitAttribute.getTitle())
            result.add(data)
            return result
        }

        Map<String, Integer> attributeValuePositionMap = new HashMap<String, Integer>()
        for (int i = 0; i < attributeData.length; i++) {
            String dataValue = attributeData[i]
            if (attributeValuePositionMap.containsKey(dataValue)) {
                int dataValueIndex = attributeValuePositionMap.get(dataValue)
//                println "attrDataLength: ${attributeData.length}"
                result.get(dataValueIndex)[i + 1] = CONTAINS_ATTRIBUTE_VALUE
            } else {
                String[] newColumn = initializeArrayWithValue(attributeData.length + 1, DOES_NOT_CONTAIN_ATTRIBUTE_VALUE)
                newColumn[0] = splitAttribute.title + ":" + dataValue
                newColumn[i + 1] = CONTAINS_ATTRIBUTE_VALUE
                result.add(newColumn)
                attributeValuePositionMap.put(dataValue, result.size() - 1)
            }
        }

        return result
    }

    private String[] addAttributeTitleToData(String[] data, String title) {
        String[] result = new String[data.length + 1]
        result[0] = title
        for (int i = 1; i < result.length; i++) {
            result[i] = data[i - 1]
        }
        return result
    }

    private String[][] getDatasetAttributesData(Dataset dataset) {
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath(FileUploadService.DATASET_UPLOAD_DIRECTORY)

        File file = new File(storagePath + "/" + dataset.getDataFile())

        DatasetAttributeParser dap = new DatasetAttributeParser(file, dataset.getMissingValuePattern(), DatasetService.DEFAULT_DELIMITER)
        return dap.parseDatasetToArrays()
    }

    private boolean attributesBelongsToDataset(Dataset dataset, Map<Attribute, Boolean> attributesToSplit) {
        attributesToSplit.each { key, value ->
            if (!key.dataset.equals(dataset)) {
                return false
            }
        }
        return true
    }

    private String[] initializeArrayWithValue(int length, String value) {
        String[] array = new String[length]
        for (int i = 0; i < array.length; i++) {
            array[i] = value
        }
        return array
    }
}
