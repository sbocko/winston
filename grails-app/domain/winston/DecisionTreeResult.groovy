package winston

class DecisionTreeResult extends AnalysisResult{
    double confidenceFactor;
    int minimumNumberOfInstancesPerLeaf;
    boolean unpruned;

    public DecisionTreeResult(Analysis analysis, double rmse, double confidenceFactor, int minimumNumberOfInstancesPerLeaf, boolean unpruned) {
        this.analysis = analysis
        this.rmse = rmse
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
