<%@ page import="winston.DecisionTreeResult" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'decisionTreeResult.label', default: 'DecisionTreeResult')}"/>
</head>

<body>
<div class="body-container">
    <div id="show-decisionTreeResult" class="content scaffold-show" role="main">
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
                    params="[id: decisionTreeResultInstance.getAnalysis().getId()]" style="text-decoration: none;">
                <button class="btn btn-info btn-sm">
                    <span class="glyphicon glyphicon-chevron-left"></span> Back
                </button>
            </g:link>
        </div>

        <div class="row">
            <dl class="dl-horizontal">

                <g:if test="${decisionTreeResultInstance?.analysis}">
                    <dt>
                        <g:message code="decisionTreeResult.analysis.label" default="Analysis"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:link controller="analysis" action="show"
                                id="${decisionTreeResultInstance?.analysis?.id}">${decisionTreeResultInstance?.analysis?.encodeAsHTML()}</g:link>
                    </dd>
                </g:if>

                <dt>
                    Model type
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <a href="http://en.wikipedia.org/wiki/Decision_tree" target="_blank">Decision Tree</a>
                </dd>

                <dt>
                    <g:message code="decisionTreeResult.rmse.label" default="Rmse"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:fieldValue bean="${decisionTreeResultInstance}" field="rmse"/>
                </dd>

                <dt>
                    <g:message code="decisionTreeResult.confidenceFactor.label" default="Confidence Factor"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:fieldValue bean="${decisionTreeResultInstance}" field="confidenceFactor"/>
                </dd>

                <dt>
                    <g:message code="decisionTreeResult.minimumNumberOfInstancesPerLeaf.label"
                               default="Minimum # of instances per leaf"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:fieldValue bean="${decisionTreeResultInstance}" field="minimumNumberOfInstancesPerLeaf"/>
                </dd>

                <dt>
                    Pruned
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:formatBoolean boolean="${decisionTreeResultInstance?.unpruned}" true="No" false="Yes"/>
                </dd>
            </dl>
        </div>

    </div>
</div>
</body>
</html>
