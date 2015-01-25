<%@ page import="winston.SvmResult" %>



<div class="fieldcontain ${hasErrors(bean: svmResultInstance, field: 'analysis', 'error')} required">
	<label for="analysis">
		<g:message code="svmResult.analysis.label" default="Analysis" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="analysis" name="analysis.id" from="${winston.Analysis.list()}" optionKey="id" required="" value="${svmResultInstance?.analysis?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: svmResultInstance, field: 'complexityConstant', 'error')} required">
	<label for="complexityConstant">
		<g:message code="svmResult.complexityConstant.label" default="Complexity Constant" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="complexityConstant" value="${fieldValue(bean: svmResultInstance, field: 'complexityConstant')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: svmResultInstance, field: 'gamma', 'error')} required">
	<label for="gamma">
		<g:message code="svmResult.gamma.label" default="Gamma" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="gamma" value="${fieldValue(bean: svmResultInstance, field: 'gamma')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: svmResultInstance, field: 'kernel', 'error')} required">
	<label for="kernel">
		<g:message code="svmResult.kernel.label" default="Kernel" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="kernel" required="" value="${svmResultInstance?.kernel}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: svmResultInstance, field: 'rmse', 'error')} required">
	<label for="rmse">
		<g:message code="svmResult.rmse.label" default="Rmse" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="rmse" value="${fieldValue(bean: svmResultInstance, field: 'rmse')}" required=""/>

</div>

