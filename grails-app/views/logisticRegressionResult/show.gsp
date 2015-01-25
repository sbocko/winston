
<%@ page import="winston.LogisticRegressionResult" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'logisticRegressionResult.label', default: 'LogisticRegressionResult')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-logisticRegressionResult" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-logisticRegressionResult" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list logisticRegressionResult">
			
				<g:if test="${logisticRegressionResultInstance?.analysis}">
				<li class="fieldcontain">
					<span id="analysis-label" class="property-label"><g:message code="logisticRegressionResult.analysis.label" default="Analysis" /></span>
					
						<span class="property-value" aria-labelledby="analysis-label"><g:link controller="analysis" action="show" id="${logisticRegressionResultInstance?.analysis?.id}">${logisticRegressionResultInstance?.analysis?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${logisticRegressionResultInstance?.maximumNumberOfIterations}">
				<li class="fieldcontain">
					<span id="maximumNumberOfIterations-label" class="property-label"><g:message code="logisticRegressionResult.maximumNumberOfIterations.label" default="Maximum Number Of Iterations" /></span>
					
						<span class="property-value" aria-labelledby="maximumNumberOfIterations-label"><g:fieldValue bean="${logisticRegressionResultInstance}" field="maximumNumberOfIterations"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${logisticRegressionResultInstance?.ridge}">
				<li class="fieldcontain">
					<span id="ridge-label" class="property-label"><g:message code="logisticRegressionResult.ridge.label" default="Ridge" /></span>
					
						<span class="property-value" aria-labelledby="ridge-label"><g:fieldValue bean="${logisticRegressionResultInstance}" field="ridge"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${logisticRegressionResultInstance?.rmse}">
				<li class="fieldcontain">
					<span id="rmse-label" class="property-label"><g:message code="logisticRegressionResult.rmse.label" default="Rmse" /></span>
					
						<span class="property-value" aria-labelledby="rmse-label"><g:fieldValue bean="${logisticRegressionResultInstance}" field="rmse"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:logisticRegressionResultInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${logisticRegressionResultInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
