package winston

import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.codehaus.groovy.grails.web.mapping.LinkGenerator
import sk.upjs.winston.groovy.algorithms.DecisionTreeModel
import sk.upjs.winston.groovy.algorithms.KnnModel
import sk.upjs.winston.groovy.algorithms.LogisticRegressionModel
import sk.upjs.winston.groovy.algorithms.SvmModel
import weka.classifiers.Evaluation
import weka.core.Instances

@Transactional
class ModellingService {
    def analysisService

    def performRecommendedDataMiningMethodForAnalysis(Analysis analysis) {
        AnalysisResult recommendedMethod = getRecommendedMethod(analysis)
        if (!recommendedMethod) {
            println "no method to recommend"
            return
        }

        BufferedReader r = new BufferedReader(
                new FileReader(getArffFileForAnalysis(analysis)))
        Instances instances = new Instances(r)
        instances.setClassIndex(instances.numAttributes() - 1)
        r.close()

        if (recommendedMethod instanceof KnnResult) {
            int k = recommendedMethod.getK()
            Evaluation trained = (new KnnModel()).knn(instances, k)
            if (trained != null) {
                double rmse = trained.rootMeanSquaredError()
                double meanAbsoluteError = trained.meanAbsoluteError()
                int correct = trained.correct()
                int incorrect = trained.incorrect()
                String sumamry = trained.toSummaryString()
                KnnResult knn = new KnnResult(analysis, rmse, meanAbsoluteError, correct, incorrect, sumamry, k)
                analysis.addToResults(knn)
            }
        } else if (recommendedMethod instanceof LogisticRegressionResult) {
            double ridge = recommendedMethod.getRidge()
            int maximumNumberOfIterations = recommendedMethod.getMaximumNumberOfIterations()
            Evaluation trained = (new LogisticRegressionModel()).logisticRegression(instances, ridge, maximumNumberOfIterations)
            if (trained != null) {
                double rmse = trained.rootMeanSquaredError()
                double meanAbsoluteError = trained.meanAbsoluteError()
                int correct = trained.correct()
                int incorrect = trained.incorrect()
                String sumamry = trained.toSummaryString()
                LogisticRegressionResult logisticRegression = new LogisticRegressionResult(analysis, rmse, meanAbsoluteError, correct, incorrect, sumamry, ridge, maximumNumberOfIterations)
                analysis.addToResults(logisticRegression)
            }
        } else if (recommendedMethod instanceof DecisionTreeResult) {
            int m = recommendedMethod.getMinimumNumberOfInstancesPerLeaf()
            float c = recommendedMethod.getConfidenceFactor()
            boolean unpruned = recommendedMethod.getUnpruned()
            Evaluation trained = (new DecisionTreeModel()).j48DecisionTreeAnalysis(instances, m, c, unpruned)
            if (trained != null) {
                double rmse = trained.rootMeanSquaredError()
                double meanAbsoluteError = trained.meanAbsoluteError()
                int correct = trained.correct()
                int incorrect = trained.incorrect()
                String sumamry = trained.toSummaryString()
                DecisionTreeResult decisionTree = new DecisionTreeResult(analysis, rmse, meanAbsoluteError, correct, incorrect, sumamry, c, m, unpruned)
                analysis.addToResults(decisionTree)
            }
        } else if (recommendedMethod instanceof SvmResult) {
            String kernel = recommendedMethod.getKernel()
            double complexityConstant = recommendedMethod.getComplexityConstant()
            double gamma = recommendedMethod.getGamma()
            Evaluation trained = (new SvmModel()).svm(instances, kernel, complexityConstant, gamma)
            if (trained != null) {
                double rmse = trained.rootMeanSquaredError()
                double meanAbsoluteError = trained.meanAbsoluteError()
                int correct = trained.correct()
                int incorrect = trained.incorrect()
                String sumamry = trained.toSummaryString()
                SvmResult svm = new SvmResult(analysis, rmse, meanAbsoluteError, correct, incorrect, sumamry, kernel, complexityConstant, gamma)
                analysis.addToResults(svm)
            }
        }
        analysis.save(flush: true)
    }


    def performAnalysisWithDefaultHyperparameters(Analysis analysis) {
        File arffFile = getArffFileForAnalysis(analysis)

        BufferedReader reader = new BufferedReader(
                new FileReader(arffFile));
        Instances dataInstances = new Instances(reader);
        reader.close();
        dataInstances.setClassIndex(dataInstances.numAttributes() - 1);

        Evaluation trained = (new KnnModel()).knn(dataInstances, KnnModel.DEFAULT_KNN_PARAMETER_K)
        if (trained != null) {
            double rmse = trained.rootMeanSquaredError()
            double meanAbsoluteError = trained.meanAbsoluteError()
            int correct = trained.correct()
            int incorrect = trained.incorrect()
            String sumamry = trained.toSummaryString()
            AnalysisResult res = new KnnResult(analysis, rmse, meanAbsoluteError, correct, incorrect, sumamry, KnnModel.DEFAULT_KNN_PARAMETER_K)
            analysis.addToResults(res)
        }

        trained = (new DecisionTreeModel()).j48DecisionTreeAnalysis(dataInstances, DecisionTreeModel.DEFAULT_DECISION_TREE_PARAMETER_MIN_NUMBER_OF_INSTANCES,
                DecisionTreeModel.DEFAULT_DECISION_TREE_PARAMETER_PRUNING, DecisionTreeModel.DEFAULT_DECISION_TREE_PARAMETER_UNPRUNED)
        if (trained != null) {
            double rmse = trained.rootMeanSquaredError()
            double meanAbsoluteError = trained.meanAbsoluteError()
            int correct = trained.correct()
            int incorrect = trained.incorrect()
            String sumamry = trained.toSummaryString()
            AnalysisResult res = new DecisionTreeResult(analysis, rmse, meanAbsoluteError, correct, incorrect, sumamry, DecisionTreeModel.DEFAULT_DECISION_TREE_PARAMETER_PRUNING,
                    DecisionTreeModel.DEFAULT_DECISION_TREE_PARAMETER_MIN_NUMBER_OF_INSTANCES, DecisionTreeModel.DEFAULT_DECISION_TREE_PARAMETER_UNPRUNED)
            analysis.addToResults(res)
        }

        trained = (new LogisticRegressionModel()).logisticRegression(dataInstances, LogisticRegressionModel.DEFAULT_LOGISTIC_REGRESSION_PARAMETER_RIDGE, LogisticRegressionModel.DEFAULT_LOGISTIC_REGRESSION_PARAMETER_MAXIMUM_NUMBER_OF_ITERATIONS)
        if (trained != null) {
            double rmse = trained.rootMeanSquaredError()
            double meanAbsoluteError = trained.meanAbsoluteError()
            int correct = trained.correct()
            int incorrect = trained.incorrect()
            String sumamry = trained.toSummaryString()
            AnalysisResult res = new LogisticRegressionResult(analysis, rmse, meanAbsoluteError, correct, incorrect, sumamry, LogisticRegressionModel.DEFAULT_LOGISTIC_REGRESSION_PARAMETER_RIDGE, LogisticRegressionModel.DEFAULT_LOGISTIC_REGRESSION_PARAMETER_MAXIMUM_NUMBER_OF_ITERATIONS)
            analysis.addToResults(res)
        }

        trained = (new SvmModel()).svm(dataInstances, SvmModel.DEFAULT_SVM_PARAMETER_KERNEL, SvmModel.DEFAULT_SVM_PARAMETER_C_COMPLEXITY_CONSTANT, SvmModel.DEFAULT_SVM_PARAMETER_GAMMA)
        if (trained != null) {
            double rmse = trained.rootMeanSquaredError()
            double meanAbsoluteError = trained.meanAbsoluteError()
            int correct = trained.correct()
            int incorrect = trained.incorrect()
            String sumamry = trained.toSummaryString()
            AnalysisResult res = new SvmResult(analysis, rmse, meanAbsoluteError, correct, incorrect, sumamry, SvmModel.DEFAULT_SVM_PARAMETER_KERNEL, SvmModel.DEFAULT_SVM_PARAMETER_C_COMPLEXITY_CONSTANT, SvmModel.DEFAULT_SVM_PARAMETER_GAMMA)
            analysis.addToResults(res)
        }
    }

    def performGridsearchAnalysisForFile(Analysis analysis) {
        analysis.setGridSearchAnalysisInProgress(true)
        File arffFile = getArffFileForAnalysis(analysis)

        BufferedReader reader = new BufferedReader(
                new FileReader(arffFile));
        Instances dataInstances = new Instances(reader);
        reader.close();
        dataInstances.setClassIndex(dataInstances.numAttributes() - 1);

        String email = analysis.getDataset().getUser().getEmail()
        String filename = analysis.getDataFile()
        long analysisId = analysis.getId()
        runAsync {
            //this will be in its own trasaction
            //since each of these service methods are Transactional
            gridSearch(analysis, dataInstances)
            informUserByEmail(email, filename, analysisId)
        }
    }

    /**HELPER METHODS*/

    private AnalysisResult getRecommendedMethod(Analysis analysis) {
        Analysis mostSimilar = getMostSimilarAnalysis(analysis)
        if (!mostSimilar) {
            return null
        }
        return getBestMethodForAnalysis(mostSimilar)
    }

    private AnalysisResult getBestMethodForAnalysis(Analysis datasetAnalysis) {
        double minRmse = AnalysisResult.createCriteria().get {
            eq("analysis.id", datasetAnalysis.id)
            projections {
                min "rmse"
            }
            maxResults(1)
        } as double
        minRmse = Math.round(minRmse * 10e5) / 10e5d

        AnalysisResult result = AnalysisResult.createCriteria().get {
            eq("analysis.id", datasetAnalysis.id)
            le("rmse", minRmse)
            maxResults(1)
        }
        return result
    }

    private Analysis getMostSimilarAnalysis(Analysis analysis) {
        def otherProcessedAnalyses = Analysis.withCriteria {
            ne("dataset.id", analysis.getDataset().getId())
            eq("analyzedByGridSearch", true)
        }

        if (otherProcessedAnalyses.size() == 0) {
            return null
        }

        Analysis mostSimilar = otherProcessedAnalyses.get(0)
        double distance = Double.MAX_VALUE
        otherProcessedAnalyses.each { it ->
            double actualDistance = computeDistanceForAnalyses(it, analysis)
            if (actualDistance < distance) {
                distance = actualDistance
                mostSimilar = it
            }
        }

        return mostSimilar
    }

    private static final double INSTANCES_INTERVAL_SIZE = 12960 - 15d;
    private static final double ATTRIBUTES_INTERVAL_SIZE = 71 - 1d;
    private static final double MISSING_VALUES_INTERVAL_SIZE = 19692d;

    private static final double WEIGHT_ATTRIBUTES = 0.4d
    private static final double WEIGHT_INSTANCES = 0d
    private static final double WEIGHT_MISSING = 0.2d
    private static final double WEIGHT_DATATYPE = 0d
    private static final double WEIGHT_KNN = 0.1d
    private static final double WEIGHT_DECISION_TREE = 0d
    private static final double WEIGHT_LOGISTIC_REGRESSION = 0.3d
    private static final double WEIGHT_SVM = 0d

    private double computeDistanceForAnalyses(Analysis analysis1, Analysis analysis2) {
        double distance = 0d
        distance = distance + WEIGHT_ATTRIBUTES * ((Math.abs(analysis1.getNumberOfMissingValues() - analysis2.getNumberOfAttributes())) / ATTRIBUTES_INTERVAL_SIZE);
        distance = distance + WEIGHT_INSTANCES * ((Math.abs(analysis1.getNumberOfInstances() - analysis2.getNumberOfInstances())) / INSTANCES_INTERVAL_SIZE);
        distance = distance + WEIGHT_MISSING * ((Math.abs(analysis1.getNumberOfMissingValues() - analysis2.getNumberOfMissingValues())) / MISSING_VALUES_INTERVAL_SIZE);
        if (analysis1.getDataType() != analysis2.getDataType()) {
            distance = distance + 1 * WEIGHT_DATATYPE;
        }

        distance = distance + (WEIGHT_KNN * (Math.abs(defaultKnnResultForAnalysis(analysis1).getRmse() -
                defaultKnnResultForAnalysis(analysis2).getRmse())));
        distance = distance + (WEIGHT_DECISION_TREE * (Math.abs(defaultDecisionTreeResultForAnalysis(analysis1).getRmse() -
                defaultDecisionTreeResultForAnalysis(analysis2).getRmse())));
        distance = distance + (WEIGHT_LOGISTIC_REGRESSION * (Math.abs(defaultLogisticRegressionResultForAnalysis(analysis1).getRmse() -
                defaultLogisticRegressionResultForAnalysis(analysis2).getRmse())));
        distance = distance + (WEIGHT_SVM * (Math.abs(defaultSvmResultForAnalysis(analysis1).getRmse() -
                defaultSvmResultForAnalysis(analysis2).getRmse())));

        return distance;
    }

    private AnalysisResult defaultKnnResultForAnalysis(Analysis analysis) {
        def criteria = KnnResult.createCriteria()
        AnalysisResult result = criteria.get {
            eq("analysis.id", analysis.id)
            eq("k", KnnModel.DEFAULT_KNN_PARAMETER_K)
            maxResults(1)
        }
//        println "DEFAULT KNN: ${result}"
        return result
    }

    private AnalysisResult defaultDecisionTreeResultForAnalysis(Analysis analysis) {
        return DecisionTreeResult.findByAnalysisAndConfidenceFactorAndMinimumNumberOfInstancesPerLeafAndUnpruned(analysis, DecisionTreeModel.DEFAULT_DECISION_TREE_PARAMETER_PRUNING,
                DecisionTreeModel.DEFAULT_DECISION_TREE_PARAMETER_MIN_NUMBER_OF_INSTANCES, DecisionTreeModel.DEFAULT_DECISION_TREE_PARAMETER_UNPRUNED)
    }

    private AnalysisResult defaultLogisticRegressionResultForAnalysis(Analysis analysis) {
        return LogisticRegressionResult.findByAnalysisAndRidgeAndMaximumNumberOfIterations(analysis, LogisticRegressionModel.DEFAULT_LOGISTIC_REGRESSION_PARAMETER_RIDGE,
                LogisticRegressionModel.DEFAULT_LOGISTIC_REGRESSION_PARAMETER_MAXIMUM_NUMBER_OF_ITERATIONS)
    }

    private AnalysisResult defaultSvmResultForAnalysis(Analysis analysis) {
        return SvmResult.findByAnalysisAndKernelAndComplexityConstantAndGamma(analysis, SvmModel.DEFAULT_SVM_PARAMETER_KERNEL,
                SvmModel.DEFAULT_SVM_PARAMETER_C_COMPLEXITY_CONSTANT, SvmModel.DEFAULT_SVM_PARAMETER_GAMMA)
    }

    // Inject link generator
    LinkGenerator grailsLinkGenerator

    public void informUserByEmail(String email, String dataFileName, long analysisId) {
        println "preparing to send email"
        sendMail {
            to email
            subject "Winston - analysis finished: " + dataFileName
//            body 'Hello,\n\n results are waiting for you at\n\n' + grailsLinkGenerator.link(controller: 'Analysis', action: 'show', id: analysisId, absolute: true) + "\n\nThank you!"
            body 'Hello,\n\n results are waiting for you at\n\n' + "\n\nThank you!"
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
        analysis.analyzedByGridSearch = true
        analysis.gridSearchAnalysisInProgress = false
        analysis.save(flush: true)
        println "gridsearch finished"
    }

    private File getArffFileForAnalysis(Analysis analysis) {
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath(analysisService.PREPARED_DATAFILES_DIRECTORY)
        String filepath = storagePath + "/" + analysis.getDataFile()
        return new File(filepath)
    }
}
