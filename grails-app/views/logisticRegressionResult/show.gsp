<%@ page import="winston.LogisticRegressionResult" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName"
           value="${message(code: 'logisticRegressionResult.label', default: 'LogisticRegressionResult')}"/>
</head>

<body>
<div class="body-container">
    <div id="show-logisticRegressionResult" class="content scaffold-show" role="main">
        <div class="page-header">
            <g:if test='${flash.message}'>
                <div class="alert alert-dismissable alert-info">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <h4>Check out</h4>

                    <p>${flash.message}</p>
                </div>
            </g:if>

            <h1 class="lead">Model detail</h1>
        </div>

        <div class="lead">
            <g:link controller="analysis" class="index" action="show"
                    params="[id: logisticRegressionResultInstance.getAnalysis().getId()]"
                    style="text-decoration: none;">
                <button class="btn btn-info btn-sm">
                    <span class="glyphicon glyphicon-chevron-left"></span> Back
                </button>
            </g:link>
        </div>

        <div class="row">
            <dl class="dl-horizontal">

                <g:if test="${logisticRegressionResultInstance?.analysis}">
                    <dt>
                        <g:message code="logisticRegressionResult.analysis.label" default="Analysis"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:link controller="analysis" action="show"
                                id="${logisticRegressionResultInstance?.analysis?.id}">${logisticRegressionResultInstance?.analysis?.encodeAsHTML()}</g:link>
                    </dd>
                </g:if>

                <dt>
                    Model type
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <a href="http://en.wikipedia.org/wiki/Logistic_regression" target="_blank">Logistic regression</a>
                </dd>

                <dt>
                    <g:message code="logisticRegressionResult.rmse.label" default="Rmse"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:fieldValue bean="${logisticRegressionResultInstance}" field="rmse"/>
                </dd>

                <dt>
                    <g:message code="logisticRegressionResult.maximumNumberOfIterations.label"
                               default="Maximum Number Of Iterations"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:if test="${logisticRegressionResultInstance.maximumNumberOfIterations == winston.LogisticRegressionResult.ITERATE_UNTIL_CONVERGENCE}">
                        Not limited
                    </g:if>
                    <g:else>
                        <g:fieldValue bean="${logisticRegressionResultInstance}" field="maximumNumberOfIterations"/>
                    </g:else>
                </dd>

                <dt>
                    <g:message code="logisticRegressionResult.ridge.label" default="Ridge"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:fieldValue bean="${logisticRegressionResultInstance}" field="ridge"/>
                </dd>
            </dl>
        </div>

    </div>
</div>
</body>
</html>
