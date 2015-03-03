package winston

class DecisionTreeResult extends AnalysisResult{
    double confidenceFactor;
    int minimumNumberOfInstancesPerLeaf;
    boolean unpruned;

    DecisionTreeResult(Analysis analysis, Double rmse, Double meanAbsoluteError, Integer correctlyClassified, Integer incorrectlyClassified, String summary, double confidenceFactor, int minimumNumberOfInstancesPerLeaf, boolean unpruned) {
        super(analysis, rmse, meanAbsoluteError, correctlyClassified, incorrectlyClassified, summary)
        this.confidenceFactor = confidenceFactor
        this.minimumNumberOfInstancesPerLeaf = minimumNumberOfInstancesPerLeaf
        this.unpruned = unpruned
    }

    static constraints = {
    }

    @Override
    public String toString() {
        return "DecisionTreeResult{" +
                "id=" + id +
                ", analysis=" + analysis +
                ", rmse=" + rmse +
                ", confidenceFactor=" + confidenceFactor +
                ", minimumNumberOfInstancesPerLeaf=" + minimumNumberOfInstancesPerLeaf +
                ", unpruned=" + unpruned +
                '}';
    }
}
