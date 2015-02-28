<%@ page import="winston.StringAttribute" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">

    <g:set var="entityName" value="${message(code: 'stringAttribute.label', default: 'StringAttribute')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="body-container">
    <div id="show-stringAttribute" class="content scaffold-show" role="main">
        <div class="page-header">
            <g:if test='${flash.message}'>
                <div class="alert alert-dismissable alert-info">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <h4>Check out</h4>

                    <p>${flash.message}</p>
                </div>
            </g:if>

            <g:if test="${stringAttributeInstance != null && stringAttributeInstance.getTitle() != null}">
                <h1 class="lead">${stringAttributeInstance.getTitle()}</h1>
            </g:if>
            <g:else>
                <h1 class="lead"><g:message code="default.show.label" args="[entityName]"/></h1>
            </g:else>
        </div>

        <div class="lead">
            <g:link controller="dataset" class="index" action="show"
                    params="[id: stringAttributeInstance.getDataset().getId()]" style="text-decoration: none;">
                <button class="btn btn-info btn-sm">
                    <span class="glyphicon glyphicon-chevron-left"></span> Back
                </button>
            </g:link>
        </div>

        <div class="row">
            <dl class="dl-horizontal">

                <g:if test="${stringAttributeInstance?.title}">
                    <dt>
                        <g:message code="stringAttribute.title.label" default="Title"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${stringAttributeInstance}" field="title"/>
                    </dd>
                </g:if>

                <g:if test="${stringAttributeInstance?.dataset}">
                    <dt>
                        <g:message code="stringAttribute.dataset.label" default="Dataset"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:link controller="dataset" action="show"
                                id="${stringAttributeInstance?.dataset?.id}">${stringAttributeInstance?.dataset?.encodeAsHTML()}</g:link>
                    </dd>
                </g:if>

                <dt>
                    Type
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    categorical
                </dd>

                <g:if test="${stringAttributeInstance?.numberOfDistinctValues}">
                    <dt>
                        <g:message code="stringAttribute.numberOfDistinctValues.label" default="Distinct values"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${stringAttributeInstance}" field="numberOfDistinctValues"/>
                    </dd>
                </g:if>

                <g:if test="${stringAttributeInstance?.numberOfMissingValues}">
                    <dt>
                        <g:message code="stringAttribute.numberOfMissingValues.label"
                                   default="Number Of Missing Values"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${stringAttributeInstance}" field="numberOfMissingValues"/>
                    </dd>
                </g:if>

            </dl>
        </div>
    </div>
</div>
</body>
</html>
