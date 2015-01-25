
<%@ page import="winston.AnalysisResult" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'analysisResult.label', default: 'AnalysisResult')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-analysisResult" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-analysisResult" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="analysisResult.analysis.label" default="Analysis" /></th>
					
						<g:sortableColumn property="rmse" title="${message(code: 'analysisResult.rmse.label', default: 'Rmse')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${analysisResultInstanceList}" status="i" var="analysisResultInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${analysisResultInstance.id}">${fieldValue(bean: analysisResultInstance, field: "analysis")}</g:link></td>
					
						<td>${fieldValue(bean: analysisResultInstance, field: "rmse")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${analysisResultInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
