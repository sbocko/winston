<%@ page import="winston.AnalysisResult" %>



<div class="fieldcontain ${hasErrors(bean: analysisResultInstance, field: 'analysis', 'error')} required">
	<label for="analysis">
		<g:message code="analysisResult.analysis.label" default="Analysis" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="analysis" name="analysis.id" from="${winston.Analysis.list()}" optionKey="id" required="" value="${analysisResultInstance?.analysis?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: analysisResultInstance, field: 'rmse', 'error')} required">
	<label for="rmse">
		<g:message code="analysisResult.rmse.label" default="Rmse" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="rmse" value="${fieldValue(bean: analysisResultInstance, field: 'rmse')}" required=""/>

</div>

