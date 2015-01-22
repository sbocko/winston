package winston

class AnalysisResult {
    double rmse

    static belongsTo = [analysis: Analysis]

    static constraints = {
    }
}
