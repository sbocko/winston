
<%@ page import="winston.LogisticRegressionResult" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'logisticRegressionResult.label', default: 'LogisticRegressionResult')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-logisticRegressionResult" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-logisticRegressionResult" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="logisticRegressionResult.analysis.label" default="Analysis" /></th>
					
						<g:sortableColumn property="maximumNumberOfIterations" title="${message(code: 'logisticRegressionResult.maximumNumberOfIterations.label', default: 'Maximum Number Of Iterations')}" />
					
						<g:sortableColumn property="ridge" title="${message(code: 'logisticRegressionResult.ridge.label', default: 'Ridge')}" />
					
						<g:sortableColumn property="rmse" title="${message(code: 'logisticRegressionResult.rmse.label', default: 'Rmse')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${logisticRegressionResultInstanceList}" status="i" var="logisticRegressionResultInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${logisticRegressionResultInstance.id}">${fieldValue(bean: logisticRegressionResultInstance, field: "analysis")}</g:link></td>
					
						<td>${fieldValue(bean: logisticRegressionResultInstance, field: "maximumNumberOfIterations")}</td>
					
						<td>${fieldValue(bean: logisticRegressionResultInstance, field: "ridge")}</td>
					
						<td>${fieldValue(bean: logisticRegressionResultInstance, field: "rmse")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${logisticRegressionResultInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
