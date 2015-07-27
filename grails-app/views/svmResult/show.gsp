<%@ page import="winston.SvmResult" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'svmResult.label', default: 'SvmResult')}"/>
</head>

<body>
<div class="body-container">
    <div id="show-svmResult" class="content scaffold-show" role="main">
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
                    params="[id: svmResultInstance.getAnalysis().getId()]" style="text-decoration: none;">
                <button class="btn btn-info btn-sm">
                    <span class="glyphicon glyphicon-chevron-left"></span> Back
                </button>
            </g:link>
        </div>

        <div class="row">
            <dl class="dl-horizontal">

                <g:if test="${svmResultInstance?.analysis}">
                    <dt>
                        <g:message code="svmResult.analysis.label" default="Analysis"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:link controller="analysis" action="show"
                                id="${svmResultInstance?.analysis?.id}">${svmResultInstance?.analysis?.encodeAsHTML()}</g:link>
                    </dd>
                </g:if>

                <dt>
                    Model type
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <a href="http://en.wikipedia.org/wiki/Support_vector_machine"
                       target="_blank">Support vector machines</a>
                </dd>

                <dt>
                    <g:message code="svmResult.kernel.label" default="Kernel"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:fieldValue bean="${svmResultInstance}" field="kernel"/>
                </dd>

                <dt>
                    <g:message code="svmResult.complexityConstant.label" default="Complexity Constant"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:fieldValue bean="${svmResultInstance}" field="complexityConstant"/>
                </dd>

                <dt>
                    <g:message code="svmResult.gamma.label" default="Gamma"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:fieldValue bean="${svmResultInstance}" field="gamma"/>
                </dd>

                <dt>
                    <g:message code="svmResult.rmse.label" default="Rmse"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:fieldValue bean="${svmResultInstance}" field="rmse"/>
                </dd>

                <dt>
                    <g:message code="svmResult.meanAbsoluteError.label" default="Mean Absolute Error"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <g:fieldValue bean="${svmResultInstance}" field="meanAbsoluteError"/>
                </dd>

                <g:if test="${winston.Analysis.TASK_CLASSIFICATION.equals(svmResultInstance.analysis.task)}">
                    <dt>
                        <g:message code="svmResult.correctlyClassified.label" default="Correctly classified instances"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${svmResultInstance}" field="correctlyClassified"/>
                    </dd>
                </g:if>

                <g:if test="${winston.Analysis.TASK_CLASSIFICATION.equals(svmResultInstance.analysis.task)}">
                    <dt>
                        <g:message code="svmResult.incorrectlyClassified.label"
                                   default="Incorrectly classified instances"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${svmResultInstance}" field="incorrectlyClassified"/>
                    </dd>
                </g:if>

                <dt>
                    <g:message code="svmResult.summary.label" default="Summary"/>
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    <pre><g:fieldValue bean="${svmResultInstance}" field="summary"/></pre>
                </dd>
            </dl>
        </div>

    </div>
</div>
</body>
</html>
