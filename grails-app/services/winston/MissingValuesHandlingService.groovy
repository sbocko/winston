package winston

import grails.transaction.Transactional
import weka.core.Instances

@Transactional
class MissingValuesHandlingService {

    public Instances replaceMissingValuesByMeanInNumericAttribute(Instances instances, Attribute datasetAttribute, String missingValue) {
        for (int i = 0; i < instances.numInstances(); i++) {
            int positionOfAttribute = datasetAttribute.getPositionInDataFile()
            def instanceValue = instances.instance(i).value(positionOfAttribute)
            if (missingValue.equals(instanceValue)) {
                instances.instance(i).setValue(positionOfAttribute, datasetAttribute.getAverage())
            }
        }
        return instances
    }

    def replaceMissingValuesByMajorValueInNumericAttribute(Instances instances, NumericAttribute datasetAttribute, String missingValue) {
        double newValue = getMajorValueForAttribute(instances, datasetAttribute)

        for (int i = 0; i < instances.numInstances(); i++) {
            int positionOfAttribute = datasetAttribute.getPositionInDataFile()
            def instanceValue = instances.instance(i).value(positionOfAttribute)
            if (missingValue.equals(instanceValue)) {
                instances.instance(i).setValue(positionOfAttribute, newValue)
            }
        }
    }

    /** HELPER METHODS */

    private double getMajorValueForAttribute(Instances instances, Attribute datasetAttribute) {
        Map<Double, Integer> occurences = new HashMap<Double, Integer>()
        for (int i = 0; i < instances.numInstances(); i++) {
            double value = instances.instance(i).value(datasetAttribute.getPositionInDataFile())
            if (occurences.containsKey(value)) {
                occurences.put(value, occurences.get(value) + 1)
            } else {
                occurences.put(value, 1)
            }
        }
        return getMostCommonValue(occurences)
    }

    private double getMostCommonValue(Map<Double, Integer> map) {
        int maxCount = Integer.MIN_VALUE
        double result = Double.NaN
        for (Map.Entry<Double,Integer>  entry: map.entrySet()) {
            if(maxCount < entry.value){
                maxCount = entry.value
                result = entry.key
            }
        }
        return result
    }
}
