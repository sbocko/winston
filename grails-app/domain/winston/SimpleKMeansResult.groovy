package winston

import weka.core.Instances

class SimpleKMeansResult extends AnalysisResult{
    public static final int INITIALIZATION_METHOD_RANDOM = 0;
    public static final int INITIALIZATION_METHOD_K_MEANS_PLUS_PLUS = 1;
    public static final int INITIALIZATION_METHOD_CANOPY = 2;
    public static final int INITIALIZATION_METHOD_FARTHEST_FIRST = 3;

    int numberOfClusters;
    int initializationMethod;
    String clusterCentroids;
    String clusterSizes;

    SimpleKMeansResult(analysis, Double rmse, Double meanAbsoluteError, Integer correctlyClassified, Integer incorrectlyClassified, String summary, analysis1, int numberOfClusters, int initializationMethod, String clusterCentroids, String clusterSizes) {
        super(analysis, rmse, meanAbsoluteError, correctlyClassified, incorrectlyClassified, summary)
        this.numberOfClusters = numberOfClusters
        this.initializationMethod = initializationMethod
        this.clusterCentroids = clusterCentroids
        this.clusterSizes = clusterSizes
    }

    static constraints = {
    }

    static mapping = {
        clusterCentroids type: 'text'
        clusterSizes type: 'text'
    }

    @Override
    public String toString() {
        return "SimpleKMeansResult{" +
                "id=" + id +
                ", numberOfClusters=" + numberOfClusters +
                ", initializationMethod=" + initializationMethod +
                ", version=" + version +
                ", analysis=" + analysis +
                '}';
    }
}
