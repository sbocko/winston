<%@ page import="winston.Analysis; winston.KnnResult" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'knnResult.label', default: 'KnnResult')}"/>
</head>

<body>
<div class="body-container">
    <div id="show-knnResult" class="content scaffold-show" role="main">
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
                    params="[id: knnResultInstance.getAnalysis().getId()]" style="text-decoration: none;">
                <button class="btn btn-info btn-sm">
                    <span class="glyphicon glyphicon-chevron-left"></span> Back
                </button>
            </g:link>
        </div>

        <div class="row">
            <dl class="dl-horizontal">

                <g:if test="${knnResultInstance?.analysis}">
                    <dt>
                        <g:message code="knnResult.analysis.label" default="Analysis"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:link controller="analysis" action="show"
                                id="${knnResultInstance?.analysis?.id}">${knnResultInstance?.analysis?.encodeAsHTML()}</g:link>
                    </dd>
                </g:if>

                <dt>
                    Model type
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <a href="http://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm" target="_blank">k-NN</a>
                </dd>

                <dt>
                    <g:message code="knnResult.k.label" default="K"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:fieldValue bean="${knnResultInstance}" field="k"/>
                </dd>

                <dt>
                    <g:message code="knnResult.rmse.label" default="Rmse"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:fieldValue bean="${knnResultInstance}" field="rmse"/>
                </dd>

                <dt>
                    <g:message code="knnResult.meanAbsoluteError.label" default="Mean Absolute Error"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:fieldValue bean="${knnResultInstance}" field="meanAbsoluteError"/>
                </dd>

                <g:if test="${winston.Analysis.TASK_CLASSIFICATION.equals(knnResultInstance.analysis.task)}">
                    <dt>
                        <g:message code="knnResult.correctlyClassified.label" default="Correctly classified instances"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${knnResultInstance}" field="correctlyClassified"/>
                    </dd>
                </g:if>

                <g:if test="${winston.Analysis.TASK_CLASSIFICATION.equals(knnResultInstance.analysis.task)}">
                    <dt>
                        <g:message code="knnResult.incorrectlyClassified.label"
                                   default="Incorrectly classified instances"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${knnResultInstance}" field="incorrectlyClassified"/>
                    </dd>
                </g:if>

                <dt>
                    <g:message code="knnResult.summary.label" default="Summary"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <pre><g:fieldValue bean="${knnResultInstance}" field="summary"/></pre>
                </dd>
            </dl>
        </div>

    </div>
</div>
</body>
</html>
