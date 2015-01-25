
<%@ page import="winston.DecisionTreeResult" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'decisionTreeResult.label', default: 'DecisionTreeResult')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-decisionTreeResult" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-decisionTreeResult" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list decisionTreeResult">
			
				<g:if test="${decisionTreeResultInstance?.analysis}">
				<li class="fieldcontain">
					<span id="analysis-label" class="property-label"><g:message code="decisionTreeResult.analysis.label" default="Analysis" /></span>
					
						<span class="property-value" aria-labelledby="analysis-label"><g:link controller="analysis" action="show" id="${decisionTreeResultInstance?.analysis?.id}">${decisionTreeResultInstance?.analysis?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${decisionTreeResultInstance?.confidenceFactor}">
				<li class="fieldcontain">
					<span id="confidenceFactor-label" class="property-label"><g:message code="decisionTreeResult.confidenceFactor.label" default="Confidence Factor" /></span>
					
						<span class="property-value" aria-labelledby="confidenceFactor-label"><g:fieldValue bean="${decisionTreeResultInstance}" field="confidenceFactor"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${decisionTreeResultInstance?.minimumNumberOfInstancesPerLeaf}">
				<li class="fieldcontain">
					<span id="minimumNumberOfInstancesPerLeaf-label" class="property-label"><g:message code="decisionTreeResult.minimumNumberOfInstancesPerLeaf.label" default="Minimum Number Of Instances Per Leaf" /></span>
					
						<span class="property-value" aria-labelledby="minimumNumberOfInstancesPerLeaf-label"><g:fieldValue bean="${decisionTreeResultInstance}" field="minimumNumberOfInstancesPerLeaf"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${decisionTreeResultInstance?.rmse}">
				<li class="fieldcontain">
					<span id="rmse-label" class="property-label"><g:message code="decisionTreeResult.rmse.label" default="Rmse" /></span>
					
						<span class="property-value" aria-labelledby="rmse-label"><g:fieldValue bean="${decisionTreeResultInstance}" field="rmse"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${decisionTreeResultInstance?.unpruned}">
				<li class="fieldcontain">
					<span id="unpruned-label" class="property-label"><g:message code="decisionTreeResult.unpruned.label" default="Unpruned" /></span>
					
						<span class="property-value" aria-labelledby="unpruned-label"><g:formatBoolean boolean="${decisionTreeResultInstance?.unpruned}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:decisionTreeResultInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${decisionTreeResultInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
