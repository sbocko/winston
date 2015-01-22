package winston

import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.codehaus.groovy.grails.web.mapping.LinkGenerator
import sk.upjs.winston.groovy.algorithms.DecisionTreeModel
import sk.upjs.winston.groovy.algorithms.KnnModel
import sk.upjs.winston.groovy.algorithms.LogisticRegressionModel
import sk.upjs.winston.groovy.algorithms.SvmModel
import sk.upjs.winston.groovy.converter.CSV2ArffConverter
import weka.core.Instances

@Transactional
class AnalyzeService {
    public static final String PREPARED_ARFF_DATAFILES_DIRECTORY = "/arff-datasets"

    def performGridsearchAnalysisForFile(Analysis analysis) {
        File csvFile = getCsvFileForAnalysis(analysis)
        File arffFile = createArffFileForAnalysis(analysis, csvFile)

        BufferedReader reader = new BufferedReader(
                new FileReader(arffFile));
        Instances dataInstances = new Instances(reader);
        reader.close();
        dataInstances.setClassIndex(dataInstances.numAttributes() - 1);

        runAsync {
            //this will be in its own trasaction
            //since each of these service methods are Transactional
            gridSearch(analysis, dataInstances)
            informUserByEmail(analysis)
        }
    }

    /**HELPER METHODS*/

    // Inject link generator
    LinkGenerator grailsLinkGenerator

    private void informUserByEmail(Analysis analysis) {
        sendMail {
            to analysis.getDataset().getUser().getEmail()
            subject "Winston - analysis finished: " + analysis.getDataFile()
            body 'Hello,\n\n results are waiting for you at\n\n' + grailsLinkGenerator.link(controller: 'Analysis', action: 'show', id: analysis.getId(), absolute: true) + "\n\nThank you!"
        }
        println "mail sent"
    }

    private void gridSearch(Analysis analysis, Instances dataInstances) {
        println "gridsearch started"
        analysis.refresh()
        Set<AnalysisResult> results
        //kNN
        results = (new KnnModel()).knnSearch(analysis, dataInstances)
        results.each {
            analysis.addToResults(it)
        }
        println "knn done"
        //decision tree
        results = (new DecisionTreeModel()).j48Search(analysis, dataInstances)
        results.each {
            analysis.addToResults(it)
        }
        println "dec tree done"
        //logistic regression
        results = (new LogisticRegressionModel()).logisticRegressionSearch(analysis, dataInstances)
        results.each {
            analysis.addToResults(it)
        }
        println "log reg done"
//        svm
        results = (new SvmModel()).svmSearch(analysis, dataInstances)
        results.each {
            analysis.addToResults(it)
        }
        println "svm done"
        println "gridsearch finished"
    }

    private File createArffFileForAnalysis(Analysis analysis, File csvFile) {
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath(PREPARED_ARFF_DATAFILES_DIRECTORY)
        String filepath = storagePath + "/" + analysis.getDataFile()
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

    private File getCsvFileForAnalysis(Analysis analysis) {
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath(SplitAttributeService.PREPARED_DATAFILES_DIRECTORY)
        String filepath = storagePath + "/" + analysis.getDataFile()
        return new File(filepath)
    }
}
