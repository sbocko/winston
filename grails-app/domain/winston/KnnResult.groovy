package winston

class KnnResult extends AnalysisResult {
    int k

    public KnnResult(Analysis analysis, Double rmse, Double meanAbsoluteError, Integer correctlyClassified, Integer incorrectlyClassified, String summary, int k) {
        super(analysis, rmse, meanAbsoluteError, correctlyClassified, incorrectlyClassified, summary)
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
