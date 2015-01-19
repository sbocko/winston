<%@ page import="winston.Analysis" %>



<div class="fieldcontain ${hasErrors(bean: analysisInstance, field: 'dataFile', 'error')} required">
	<label for="dataFile">
		<g:message code="analysis.dataFile.label" default="Data File" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="dataFile" required="" value="${analysisInstance?.dataFile}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: analysisInstance, field: 'dataset', 'error')} required">
	<label for="dataset">
		<g:message code="analysis.dataset.label" default="Dataset" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="dataset" name="dataset.id" from="${winston.Dataset.list()}" optionKey="id" required="" value="${analysisInstance?.dataset?.id}" class="many-to-one"/>

</div>

