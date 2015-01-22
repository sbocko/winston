package sk.upjs.winston.groovy.algorithms

import weka.classifiers.Evaluation
import weka.classifiers.functions.LibSVM
import weka.core.Instances
import weka.core.SelectedTag
import winston.Analysis
import winston.AnalysisResult
import winston.SvmResult

/**
 * Class for performing SVM (SMO) analysis of datasets.
 * Created by stefan on 7/5/14.
 */
public class SvmModel extends Model {
    public static final double MIN_C = 0.1;
    public static final double MAX_C = 10.0;
    public static final double STEP_C = 0.1;
    public static final double MIN_G = 0.00001
    public static final double MAX_G = 10
    public static final double MULTIPLICATION_STEP_G = 10;

    /**
     * Performes SMO algorithm and evaluates results 10 times with 10-fold cross validation method.
     * Returnes the mean squared error for given model.
     *
     * WARNING: Surpresses the System.out
     *
     * @param dataInstances dataset instances
     * @param kernel SVM kernel to use
     * @param complexityConstant -C parameter of SMO algorithm
     * @param gamma gamma parameter of libsvm
     * @return root mean squared error
     */
    public double svm(Instances dataInstances, String kernel, double complexityConstant, double gamma) {
        PrintStream printStreamOriginal=System.out;
        System.setOut(new PrintStream(new OutputStream() {
            public void write(int b) {}
        }));

        LibSVM svm = new LibSVM();
        svm.setCost(complexityConstant);
        svm.setGamma(gamma);

        if (kernel == SvmResult.KERNEL_LINEAR_KERNEL) {
            svm.setKernelType(new SelectedTag(LibSVM.KERNELTYPE_LINEAR, LibSVM.TAGS_KERNELTYPE))
        }

        try {
            svm.buildClassifier(dataInstances);
            Evaluation evaluation = new Evaluation(dataInstances);
            evaluation.crossValidateModel(svm, dataInstances, 5, new Random(1));

            System.setOut(printStreamOriginal);
            return evaluation.rootMeanSquaredError()
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.setOut(printStreamOriginal);

        return Model.ERROR_DURING_CLASSIFICATION
    }

    /**
     * Performs SVM for kernels (LinearKernel, RBFKernel)
     * with default parameters, complexity constant C=MIN_C..MAX_C with step STEP_C and
     * gamma P=MIN_G..MAX_G with step MULTIPLICATION_STEP_G. Returns RMSE for every values combination.
     * When something goes wrong during search, the result of this search is not included in result set.
     * @param analysis analysis details which belongs to returned search result
     * @param dataInstances dataset instances
     * @return Set of SvmResult instances
     */
    public Set<AnalysisResult> svmSearch(Analysis analysis, Instances dataInstances) {
        Set<AnalysisResult> results = new HashSet<AnalysisResult>();
        double rmse

        for (double c = MIN_C; c <= MAX_C; c += STEP_C) {
            for (double g = MIN_G; g <= MAX_G; g *= MULTIPLICATION_STEP_G) {
                rmse = svm(dataInstances, SvmResult.KERNEL_RBF_KERNEL, c, g)
                SvmResult svmResult = new SvmResult(analysis: analysis, rmse: rmse, kernel: SvmResult.KERNEL_RBF_KERNEL, complexityConstant: c, gamma: g);
                results.add(svmResult);
                rmse = svm(dataInstances, SvmResult.KERNEL_LINEAR_KERNEL, c, g)
                SvmResult svmResult2 = new SvmResult(analysis: analysis, rmse: rmse, kernel: SvmResult.KERNEL_LINEAR_KERNEL, complexityConstant: c, gamma: g);
                results.add(svmResult2);
            }
        }
        return results;
    }

/**
 * Performes SVM algorithm with random
 * hyperparameter values and evaluates results 10 times with 10-fold cross validation method.
 * Returnes the SvmResult object for given model.
 *
 * @param dataInstances dataset instances
 * @param analysis analysis details which belongs to returned search result
 *
 * @return svm search result object
 */
    public SvmResult svmRandomAnalysis(Instances dataInstances, Analysis analysis) {
        String kernel = getRandomParameterKernel();
        double complexityConstant = getRandomParameterComplexityConstant(MIN_C, MAX_C * 5);
        double gamma = getRandomParameterGamma(MIN_G, MAX_G);
        if (kernel.equals(SvmResult.KERNEL_RBF_KERNEL)) {
            return new SvmResult(analysis: analysis, rmse: svm(dataInstances, kernel, complexityConstant, gamma), kernel: SvmResult.KERNEL_RBF_KERNEL, complexityConstant: complexityConstant, gamma: gamma);
        } else {
            return new SvmResult(analysis: analysis, rmse: svm(dataInstances, kernel, complexityConstant, gamma), kernel: SvmResult.KERNEL_LINEAR_KERNEL, complexityConstant: complexityConstant, gamma: gamma);
        }
        return null;
    }

/**
 * Generates a random kernel parameter for SVM algorithm.
 * Possible kernels are: StringKernel, PolyKernel, NormalizedPolyKernel, RBFKernel.
 * Each kernel has equal probability to be chosen.
 *
 * @return the random kernel instance
 */
    public String getRandomParameterKernel() {
        double rand = Math.random();
        if (rand < 0.5d) {
            return SvmResult.KERNEL_LINEAR_KERNEL;
        }
        return SvmResult.KERNEL_RBF_KERNEL;
    }

/**
 * Generates a random value for complexity constant parameter of SVM algorithm.
 *
 * @param from min value for the generated random number (inclusive)
 * @param to max value for the generated random number (exclusive)
 * @return the random double value
 */
    public double getRandomParameterComplexityConstant(double from, double to) {
        if (from > to) {
            double f = from;
            from = to;
            to = f;
        }
        return from + Math.random() * (to - from);
    }

/**
 * Generates a random value for gamma parameter of SVM algorithm.
 *
 * @param from min value for the generated random number (inclusive)
 * @param to max value for the generated random number (exclusive)
 * @return the random double value
 */
    public double getRandomParameterGamma(double from, double to) {
        if (from > to) {
            double f = from;
            from = to;
            to = f;
        }
        return from + Math.random() * (to - from);
    }

}
