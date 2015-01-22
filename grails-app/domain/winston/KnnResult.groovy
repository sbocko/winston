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
}
