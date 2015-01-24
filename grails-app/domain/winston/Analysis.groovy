package winston

class Analysis {
    public static final String DATA_TYPE_INTEGER = "INT";
    public static final String DATA_TYPE_REAL = "REAL";
    public static final String DATA_TYPE_CATEGORICAL = "CAT";
    public static final String DATA_TYPE_MULTIVARIATE = "MULT";

    String csvDataFile
    String arffDataFile
    String dataType
    int numberOfAttributes
    boolean analyzedByGridSearch = false
    List results

    static belongsTo = [dataset: Dataset]
    static hasMany = [results: AnalysisResult]

    static constraints = {
        csvDataFile(nullable: false)
    }

    public int getNumberOfInstances() {
        return this.dataset.getNumberOfInstances()
    }

    public int getNumberOfMissingValues() {
        return this.dataset.getNumberOfMissingValues()
    }

    public String getMissingValuePattern() {
        return this.dataset.getMissingValuePattern()
    }


    @Override
    public String toString() {
        return "Analysis{" +
                "id=" + id +
                ", dataset=" + dataset +
                ", csvDataFile='" + csvDataFile + '\'' +
                ", dataType='" + dataType + '\'' +
                ", numberOfAttributes=" + numberOfAttributes +
                ", analyzedByGridSearch=" + analyzedByGridSearch +
                '}';
    }
}
