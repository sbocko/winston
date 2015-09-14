package winston

class AprioriResult extends AnalysisResult {
    int numberOfRules
    String associationRules;

    AprioriResult(analysis, Double rmse, Double meanAbsoluteError, Integer correctlyClassified, Integer incorrectlyClassified, String summary, analysis1, int numberOfRules) {
        super(analysis, rmse, meanAbsoluteError, correctlyClassified, incorrectlyClassified, summary)
        this.numberOfRules = numberOfRules
    }

    static constraints = {
    }

    static mapping = {
        associationRules type: 'text'
    }

    @Override
    public String toString() {
        return "AprioriResult{" +
                "id=" + id +
                ", numberOfRules=" + numberOfRules +
                ", associationRules='" + associationRules + '\'' +
                ", version=" + version +
                ", analysis=" + analysis +
                '}';
    }
}
