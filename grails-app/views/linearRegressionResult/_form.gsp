<%@ page import="winston.LinearRegressionResult" %>



<div class="fieldcontain ${hasErrors(bean: linearRegressionResultInstance, field: 'summary', 'error')} required">
	<label for="summary">
		<g:message code="linearRegressionResult.summary.label" default="Summary" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="summary" cols="40" rows="5" maxlength="1000" required="" value="${linearRegressionResultInstance?.summary}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: linearRegressionResultInstance, field: 'analysis', 'error')} required">
	<label for="analysis">
		<g:message code="linearRegressionResult.analysis.label" default="Analysis" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="analysis" name="analysis.id" from="${winston.Analysis.list()}" optionKey="id" required="" value="${linearRegressionResultInstance?.analysis?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: linearRegressionResultInstance, field: 'correctlyClassified', 'error')} required">
	<label for="correctlyClassified">
		<g:message code="linearRegressionResult.correctlyClassified.label" default="Correctly Classified" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="correctlyClassified" type="number" value="${linearRegressionResultInstance.correctlyClassified}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: linearRegressionResultInstance, field: 'incorrectlyClassified', 'error')} required">
	<label for="incorrectlyClassified">
		<g:message code="linearRegressionResult.incorrectlyClassified.label" default="Incorrectly Classified" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="incorrectlyClassified" type="number" value="${linearRegressionResultInstance.incorrectlyClassified}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: linearRegressionResultInstance, field: 'meanAbsoluteError', 'error')} required">
	<label for="meanAbsoluteError">
		<g:message code="linearRegressionResult.meanAbsoluteError.label" default="Mean Absolute Error" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="meanAbsoluteError" value="${fieldValue(bean: linearRegressionResultInstance, field: 'meanAbsoluteError')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: linearRegressionResultInstance, field: 'ridge', 'error')} required">
	<label for="ridge">
		<g:message code="linearRegressionResult.ridge.label" default="Ridge" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ridge" value="${fieldValue(bean: linearRegressionResultInstance, field: 'ridge')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: linearRegressionResultInstance, field: 'rmse', 'error')} required">
	<label for="rmse">
		<g:message code="linearRegressionResult.rmse.label" default="Rmse" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="rmse" value="${fieldValue(bean: linearRegressionResultInstance, field: 'rmse')}" required=""/>

</div>

