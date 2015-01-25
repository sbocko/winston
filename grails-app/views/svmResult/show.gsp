
<%@ page import="winston.SvmResult" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'svmResult.label', default: 'SvmResult')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-svmResult" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-svmResult" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list svmResult">
			
				<g:if test="${svmResultInstance?.analysis}">
				<li class="fieldcontain">
					<span id="analysis-label" class="property-label"><g:message code="svmResult.analysis.label" default="Analysis" /></span>
					
						<span class="property-value" aria-labelledby="analysis-label"><g:link controller="analysis" action="show" id="${svmResultInstance?.analysis?.id}">${svmResultInstance?.analysis?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${svmResultInstance?.complexityConstant}">
				<li class="fieldcontain">
					<span id="complexityConstant-label" class="property-label"><g:message code="svmResult.complexityConstant.label" default="Complexity Constant" /></span>
					
						<span class="property-value" aria-labelledby="complexityConstant-label"><g:fieldValue bean="${svmResultInstance}" field="complexityConstant"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${svmResultInstance?.gamma}">
				<li class="fieldcontain">
					<span id="gamma-label" class="property-label"><g:message code="svmResult.gamma.label" default="Gamma" /></span>
					
						<span class="property-value" aria-labelledby="gamma-label"><g:fieldValue bean="${svmResultInstance}" field="gamma"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${svmResultInstance?.kernel}">
				<li class="fieldcontain">
					<span id="kernel-label" class="property-label"><g:message code="svmResult.kernel.label" default="Kernel" /></span>
					
						<span class="property-value" aria-labelledby="kernel-label"><g:fieldValue bean="${svmResultInstance}" field="kernel"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${svmResultInstance?.rmse}">
				<li class="fieldcontain">
					<span id="rmse-label" class="property-label"><g:message code="svmResult.rmse.label" default="Rmse" /></span>
					
						<span class="property-value" aria-labelledby="rmse-label"><g:fieldValue bean="${svmResultInstance}" field="rmse"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:svmResultInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${svmResultInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
