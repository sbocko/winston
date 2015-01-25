<%@ page import="winston.KnnResult" %>



<div class="fieldcontain ${hasErrors(bean: knnResultInstance, field: 'analysis', 'error')} required">
	<label for="analysis">
		<g:message code="knnResult.analysis.label" default="Analysis" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="analysis" name="analysis.id" from="${winston.Analysis.list()}" optionKey="id" required="" value="${knnResultInstance?.analysis?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: knnResultInstance, field: 'k', 'error')} required">
	<label for="k">
		<g:message code="knnResult.k.label" default="K" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="k" type="number" value="${knnResultInstance.k}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: knnResultInstance, field: 'rmse', 'error')} required">
	<label for="rmse">
		<g:message code="knnResult.rmse.label" default="Rmse" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="rmse" value="${fieldValue(bean: knnResultInstance, field: 'rmse')}" required=""/>

</div>

