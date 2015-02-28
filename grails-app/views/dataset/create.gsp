<%@ page import="winston.Dataset" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'dataset.label', default: 'Dataset')}"/>
    %{--<title><g:message code="default.create.label" args="[entityName]"/></title>--}%
</head>

<body>
<div class="body-container">
    <div id="create-dataset" class="content scaffold-create" role="main">
        <div class="page-header">
            <g:if test='${flash.message}'>
                <div class="alert alert-dismissable alert-info">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <h4>Check out</h4>

                    <p>${flash.message}</p>
                </div>
            </g:if>

            <g:if test='${flash.error}'>
                <div class="alert alert-dismissable alert-danger">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <h4>Oh no!</h4>

                    <p>${flash.error}</p>
                </div>
            </g:if>

            <g:hasErrors bean="${datasetInstance}">
                <div class="alert alert-dismissable alert-danger">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <h4>Oh no</h4>
                    <g:eachError bean="${datasetInstance}" var="error">
                        <p <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></p>
                    </g:eachError>
                </div>
            </g:hasErrors>

            <h1 class="lead">Upload dataset</h1>
        </div>

        <div class="lead">
            <g:link class="index" action="index" params="${params}" style="text-decoration: none;">
                <button class="btn btn-info btn-sm">
                    <span class="glyphicon glyphicon-list"></span> Home
                </button>
            </g:link>
        </div>

        <g:form action="save" method="post" enctype="multipart/form-data">
            <fieldset class="form">
                <g:render template="form"/>
            </fieldset>

            <g:link action="create" class="save" params="${params}" style="text-decoration: none;">
                <button class="btn btn-success btn-md">
                    <span class="glyphicon glyphicon-upload"></span> Upload
                </button>
            </g:link>
        </g:form>
    </div>

    <div/>
</body>
</html>
