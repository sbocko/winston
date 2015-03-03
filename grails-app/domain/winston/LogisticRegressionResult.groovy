package winston

class LogisticRegressionResult extends AnalysisResult{
    public static final int ITERATE_UNTIL_CONVERGENCE = -1;
    double ridge;
    int maximumNumberOfIterations;

    public LogisticRegressionResult(analysis, Double rmse, Double meanAbsoluteError, Integer correctlyClassified, Integer incorrectlyClassified, String summary, double ridge, int maximumNumberOfIterations) {
        super(analysis, rmse, meanAbsoluteError, correctlyClassified, incorrectlyClassified, summary)
        this.ridge = ridge
        this.maximumNumberOfIterations = maximumNumberOfIterations
    }

    static constraints = {
    }


    @Override
    public String toString() {
        return "LogisticRegressionResult{" +
                "id=" + id +
                ", ridge=" + ridge +
                ", maximumNumberOfIterations=" + maximumNumberOfIterations +
                ", analysis=" + analysis +
                ", rmse=" + rmse +
                '}';
    }
}
