package winston

import sk.upjs.winston.User

import javax.naming.directory.AttributeInUseException

/**
 *
 * @author Stefan Bocko
 * This class is fundamental domain model which represents one dataset entry.
 * It contains metadata of dataset as well as metadata of all of its attributes. 
 *
 */
class Dataset {
    public static final String TITLE_VAR = "title"
    public static final String DATA_FILE_VAR = "dataFile"
    public static final String DESCRIPTION_VAR = "description"
    public static final String MISSING_VALUE_PATTERN_VAR = "missingValuePattern"
    public static final String NUMBER_OF_MISSING_VALUES_VAR = "numberOfMissingValues"
    public static final String NUMBER_OF_INSTANCES_VAR = "numberOfInstances"

    String title
    String dataFile
    String arffDataFile
    String description
    String missingValuePattern
    int numberOfMissingValues
    int numberOfInstances
    static hasMany = [attributes: Attribute, analyzes: Analysis]
    static belongsTo = [user: User]

    static constraints = {
        title(nullable: false)
        dataFile(nullable: false)
        description(maxSize: 5000, nullable: true)
        missingValuePattern(nullable: true)
        numberOfMissingValues()
        numberOfInstances()
    }

    public static final int NUMBER_OF_RESULTS_TO_SHOW = 5

    public List getTopAnalyzes(int maxNumberOfResults) {
        def results = AnalysisResult.findAll("from AnalysisResult ar where ar.analysis.dataset.id = " + getId() + " group by ar.analysis.id order by rmse asc", [max: 5, offset: 0])
//        def criteria = Analysis.createCriteria()
//        List<AnalysisResult> results = criteria.listDistinct() {
//            dataset {
//                eq("id", getId())
//            }
//
//            order("rmse", "asc")
//            maxResults(maxNumberOfResults)
//            groupProperty("analysis.id")
//            projections {
//                distinct("analysis")
//            }
//        }

//        return results

        List<Analysis> top = new ArrayList<Analysis>()
        results.each { it ->
            top.add(it.getAnalysis())
        }
        return top

//        def criteria = AnalysisResult.createCriteria()
//        List<AnalysisResult> results = criteria.listDistinct() {
//            analysis {
//                dataset {
//                    eq("id", getId())
//                }
//            }
//            order("rmse", "asc")
//            maxResults(maxNumberOfResults)
////            groupProperty("analysis.id")
//            projections {
//                distinct("analysis")
//            }
//        }
//
//        return results;

//        List<Analysis> top = new ArrayList<Analysis>()
//        results.each {it ->
//            println "${it.getAnalysis().getDataFile()} -  ${it.getAnalysis().getId()}"
//            top.add(it.getAnalysis())
//        }
//        return top
    }

    String toString() {
        return "${title}"
    }

}
