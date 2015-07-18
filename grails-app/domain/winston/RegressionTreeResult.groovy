package winston

class RegressionTreeResult extends AnalysisResult{
    int minimumNumberOfInstancesPerLeaf;
    int minimumVarianceForSplit;
    int numberOfFolds;

    public RegressionTreeResult(analysis, Double rmse, Double meanAbsoluteError, Integer correctlyClassified, Integer incorrectlyClassified, String summary, analysis1, int minimumNumberOfInstancesPerLeaf, int minimumVarianceForSplit, int numberOfFolds) {
        super(analysis, rmse, meanAbsoluteError, correctlyClassified, incorrectlyClassified, summary)
        this.minimumNumberOfInstancesPerLeaf = minimumNumberOfInstancesPerLeaf
        this.minimumVarianceForSplit = minimumVarianceForSplit
        this.numberOfFolds = numberOfFolds
    }

    static constraints = {
    }

    @Override
    public String toString() {
        return "RegressionTreeResult{" +
                "id=" + id +
                ", minimumNumberOfInstancesPerLeaf=" + minimumNumberOfInstancesPerLeaf +
                ", minimumVarianceForSplit=" + minimumVarianceForSplit +
                ", numberOfFolds=" + numberOfFolds +
                ", version=" + version +
                ", analysis=" + analysis +
                '}';
    }
}
