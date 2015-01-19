package winston

class Analysis {
    String dataFile
    List results

    static belongsTo = [dataset: Dataset]
    static hasMany = [results: AnalysisResult]

    static constraints = {
        dataFile(nullable: false)
    }
}
