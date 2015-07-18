package winston

class SimpleKMeansResult extends AnalysisResult{
    public static final int INITIALIZATION_METHOD_RANDOM;
    public static final int INITIALIZATION_METHOD_K_MEANS_PLUS_PLUS;
    public static final int INITIALIZATION_METHOD_CANOPY;
    public static final int INITIALIZATION_METHOD_FARTHEST_FIRST;

    int numberOfClusters;
    int initializationMethod;
    int numberOfFolds;

    SimpleKMeansResult(analysis, Double rmse, Double meanAbsoluteError, Integer correctlyClassified, Integer incorrectlyClassified, String summary, analysis1, int numberOfClusters, int initializationMethod, int numberOfFolds) {
        super(analysis, rmse, meanAbsoluteError, correctlyClassified, incorrectlyClassified, summary)
        this.numberOfClusters = numberOfClusters
        this.initializationMethod = initializationMethod
        this.numberOfFolds = numberOfFolds
    }

    static constraints = {
    }

    @Override
    public String toString() {
        return "SimpleKMeansResult{" +
                "id=" + id +
                ", numberOfClusters=" + numberOfClusters +
                ", initializationMethod=" + initializationMethod +
                ", numberOfFolds=" + numberOfFolds +
                ", version=" + version +
                ", analysis=" + analysis +
                '}';
    }
}
