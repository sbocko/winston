<%@ page import="winston.RegressionTreeResult" %>



<div class="fieldcontain ${hasErrors(bean: regressionTreeResultInstance, field: 'summary', 'error')} required">
	<label for="summary">
		<g:message code="regressionTreeResult.summary.label" default="Summary" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="summary" cols="40" rows="5" maxlength="1000" required="" value="${regressionTreeResultInstance?.summary}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: regressionTreeResultInstance, field: 'analysis', 'error')} required">
	<label for="analysis">
		<g:message code="regressionTreeResult.analysis.label" default="Analysis" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="analysis" name="analysis.id" from="${winston.Analysis.list()}" optionKey="id" required="" value="${regressionTreeResultInstance?.analysis?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: regressionTreeResultInstance, field: 'correctlyClassified', 'error')} required">
	<label for="correctlyClassified">
		<g:message code="regressionTreeResult.correctlyClassified.label" default="Correctly Classified" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="correctlyClassified" type="number" value="${regressionTreeResultInstance.correctlyClassified}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: regressionTreeResultInstance, field: 'incorrectlyClassified', 'error')} required">
	<label for="incorrectlyClassified">
		<g:message code="regressionTreeResult.incorrectlyClassified.label" default="Incorrectly Classified" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="incorrectlyClassified" type="number" value="${regressionTreeResultInstance.incorrectlyClassified}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: regressionTreeResultInstance, field: 'meanAbsoluteError', 'error')} required">
	<label for="meanAbsoluteError">
		<g:message code="regressionTreeResult.meanAbsoluteError.label" default="Mean Absolute Error" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="meanAbsoluteError" value="${fieldValue(bean: regressionTreeResultInstance, field: 'meanAbsoluteError')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: regressionTreeResultInstance, field: 'minimumNumberOfInstancesPerLeaf', 'error')} required">
	<label for="minimumNumberOfInstancesPerLeaf">
		<g:message code="regressionTreeResult.minimumNumberOfInstancesPerLeaf.label" default="Minimum Number Of Instances Per Leaf" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="minimumNumberOfInstancesPerLeaf" type="number" value="${regressionTreeResultInstance.minimumNumberOfInstancesPerLeaf}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: regressionTreeResultInstance, field: 'minimumVarianceForSplit', 'error')} required">
	<label for="minimumVarianceForSplit">
		<g:message code="regressionTreeResult.minimumVarianceForSplit.label" default="Minimum Variance For Split" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="minimumVarianceForSplit" value="${fieldValue(bean: regressionTreeResultInstance, field: 'minimumVarianceForSplit')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: regressionTreeResultInstance, field: 'numberOfFolds', 'error')} required">
	<label for="numberOfFolds">
		<g:message code="regressionTreeResult.numberOfFolds.label" default="Number Of Folds" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="numberOfFolds" type="number" value="${regressionTreeResultInstance.numberOfFolds}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: regressionTreeResultInstance, field: 'rmse', 'error')} required">
	<label for="rmse">
		<g:message code="regressionTreeResult.rmse.label" default="Rmse" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="rmse" value="${fieldValue(bean: regressionTreeResultInstance, field: 'rmse')}" required=""/>

</div>

