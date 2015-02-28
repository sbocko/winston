<%@ page import="winston.Analysis" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'analysis.label', default: 'Analysis')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="body-container">
    <div id="show-analysis" class="content scaffold-show" role="main">
        <div class="page-header">
            <g:if test='${flash.message}'>
                <div class="alert alert-dismissable alert-info">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <h4>Check out</h4>

                    <p>${flash.message}</p>
                </div>
            </g:if>

            <g:if test="${analysisInstance != null}">
                <h1 class="lead">${analysisInstance}</h1>
            </g:if>
            <g:else>
                <h1 class="lead"><g:message code="default.show.label" args="[entityName]"/></h1>
            </g:else>
        </div>

        <div class="lead">
            <g:link controller="dataset" class="index" action="show"
                    params="[id: analysisInstance.getDataset().getId()]" style="text-decoration: none;">
                <button class="btn btn-info btn-sm">
                    <span class="glyphicon glyphicon-chevron-left"></span> Back
                </button>
            </g:link>
            <g:link class="index" action="downloadFile"
                    resource="${analysisInstance}" style="text-decoration: none;">
                <button class="btn btn-success btn-sm">
                    <span class="glyphicon glyphicon-cloud-download"></span> Download analysis file
                </button>

            </g:link>
        </div>

        <div class="row">
            <dl class="dl-horizontal">
                <g:if test="${analysisInstance?.dataset}">
                    <dt>
                        <g:message code="analysis.dataset.label" default="Dataset"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:link controller="dataset" action="show"
                                id="${analysisInstance?.dataset?.id}">${analysisInstance?.dataset?.encodeAsHTML()}</g:link>
                    </dd>
                </g:if>

                <g:if test="${analysisInstance?.dataFile}">
                    <dt>
                        <g:message code="analysis.dataFile.label" default="Data File"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${analysisInstance}" field="dataFile"/>
                    </dd>
                </g:if>

                <g:if test="${analysisInstance?.dataType}">
                    <dt>
                        <g:message code="analysis.dataType.label" default="Data Type"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:if test="${Analysis.DATA_TYPE_INTEGER.equals(analysisInstance.dataType)}">
                            Integer
                        </g:if>
                        <g:elseif test="${Analysis.DATA_TYPE_REAL.equals(analysisInstance.dataType)}">
                            Real numbers
                        </g:elseif>
                        <g:elseif test="${Analysis.DATA_TYPE_CATEGORICAL.equals(analysisInstance.dataType)}">
                            Categorical
                        </g:elseif>
                        <g:elseif test="${Analysis.DATA_TYPE_MULTIVARIATE.equals(analysisInstance.dataType)}">
                            Multivariate
                        </g:elseif>
                        <g:else>
                            Unknown
                        </g:else>
                    </dd>
                </g:if>

                <g:if test="${analysisInstance?.numberOfAttributes}">
                    <dt>
                        <g:message code="analysis.numberOfAttributes.label" default="Number Of Attributes"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${analysisInstance}" field="numberOfAttributes"/>
                    </dd>
                </g:if>
            </dl>
        </div>

        <g:if test="${analysisResults}">
            <div class="row">
                <h2 class="container lead">
                    Top results for this analysis by <a href="http://en.wikipedia.org/wiki/Root-mean-square_deviation"
                                                        target="_blank">rmse</a>:
                </h2>
            </div>
            <table class="well table table-striped table-hover">
                <thead>
                <tr>
                    <th>Position</th>
                    <th>Method</th>
                    <th>Rmse</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${analysisResults}" status="i" var="analysisResult">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td>${i + 1}.</td>
                        <td>
                            <g:link controller="analysisResult" action="show"
                                    id="${analysisResult.id}">
                                <g:if test="${analysisResult.instanceOf(winston.KnnResult)}">
                                    k-NN
                                </g:if>
                                <g:elseif test="${analysisResult.instanceOf(winston.DecisionTreeResult)}">
                                    Decision Tree
                                </g:elseif>
                                <g:elseif test="${analysisResult.instanceOf(winston.LogisticRegressionResult)}">
                                    Logistic regression
                                </g:elseif>
                                <g:elseif test="${analysisResult.instanceOf(winston.SvmResult)}">
                                    Support vector machines
                                </g:elseif>
                                <g:else>
                                    Unknown
                                </g:else>
                            </g:link>
                        </td>
                        <td>${fieldValue(bean: analysisResult, field: "rmse")}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </g:if>
    </div>
</div>
</body>
</html>
