
<%@ page import="winston.Analysis" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'analysis.label', default: 'Analysis')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-analysis" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-analysis" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="csvDataFile" title="${message(code: 'analysis.csvDataFile.label', default: 'Csv Data File')}" />
					
						<g:sortableColumn property="arffDataFile" title="${message(code: 'analysis.arffDataFile.label', default: 'Arff Data File')}" />
					
						<th><g:message code="analysis.dataset.label" default="Dataset" /></th>
					
						<g:sortableColumn property="numberOfAttributes" title="${message(code: 'analysis.numberOfAttributes.label', default: 'Number Of Attributes')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${analysisInstanceList}" status="i" var="analysisInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${analysisInstance.id}">${fieldValue(bean: analysisInstance, field: "csvDataFile")}</g:link></td>
					
						<td>${fieldValue(bean: analysisInstance, field: "arffDataFile")}</td>
					
						<td>${fieldValue(bean: analysisInstance, field: "dataset")}</td>
					
						<td>${fieldValue(bean: analysisInstance, field: "numberOfAttributes")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${analysisInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
