
<%@ page import="winston.DecisionTreeResult" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'decisionTreeResult.label', default: 'DecisionTreeResult')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-decisionTreeResult" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-decisionTreeResult" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="decisionTreeResult.analysis.label" default="Analysis" /></th>
					
						<g:sortableColumn property="confidenceFactor" title="${message(code: 'decisionTreeResult.confidenceFactor.label', default: 'Confidence Factor')}" />
					
						<g:sortableColumn property="minimumNumberOfInstancesPerLeaf" title="${message(code: 'decisionTreeResult.minimumNumberOfInstancesPerLeaf.label', default: 'Minimum Number Of Instances Per Leaf')}" />
					
						<g:sortableColumn property="rmse" title="${message(code: 'decisionTreeResult.rmse.label', default: 'Rmse')}" />
					
						<g:sortableColumn property="unpruned" title="${message(code: 'decisionTreeResult.unpruned.label', default: 'Unpruned')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${decisionTreeResultInstanceList}" status="i" var="decisionTreeResultInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${decisionTreeResultInstance.id}">${fieldValue(bean: decisionTreeResultInstance, field: "analysis")}</g:link></td>
					
						<td>${fieldValue(bean: decisionTreeResultInstance, field: "confidenceFactor")}</td>
					
						<td>${fieldValue(bean: decisionTreeResultInstance, field: "minimumNumberOfInstancesPerLeaf")}</td>
					
						<td>${fieldValue(bean: decisionTreeResultInstance, field: "rmse")}</td>
					
						<td><g:formatBoolean boolean="${decisionTreeResultInstance.unpruned}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${decisionTreeResultInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
