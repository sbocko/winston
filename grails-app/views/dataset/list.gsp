<%@ page import="winston.Dataset" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">

    <g:set var="entityName" value="${message(code: 'dataset.label', default: 'Dataset')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="body-container">
    <div id="list-dataset" class="content scaffold-list" role="main">

        <g:if test="${datasetInstanceList.size() == 0}">

            <div class="page-header">
                <g:if test='${flash.message}'>
                    <div class="alert alert-dismissable alert-info">
                        <button type="button" class="close" data-dismiss="alert">×</button>
                        <h4>Check out</h4>

                        <p>${flash.message}</p>
                    </div>
                </g:if>
            </div>

            <div class="container bs-docs-section well col-lg-6 centered">
                <div class="row text-center">
                    <h1>Welcome</h1>

                    <p>Start by uploading your dataset in <a
                            href="http://en.wikipedia.org/wiki/Comma-separated_values#Example" target="_blank">CSV</a>
                        format using the button below. You can always access a list of your datasets by clicking on the 'My datasets' tab in the top menu.
                    </p>

                    <g:link class="create" action="create">
                        <button class="btn btn-success btn-lg">
                            <span class="glyphicon glyphicon-file"></span>
                            Upload dataset
                        </button>
                    </g:link>
                </div>
            </div>
        </g:if>
        <g:else>
        %{--show user's datasets--}%
            <div class="page-header">
                <g:if test='${flash.message}'>
                    <div class="alert alert-dismissable alert-info">
                        <button type="button" class="close" data-dismiss="alert">×</button>
                        <h4>Check out</h4>

                        <p>${flash.message}</p>
                    </div>
                </g:if>

                <h1 class="lead"><g:message code="default.list.label" args="[entityName]"/></h1>
            </div>

            <div class="lead">
                <g:link class="create" action="create" style="text-decoration: none;">
                    <button class="btn btn-success btn-sm">
                        <span class="glyphicon glyphicon-file"></span> Upload new dataset
                    </button>
                </g:link>
            </div>

            <table class="well table table-striped table-hover">
                <thead>
                <tr class="page-header">
                    <th>#</th>

                    <g:sortableColumn property="title"
                                      title="${message(code: 'dataset.title.label', default: 'Title')}"/>

                    <g:sortableColumn property="description"
                                      title="${message(code: 'dataset.description.label', default: 'Description')}"/>

                    <g:sortableColumn property="numberOfInstances"
                                      title="${message(code: 'dataset.numberOfInstances.label', default: 'Number of instances')}"/>

                    <g:sortableColumn property="missingValuePattern"
                                      title="${message(code: 'dataset.missingValuePattern.label', default: 'Missing Value Pattern')}"/>

                    <g:sortableColumn property="numberOfMissingValues"
                                      title="${message(code: 'dataset.numberOfMissingValues.label', default: 'Number Of Missing Values')}"/>

                </tr>
                </thead>
                <tbody>
                <g:each in="${datasetInstanceList}" status="i" var="datasetInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td>${i + 1}</td>

                        <td><g:link action="show"
                                    id="${datasetInstance.id}">${fieldValue(bean: datasetInstance, field: "title")}</g:link></td>

                        <td>${fieldValue(bean: datasetInstance, field: "description")}</td>

                        <td>${fieldValue(bean: datasetInstance, field: "numberOfInstances")}</td>

                        <td>${fieldValue(bean: datasetInstance, field: "missingValuePattern")}</td>

                        <td>${fieldValue(bean: datasetInstance, field: "numberOfMissingValues")}</td>

                    </tr>
                </g:each>

                </tbody>
            </table>
        </g:else>

    %{--<div class="pagination">--}%
    %{--<g:paginate total="${datasetInstanceTotal}" />--}%
    %{--</div>--}%
    </div>
</div>
</body>
</html>
