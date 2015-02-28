<%@ page import="winston.NumericAttribute; winston.Dataset" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">

    <g:set var="entityName" value="${message(code: 'dataset.label', default: 'Dataset')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="body-container">
    <div id="show-dataset" class="content scaffold-show" role="main">

        <div class="page-header">
            <g:if test='${flash.message}'>
                <div class="alert alert-dismissable alert-info">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <h4>Check out</h4>

                    <p>${flash.message}</p>
                </div>
            </g:if>

            <g:if test="${datasetInstance != null && datasetInstance.getTitle() != null}">
                <h1 class="lead">${datasetInstance.getTitle()}</h1>
            </g:if>
            <g:else>
                <h1 class="lead"><g:message code="default.show.label" args="[entityName]"/></h1>
            </g:else>
        </div>

        <div class="lead">
            <g:link class="index" action="index" params="${params}" style="text-decoration: none;">
                <button class="btn btn-info btn-sm">
                    <span class="glyphicon glyphicon-list"></span> Home
                </button>
            </g:link>

            <g:link controller="Analysis" action="create" params="${params}" style="text-decoration: none;">
                <button class="btn btn-success btn-sm">
                    <span class="glyphicon glyphicon-zoom-in"></span> Analyze
                </button>
            </g:link>

            <g:link class="edit" action="edit" params="${params}" style="text-decoration: none;">
                <button class="btn btn-warning btn-sm">
                    <span class="glyphicon glyphicon-edit"></span> Edit
                </button>
            </g:link>

            <g:link class="delete" action="delete" params="${params}" style="text-decoration: none;"
                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                <button class="btn btn-danger btn-sm">
                    <span class="glyphicon glyphicon-remove"></span> Delete
                </button>
            </g:link>
        </div>

        <div class="row">
            <dl class="dl-horizontal">
                <g:if test="${datasetInstance?.title}">
                    <dt>
                        <g:message code="dataset.title.label" default="Title"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${datasetInstance}" field="title"/>
                    </dd>
                </g:if>

                <g:if test="${datasetInstance?.originalFilename}">
                    <dt>
                        <g:message code="dataset.dataFile.label" default="Data File"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${datasetInstance}" field="originalFilename"/>
                    </dd>
                </g:if>

                <g:if test="${datasetInstance?.numberOfInstances}">
                    <dt>
                        <g:message code="dataset.numberOfInstances.label" default="Number Of Instances"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${datasetInstance}" field="numberOfInstances"/>
                    </dd>
                </g:if>

                <g:if test="${datasetInstance?.missingValuePattern}">
                    <dt>
                        <g:message code="dataset.missingValuePattern.label" default="Missing Value Pattern"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${datasetInstance}" field="missingValuePattern"/>
                    </dd>
                </g:if>

                <g:if test="${datasetInstance?.numberOfMissingValues}">
                    <dt>
                        <g:message code="dataset.numberOfMissingValues.label" default="Number Of Missing Values"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${datasetInstance}" field="numberOfMissingValues"/>
                    </dd>
                </g:if>

                <g:if test="${datasetInstance?.description}">
                    <dt>
                        <g:message code="dataset.description.label" default="Description"/>
                    </dt>
                    <dd>
                        <span class="vertical-aligner"></span>
                        <g:fieldValue bean="${datasetInstance}" field="description"/>
                    </dd>
                </g:if>

            </dl>
        </div>

        <g:if test="${datasetInstance?.attributes}">
            <div class="row">
                <h2 class="container lead">
                    <g:message code="dataset.attributes.label" default="Attributes"/>
                </h2>
            </div>

            <table class="well table table-striped table-hover">
                <thead>
                <tr>
                    <th>#</th>

                    <th><g:message code="attribute.title.label" default="Title"/></th>

                    <th>Type</th>

                </tr>
                </thead>
                <tbody>
                <g:each in="${datasetInstance.attributes.sort() { it.positionInDataFile }}" status="i"
                        var="attributeInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td>${i + 1}</td>

                        <td><g:link controller="attribute" action="show"
                                    id="${attributeInstance.id}">${fieldValue(bean: attributeInstance, field: "title")}</g:link></td>

                        <g:if test="${attributeInstance.instanceOf(winston.NumericAttribute)}">
                            <td>numeric</td>
                        </g:if>
                        <g:elseif test="${attributeInstance.instanceOf(winston.StringAttribute)}">
                            <td>categorical</td>
                        </g:elseif>
                        <g:elseif test="${attributeInstance.instanceOf(winston.BooleanAttribute)}">
                            <td>boolean</td>
                        </g:elseif>
                        <g:else>
                            <td>unknown</td>
                        </g:else>
                    </tr>
                </g:each>
                </tbody>
            </table>

        </g:if>

        <g:if test="${datasetInstance?.analyzes}">
            <div class="row">
                <h2 class="container lead">Top analyzes</h2>
            </div>

            <table class="well table table-striped table-hover">
                <thead>
                <tr>
                    <th>#</th>

                    <th><g:message code="analysis.dataFile.label" default="Data File"/></th>

                    <th><g:message code="analysis.numberOfAttributes.label" default="Number Of Attributes"/></th>

                    <th>Best rmse</th>

                </tr>
                </thead>
                <tbody>
                <g:each in="${analysisInstances.sort() { it.bestRmse }}" status="i" var="analysisInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td>${i + 1}</td>

                        <td><g:link controller="analysis" action="show"
                                    id="${analysisInstance.id}">${fieldValue(bean: analysisInstance, field: "dataFile")}</g:link></td>

                        <td>${fieldValue(bean: analysisInstance, field: "numberOfAttributes")}</td>

                        <g:set var="bestRmse" value="${analysisInstance.getBestRmse()}"/>
                        <g:if test="${bestRmse == null}">
                            <td>N/A</td>
                        </g:if> <g:else>
                        <td>${analysisInstance.getBestRmse()}</td>
                    </g:else>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </g:if>
        <g:else>
            <div class="bs-docs-section  col-lg-6 centered">
                <div class="row text-center">
                    <p class="lead">This dataset has not yet been analyzed. Start new analysis by clicking the button below.
                    The results will be shown here. You can run the analysis more times to obtain more accurate results.
                    </p>

                    <g:link controller="Analysis" action="create" params="${params}">
                        <button class="btn btn-success btn-lg">
                            <span class="glyphicon glyphicon-zoom-in"></span>
                            Analyze
                        </button>
                    </g:link>
                </div>
            </div>
        </g:else>

    </div>
</div>
</body>
</html>
