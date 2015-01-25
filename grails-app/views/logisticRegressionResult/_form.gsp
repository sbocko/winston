<%@ page import="winston.LogisticRegressionResult" %>



<div class="fieldcontain ${hasErrors(bean: logisticRegressionResultInstance, field: 'analysis', 'error')} required">
	<label for="analysis">
		<g:message code="logisticRegressionResult.analysis.label" default="Analysis" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="analysis" name="analysis.id" from="${winston.Analysis.list()}" optionKey="id" required="" value="${logisticRegressionResultInstance?.analysis?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: logisticRegressionResultInstance, field: 'maximumNumberOfIterations', 'error')} required">
	<label for="maximumNumberOfIterations">
		<g:message code="logisticRegressionResult.maximumNumberOfIterations.label" default="Maximum Number Of Iterations" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="maximumNumberOfIterations" type="number" value="${logisticRegressionResultInstance.maximumNumberOfIterations}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: logisticRegressionResultInstance, field: 'ridge', 'error')} required">
	<label for="ridge">
		<g:message code="logisticRegressionResult.ridge.label" default="Ridge" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ridge" value="${fieldValue(bean: logisticRegressionResultInstance, field: 'ridge')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: logisticRegressionResultInstance, field: 'rmse', 'error')} required">
	<label for="rmse">
		<g:message code="logisticRegressionResult.rmse.label" default="Rmse" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="rmse" value="${fieldValue(bean: logisticRegressionResultInstance, field: 'rmse')}" required=""/>

</div>

