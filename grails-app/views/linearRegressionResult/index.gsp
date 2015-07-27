
<%@ page import="winston.LinearRegressionResult" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'linearRegressionResult.label', default: 'LinearRegressionResult')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-linearRegressionResult" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-linearRegressionResult" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="summary" title="${message(code: 'linearRegressionResult.summary.label', default: 'Summary')}" />
					
						<th><g:message code="linearRegressionResult.analysis.label" default="Analysis" /></th>
					
						<g:sortableColumn property="correctlyClassified" title="${message(code: 'linearRegressionResult.correctlyClassified.label', default: 'Correctly Classified')}" />
					
						<g:sortableColumn property="incorrectlyClassified" title="${message(code: 'linearRegressionResult.incorrectlyClassified.label', default: 'Incorrectly Classified')}" />
					
						<g:sortableColumn property="meanAbsoluteError" title="${message(code: 'linearRegressionResult.meanAbsoluteError.label', default: 'Mean Absolute Error')}" />
					
						<g:sortableColumn property="ridge" title="${message(code: 'linearRegressionResult.ridge.label', default: 'Ridge')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${linearRegressionResultInstanceList}" status="i" var="linearRegressionResultInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${linearRegressionResultInstance.id}">${fieldValue(bean: linearRegressionResultInstance, field: "summary")}</g:link></td>
					
						<td>${fieldValue(bean: linearRegressionResultInstance, field: "analysis")}</td>
					
						<td>${fieldValue(bean: linearRegressionResultInstance, field: "correctlyClassified")}</td>
					
						<td>${fieldValue(bean: linearRegressionResultInstance, field: "incorrectlyClassified")}</td>
					
						<td>${fieldValue(bean: linearRegressionResultInstance, field: "meanAbsoluteError")}</td>
					
						<td>${fieldValue(bean: linearRegressionResultInstance, field: "ridge")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${linearRegressionResultInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
