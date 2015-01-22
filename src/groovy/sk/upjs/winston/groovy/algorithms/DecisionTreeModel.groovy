package sk.upjs.winston.groovy.algorithms

import weka.classifiers.Evaluation
import weka.classifiers.trees.J48
import weka.core.Instances
import winston.Analysis
import winston.AnalysisResult
import winston.Dataset
import winston.DecisionTreeResult

/**
 * Class for performing decision tree analysis of datasets using J48 algorithm.
 * Created by stefan on 6/12/14.
 */
public class DecisionTreeModel extends Model {
    public static final float PRUNING_CONFIDENCE_STEP = 0.05f
    public static final float PRUNING_CONFIDENCE_MAX = 0.5f
    public static final float PRUNING_CONFIDENCE_MIN = 0
    public static final int MIN_NUMBER_OF_INSTANCES_PER_LEAF_STEP = 5
    public static final int MIN_NUMBER_OF_INSTANCES_PER_LEAF_MIN_SEARCH_VALUE = 0
    public static final int MIN_NUMBER_OF_INSTANCES_PER_LEAF_MAX_SEARCH_VALUE = 1000

    /**
     * Performes j48 decision tree algorithm and evaluates results 10 times with 10-fold cross validation method.
     * Returnes the mean squared error for given model.
     *
     * @param dataInstances analysis instances
     * @param m minimum number of instances per leaf parameter of J48 algorithm
     * @param c pruning confidence parameter of J48 algorithm
     * @param unpruned whether tree should be unpruned or not
     * @return root mean squared error
     */
    public double j48DecisionTreeAnalysis(Instances dataInstances, int m, float c, boolean unpruned) {
        J48 j48 = new J48()
        j48.setMinNumObj(m)
        j48.setConfidenceFactor(c)
        j48.setUnpruned(unpruned)
        Evaluation evaluation = null
        try {
            evaluation = new Evaluation(dataInstances)
            evaluation.crossValidateModel(j48, dataInstances, 10, new Random(1))
        } catch (Exception e) {
//            e.printStackTrace()
            return ERROR_DURING_CLASSIFICATION
        }
        return evaluation.rootMeanSquaredError()
    }

    /**
     * Performs j48 decision tree analysis for c=0..0,5 (PRUNING_CONFIDENCE_MIN and PRUNING_CONFIDENCE_MAX)
     * with step 0.05 (PRUNING_CONFIDENCE_STEP),
     * m=0,1,2,3,4,5..1000 with step of 5 from values bigger than 5
     * for both, unpruned and pruned trees.
     * When something goes wrong during search, the result of this search is not included in result set.
     *
     * @param analysis analysis details which belongs to returned search result
     * @param dataInstances dataset instances
     * @return Set of DecisionTreeResult instances
     */
    public Set<AnalysisResult> j48Search(Analysis analysis, Instances dataInstances) {
        Set<AnalysisResult> results = new HashSet<AnalysisResult>()

        for (float c = PRUNING_CONFIDENCE_MIN; c <= PRUNING_CONFIDENCE_MAX; c += PRUNING_CONFIDENCE_STEP) {
            double rmse
            //first 5 values with step of 1
            //from 5..1000 (MIN_NUMBER_OF_INSTANCES_PER_LEAF_MAX_SEARCH_VALUE) with step of 5 (MIN_NUMBER_OF_INSTANCES_PER_LEAF_STEP)
            for (int m = MIN_NUMBER_OF_INSTANCES_PER_LEAF_MIN_SEARCH_VALUE; m < MIN_NUMBER_OF_INSTANCES_PER_LEAF_MAX_SEARCH_VALUE; m += getNextStepForMinimumNumberOfInstancesPerLeaf(m)) {
                //both pruned and unpruned results
                for (boolean unpruned = false; unpruned != true; unpruned = true) {
                    rmse = j48DecisionTreeAnalysis(dataInstances, m, c, unpruned)

                    if (rmse != ERROR_DURING_CLASSIFICATION) {
                        AnalysisResult res = new DecisionTreeResult(analysis: analysis, rmse: rmse, confidenceFactor: c, minimumNumberOfInstancesPerLeaf: m, unpruned: unpruned)
                        results.add(res)
                    }
                }
            }
        }
        return results
    }

    /**
     * Generates the random value from interval <from,to)
     * which represents the minimum number of instances per leaf
     * of the j48 decision tree algorithm.
     *
     * @param from min value for the generated random number (inclusive)
     * @param to max value for the generated random number (exclusive)
     * @return the random int value
     */
    public int getRandomParameterM(int from, int to) {
        if (from > to) {
            int f = from
            from = to
            to = f
        }
        return from + (int) (Math.random() * (to - from))
    }

    /**
     * Generates the random value from interval <from,to)
     * which represents the pruning confidence of the j48 decision tree algorihm.
     *
     * @param from min value for the generated random number (inclusive)
     * @param to max value for the generated random number (exclusive)
     * @return the random float value
     */
    public float getRandomParameterC(float from, float to) {
        if (from > to) {
            float f = from
            from = to
            to = f
        }
        return from + (float) (Math.random() * (to - from))
    }

    /**
     * Generates a random value for pruning parameter of j48 decision tree algorithm.
     *
     * @return the random boolean value with equal probability for true and false
     */
    public boolean getRandomParameterUnpruned() {
        return Math.random() < 0.5d
    }

    /**
     * Performes j48 decision tree algorithm with random
     * hyperparameter and evaluates results 10 times with 10-fold cross validation method.
     * Returnes the DecisionTreeSearchResult object for given model.
     *
     * @param dataInstances dataset instances
     * @param dataset dataset details which belongs to returned search result
     * @return decision tree search result object
     */
    public AnalysisResult j48DecisionTreeRandomAnalysis(Instances dataInstances, Dataset dataset) {
        int m = getRandomParameterM(MIN_NUMBER_OF_INSTANCES_PER_LEAF_MIN_SEARCH_VALUE, MIN_NUMBER_OF_INSTANCES_PER_LEAF_MAX_SEARCH_VALUE * 5)
        float c = getRandomParameterC(PRUNING_CONFIDENCE_MIN, PRUNING_CONFIDENCE_MAX * 2)
        boolean unpruned = getRandomParameterUnpruned()
        return new DecisionTreeResult(dataset, j48DecisionTreeAnalysis(dataInstances, m, c, unpruned), c, m, unpruned)
    }

    /**
     * Returns the size of next step for minimum number of instances per leaf. When the last value was smaller than 5, step size is 1.
     * When the last value is bigger, than the step size is MIN_NUMBER_OF_INSTANCES_PER_LEAF_STEP (5).
     *
     * @param currentValue last value for minimum number of instances per leaf parameter of J48 algorithm
     * @return size of next step for grid search
     */
    private int getNextStepForMinimumNumberOfInstancesPerLeaf(int currentValue) {
        if (currentValue < 5) {
            return 1
        }
        return MIN_NUMBER_OF_INSTANCES_PER_LEAF_STEP
    }

}
