package winston

class KnnResult extends AnalysisResult {
    int k

    public KnnResult(Analysis analysis, double rmse, int k) {
        this.analysis = analysis
        this.rmse = rmse
        this.k = k
    }
    static constraints = {
    }

    @Override
    public String toString() {
        return "KnnResult{" +
                "id=" + id +
                ", analysis=" + analysis +
                ", rmse=" + rmse +
                ", k=" + k +
                '}';
    }
}
