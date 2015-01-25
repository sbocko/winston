<%@ page import="winston.DecisionTreeResult" %>



<div class="fieldcontain ${hasErrors(bean: decisionTreeResultInstance, field: 'analysis', 'error')} required">
	<label for="analysis">
		<g:message code="decisionTreeResult.analysis.label" default="Analysis" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="analysis" name="analysis.id" from="${winston.Analysis.list()}" optionKey="id" required="" value="${decisionTreeResultInstance?.analysis?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: decisionTreeResultInstance, field: 'confidenceFactor', 'error')} required">
	<label for="confidenceFactor">
		<g:message code="decisionTreeResult.confidenceFactor.label" default="Confidence Factor" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="confidenceFactor" value="${fieldValue(bean: decisionTreeResultInstance, field: 'confidenceFactor')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: decisionTreeResultInstance, field: 'minimumNumberOfInstancesPerLeaf', 'error')} required">
	<label for="minimumNumberOfInstancesPerLeaf">
		<g:message code="decisionTreeResult.minimumNumberOfInstancesPerLeaf.label" default="Minimum Number Of Instances Per Leaf" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="minimumNumberOfInstancesPerLeaf" type="number" value="${decisionTreeResultInstance.minimumNumberOfInstancesPerLeaf}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: decisionTreeResultInstance, field: 'rmse', 'error')} required">
	<label for="rmse">
		<g:message code="decisionTreeResult.rmse.label" default="Rmse" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="rmse" value="${fieldValue(bean: decisionTreeResultInstance, field: 'rmse')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: decisionTreeResultInstance, field: 'unpruned', 'error')} ">
	<label for="unpruned">
		<g:message code="decisionTreeResult.unpruned.label" default="Unpruned" />
		
	</label>
	<g:checkBox name="unpruned" value="${decisionTreeResultInstance?.unpruned}" />

</div>

