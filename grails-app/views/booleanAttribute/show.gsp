<%@ page import="winston.BooleanAttribute" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'booleanAttribute.label', default: 'BooleanAttribute')}"/>
</head>

<body>
<div class="body-container">
    <div id="show-booleanAttribute" class="content scaffold-show" role="main">
        <div class="page-header">
            <g:if test='${flash.message}'>
                <div class="alert alert-dismissable alert-info">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <h4>Check out</h4>

                    <p>${flash.message}</p>
                </div>
            </g:if>

            <g:if test="${booleanAttributeInstance != null && booleanAttributeInstance.getTitle() != null}">
                <h1 class="lead">${booleanAttributeInstance.getTitle()}</h1>
            </g:if>
            <g:else>
                <h1 class="lead"><g:message code="default.show.label" args="[entityName]"/></h1>
            </g:else>
        </div>

        <div class="lead">
            <g:link controller="dataset" class="index" action="show"
                    params="[id: booleanAttributeInstance.getDataset().getId()]" style="text-decoration: none;">
                <button class="btn btn-info btn-sm">
                    <span class="glyphicon glyphicon-chevron-left"></span> Back
                </button>
            </g:link>
        </div>

        <div class="row">
            <dl class="dl-horizontal">

                <g:if test="${booleanAttributeInstance?.title}">
                    <dt>
                        <g:message code="booleanAttribute.title.label" default="Title"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${booleanAttributeInstance}" field="title"/>
                    </dd>
                </g:if>

                <g:if test="${booleanAttributeInstance?.dataset}">
                    <dt>
                        <g:message code="booleanAttribute.dataset.label" default="Dataset"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:link controller="dataset" action="show"
                                id="${booleanAttributeInstance?.dataset?.id}">${booleanAttributeInstance?.dataset?.encodeAsHTML()}</g:link>
                    </dd>
                </g:if>

                <dt>
                    Type
                </dt>
                <dd>
                    <span class="vertical-aligner"></span>
                    boolean
                </dd>

                <g:if test="${booleanAttributeInstance?.numberOfFalseValues}">
                    <dt>
                        <g:message code="booleanAttribute.numberOfFalseValues.label" default="Number Of False Values"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${booleanAttributeInstance}" field="numberOfFalseValues"/>
                    </dd>
                </g:if>

                <g:if test="${booleanAttributeInstance?.numberOfTrueValues}">
                    <dt>
                        <g:message code="booleanAttribute.numberOfTrueValues.label" default="Number Of True Values"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${booleanAttributeInstance}" field="numberOfTrueValues"/>
                    </dd>
                </g:if>

                <g:if test="${booleanAttributeInstance?.numberOfMissingValues}">
                    <dt>
                        <g:message code="booleanAttribute.numberOfMissingValues.label"
                                   default="Number Of Missing Values"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${booleanAttributeInstance}" field="numberOfMissingValues"/>
                    </dd>
                </g:if>

            </dl>
        </div>
    </div>
</div>
</body>
</html>
