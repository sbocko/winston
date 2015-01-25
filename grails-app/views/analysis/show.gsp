<%@ page import="winston.Analysis" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'analysis.label', default: 'Analysis')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-analysis" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                               default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-analysis" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list analysis">

        <g:if test="${analysisInstance?.csvDataFile}">
            <li class="fieldcontain">
                <span id="csvDataFile-label" class="property-label"><g:message code="analysis.csvDataFile.label"
                                                                               default="Csv Data File"/></span>

                <span class="property-value" aria-labelledby="csvDataFile-label"><g:fieldValue
                        bean="${analysisInstance}" field="csvDataFile"/></span>

            </li>
        </g:if>

        <g:if test="${analysisInstance?.arffDataFile}">
            <li class="fieldcontain">
                <span id="arffDataFile-label" class="property-label"><g:message code="analysis.arffDataFile.label"
                                                                                default="Arff Data File"/></span>

                <span class="property-value" aria-labelledby="arffDataFile-label"><g:fieldValue
                        bean="${analysisInstance}" field="arffDataFile"/></span>

            </li>
        </g:if>

        <g:if test="${analysisInstance?.dataType}">
            <li class="fieldcontain">
                <span id="dataType-label" class="property-label"><g:message code="analysis.dataType.label"
                                                                            default="Data type"/></span>

                <span class="property-value" aria-labelledby="dataType-label"><g:fieldValue bean="${analysisInstance}"
                                                                                            field="dataType"/></span>

            </li>
        </g:if>

        <g:if test="${analysisInstance?.dataset}">
            <li class="fieldcontain">
                <span id="dataset-label" class="property-label"><g:message code="analysis.dataset.label"
                                                                           default="Dataset"/></span>

                <span class="property-value" aria-labelledby="dataset-label"><g:link controller="dataset" action="show"
                                                                                     id="${analysisInstance?.dataset?.id}">${analysisInstance?.dataset?.encodeAsHTML()}</g:link></span>

            </li>
        </g:if>

        <g:if test="${analysisInstance?.numberOfAttributes}">
            <li class="fieldcontain">
                <span id="numberOfAttributes-label" class="property-label"><g:message
                        code="analysis.numberOfAttributes.label" default="Number Of Attributes"/></span>

                <span class="property-value" aria-labelledby="numberOfAttributes-label"><g:fieldValue
                        bean="${analysisInstance}" field="numberOfAttributes"/></span>

            </li>
        </g:if>

    %{--<g:if test="${analysisInstance?.results}">--}%
    %{--<li class="fieldcontain">--}%
    %{--<span id="results-label" class="property-label"><g:message code="analysis.results.label" default="Results" /></span>--}%
    %{----}%
    %{--<g:each in="${analysisInstance.results}" var="r">--}%
    %{--<span class="property-value" aria-labelledby="results-label"><g:link controller="analysisResult" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>--}%
    %{--</g:each>--}%
    %{----}%
    %{--</li>--}%
    %{--</g:if>--}%

    </ol>

    <g:if test="${analysisResults}">
        <div>Best results for this analysis:</div>
        <table>
            <thead>
            <tr>
                <th>Position</th>
                <th>Method</th>
                <g:sortableColumn property="rmse"
                                  title="${message(code: 'analysisResult.rmse.label', default: 'Rmse')}"/>
            </tr>
            </thead>
            <tbody>
            <g:each in="${analysisResults}" status="i" var="analysisResult">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td>${i+1}.</td>
                    <td><g:link controller="analysisResult" action="show"
                                id="${analysisResult.id}">${analysisResult.class.getSimpleName()}</g:link></td>

                    <td>${fieldValue(bean: analysisResult, field: "rmse")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
    </g:if>

    <g:form url="[resource: analysisInstance, action: 'delete']" method="DELETE">
        <fieldset class="buttons">
            <g:link class="edit" action="edit" resource="${analysisInstance}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="delete" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
