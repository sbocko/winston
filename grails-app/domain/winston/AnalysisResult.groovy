package winston

class AnalysisResult {
    public static final double RMSE_UNDEFINED = 1234567890d;
    Double rmse
    Double meanAbsoluteError
    Integer correctlyClassified
    Integer incorrectlyClassified
    String summary

    public AnalysisResult() {
    }

    public AnalysisResult(analysis, Double rmse, Double meanAbsoluteError, Integer correctlyClassified, Integer incorrectlyClassified, String summary) {
        this.analysis = analysis
        this.rmse = rmse
        this.meanAbsoluteError = meanAbsoluteError
        this.correctlyClassified = correctlyClassified
        this.incorrectlyClassified = incorrectlyClassified
        this.summary = summary
    }
    static belongsTo = [analysis: Analysis]

    static constraints = {
        summary maxSize:1000
    }
}
