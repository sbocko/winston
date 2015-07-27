
<%@ page import="winston.RegressionTreeResult" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'regressionTreeResult.label', default: 'RegressionTreeResult')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-regressionTreeResult" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-regressionTreeResult" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="summary" title="${message(code: 'regressionTreeResult.summary.label', default: 'Summary')}" />
					
						<th><g:message code="regressionTreeResult.analysis.label" default="Analysis" /></th>
					
						<g:sortableColumn property="correctlyClassified" title="${message(code: 'regressionTreeResult.correctlyClassified.label', default: 'Correctly Classified')}" />
					
						<g:sortableColumn property="incorrectlyClassified" title="${message(code: 'regressionTreeResult.incorrectlyClassified.label', default: 'Incorrectly Classified')}" />
					
						<g:sortableColumn property="meanAbsoluteError" title="${message(code: 'regressionTreeResult.meanAbsoluteError.label', default: 'Mean Absolute Error')}" />
					
						<g:sortableColumn property="minimumNumberOfInstancesPerLeaf" title="${message(code: 'regressionTreeResult.minimumNumberOfInstancesPerLeaf.label', default: 'Minimum Number Of Instances Per Leaf')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${regressionTreeResultInstanceList}" status="i" var="regressionTreeResultInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${regressionTreeResultInstance.id}">${fieldValue(bean: regressionTreeResultInstance, field: "summary")}</g:link></td>
					
						<td>${fieldValue(bean: regressionTreeResultInstance, field: "analysis")}</td>
					
						<td>${fieldValue(bean: regressionTreeResultInstance, field: "correctlyClassified")}</td>
					
						<td>${fieldValue(bean: regressionTreeResultInstance, field: "incorrectlyClassified")}</td>
					
						<td>${fieldValue(bean: regressionTreeResultInstance, field: "meanAbsoluteError")}</td>
					
						<td>${fieldValue(bean: regressionTreeResultInstance, field: "minimumNumberOfInstancesPerLeaf")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${regressionTreeResultInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
