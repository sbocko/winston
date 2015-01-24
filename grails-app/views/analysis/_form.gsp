<%@ page import="winston.Analysis" %>



<div class="fieldcontain ${hasErrors(bean: analysisInstance, field: 'csvDataFile', 'error')} required">
	<label for="csvDataFile">
		<g:message code="analysis.csvDataFile.label" default="Csv Data File" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="csvDataFile" required="" value="${analysisInstance?.csvDataFile}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: analysisInstance, field: 'arffDataFile', 'error')} required">
	<label for="arffDataFile">
		<g:message code="analysis.arffDataFile.label" default="Arff Data File" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="arffDataFile" required="" value="${analysisInstance?.arffDataFile}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: analysisInstance, field: 'dataset', 'error')} required">
	<label for="dataset">
		<g:message code="analysis.dataset.label" default="Dataset" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="dataset" name="dataset.id" from="${winston.Dataset.list()}" optionKey="id" required="" value="${analysisInstance?.dataset?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: analysisInstance, field: 'numberOfAttributes', 'error')} required">
	<label for="numberOfAttributes">
		<g:message code="analysis.numberOfAttributes.label" default="Number Of Attributes" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="numberOfAttributes" type="number" value="${analysisInstance.numberOfAttributes}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: analysisInstance, field: 'results', 'error')} ">
	<label for="results">
		<g:message code="analysis.results.label" default="Results" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${analysisInstance?.results?}" var="r">
    <li><g:link controller="analysisResult" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="analysisResult" action="create" params="['analysis.id': analysisInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'analysisResult.label', default: 'AnalysisResult')])}</g:link>
</li>
</ul>


</div>

