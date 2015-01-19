package winston

class Analysis {
    String dataFile

    static belongsTo = [dataset: Dataset]


    static constraints = {
        dataFile(nullable: false)
    }
}
