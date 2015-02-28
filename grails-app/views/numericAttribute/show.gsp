<%@ page import="winston.NumericAttribute" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">

    <g:set var="entityName" value="${message(code: 'numericAttribute.label', default: 'NumericAttribute')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
%{--<a href="#show-numericAttribute" class="skip" tabindex="-1"><g:message code="default.link.skip.label"--}%
%{--default="Skip to content&hellip;"/></a>--}%

%{--<div class="nav" role="navigation">--}%
%{--<ul>--}%
%{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
%{--<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></li>--}%
%{--<li><g:link class="create" action="create"><g:message code="default.new.label"--}%
%{--args="[entityName]"/></g:link></li>--}%
%{--</ul>--}%
%{--</div>--}%
<div class="body-container">
    <div id="show-numericAttribute" class="content scaffold-show" role="main">
        <div class="page-header">
            <g:if test='${flash.message}'>
                <div class="alert alert-dismissable alert-info">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <h4>Check out</h4>

                    <p>${flash.message}</p>
                </div>
            </g:if>

            <g:if test="${numericAttributeInstance != null && numericAttributeInstance.getTitle() != null}">
                <h1 class="lead">${numericAttributeInstance.getTitle()}</h1>
            </g:if>
            <g:else>
                <h1><g:message code="default.show.label" args="[entityName]"/></h1>
            </g:else>
        </div>

        <div class="lead">
            <g:link controller="dataset" class="index" action="show"
                    params="[id: numericAttributeInstance.getDataset().getId()]" style="text-decoration: none;">
                <button class="btn btn-info btn-sm">
                    <span class="glyphicon glyphicon-chevron-left"></span> Back
                </button>
            </g:link>
        </div>

        <div class="row">
            <dl class="dl-horizontal">

                <g:if test="${numericAttributeInstance?.title}">
                    <dt>
                        <g:message code="numericAttribute.title.label" default="Title"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${numericAttributeInstance}" field="title"/>
                    </dd>
                </g:if>

                <g:if test="${numericAttributeInstance?.dataset}">
                    <dt>
                        <g:message code="numericAttribute.dataset.label" default="Dataset"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:link controller="dataset" action="show"
                                id="${numericAttributeInstance?.dataset?.id}">${numericAttributeInstance?.dataset?.encodeAsHTML()}</g:link>
                    </dd>
                </g:if>

                <g:if test="${numericAttributeInstance?.minimum}">
                    <dt>
                        <g:message code="numericAttribute.minimum.label" default="Minimum"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${numericAttributeInstance}" field="minimum"/>
                    </dd>
                </g:if>

                <g:if test="${numericAttributeInstance?.maximum}">
                    <dt>
                        <g:message code="numericAttribute.maximum.label" default="Maximum"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${numericAttributeInstance}" field="maximum"/>
                    </dd>
                </g:if>

                <g:if test="${numericAttributeInstance?.average}">
                    <dt>
                        <g:message code="numericAttribute.average.label" default="Average"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${numericAttributeInstance}" field="average"/>
                    </dd>
                </g:if>

                <g:if test="${numericAttributeInstance?.numberOfDistinctValues}">
                    <dt>
                        <g:message code="numericAttribute.numberOfDistinctValues.label" default="Distinct values"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${numericAttributeInstance}" field="numberOfDistinctValues"/>
                    </dd>
                </g:if>

                <g:if test="${numericAttributeInstance?.numberOfMissingValues}">
                    <dt>
                        <g:message code="numericAttribute.numberOfMissingValues.label"
                                   default="Number Of Missing Values"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${numericAttributeInstance}" field="numberOfMissingValues"/>
                    </dd>
                </g:if>
            </dl>
        </div>

    </div>
</div>
</body>
</html>
