package winston

class SimpleKMeansResult extends AnalysisResult{
    public static final int INITIALIZATION_METHOD_RANDOM = 0;
    public static final int INITIALIZATION_METHOD_K_MEANS_PLUS_PLUS = 1;
    public static final int INITIALIZATION_METHOD_CANOPY = 2;
    public static final int INITIALIZATION_METHOD_FARTHEST_FIRST = 3;

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
