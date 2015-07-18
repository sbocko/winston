package winston

class LinearRegressionResult extends AnalysisResult{
    double ridge;

    public LinearRegressionResult(analysis, Double rmse, Double meanAbsoluteError, Integer correctlyClassified, Integer incorrectlyClassified, String summary, analysis1, double ridge) {
        super(analysis, rmse, meanAbsoluteError, correctlyClassified, incorrectlyClassified, summary)
        this.ridge = ridge
    }

    static constraints = {
    }

    @Override
    public String toString() {
        return "LinearRegressionResult{" +
                "id=" + id +
                ", ridge=" + ridge +
                ", version=" + version +
                ", analysis=" + analysis +
                '}';
    }
}
