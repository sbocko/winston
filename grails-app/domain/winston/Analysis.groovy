package winston

class Analysis {
    String dataFile
    int numberOfAttributes
    List results

    static belongsTo = [dataset: Dataset]
    static hasMany = [results: AnalysisResult]

    static constraints = {
        dataFile(nullable: false)
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
}
