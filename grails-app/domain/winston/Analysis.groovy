package winston

class Analysis {
    public static final String DATA_TYPE_INTEGER = "INT";
    public static final String DATA_TYPE_REAL = "REAL";
    public static final String DATA_TYPE_CATEGORICAL = "CAT";
    public static final String DATA_TYPE_MULTIVARIATE = "MULT";

    public static final String TASK_CLASSIFICATION = "CLASSIFICATION";
    public static final String TASK_REGRESSION = "REGRESSION";
    public static final String TASK_PATTERN = "PATTERN";


    String dataFile
    String dataType
    String task
    int numberOfAttributes
    boolean analyzedByGridSearch = false
    boolean gridSearchAnalysisInProgress = false
    Set results

    static belongsTo = [dataset: Dataset]
    static hasMany = [results: AnalysisResult]

    static constraints = {
        dataFile(nullable: false)
        task(nullable: false)
    }

    public static final int NUMBER_OF_RESULTS_TO_SHOW = 5

    public List getTopAnalysisResults(int maxNumberOfResults) {
        def criteria = AnalysisResult.createCriteria()
        def results = criteria.list() {
            eq("analysis.id",getId())
            order("rmse", "asc")
            maxResults(maxNumberOfResults)
        }
        return results
    }

    public Double getBestRmse() {
        Double minRmse = AnalysisResult.createCriteria().get {
            eq("analysis.id", getId())
            projections {
                min "rmse"
            }
            maxResults(1)
        } as Double

        return minRmse
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
        return  "${dataset.getTitle()} analysis"
    }
}
