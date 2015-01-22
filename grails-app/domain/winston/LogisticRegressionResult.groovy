package winston

class LogisticRegressionResult extends AnalysisResult{
    public static final int ITERATE_UNTIL_CONVERGENCE = -1;
    double ridge;
    int maximumNumberOfIterations;

    public LogisticRegressionResult(Analysis analysis, double rmse, double ridge, int maximumNumberOfIterations) {
        this.analysis = analysis
        this.rmse = rmse
        this.ridge = ridge
        this.maximumNumberOfIterations = maximumNumberOfIterations
    }
    static constraints = {
    }
}
