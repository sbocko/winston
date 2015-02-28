<%@ page import="winston.Dataset" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'dataset.label', default: 'Dataset')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="body-container">
    <div id="edit-dataset" class="content scaffold-edit" role="main">
        <div class="page-header">
            <g:if test='${flash.message}'>
                <div class="alert alert-dismissable alert-info">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <h4>Check out</h4>

                    <p>${flash.message}</p>
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

            <h1 class="lead">Edit ${datasetInstance.getTitle()}</h1>
        </div>

        <div class="lead">
            <g:link class="index" action="show" params="[id: datasetInstance.id]" style="text-decoration: none;">
                <button class="btn btn-info btn-sm">
                    <span class="glyphicon glyphicon-chevron-left"></span> Back
                </button>
            </g:link>
            <g:link class="delete" action="delete" params="${params}" style="text-decoration: none;"
                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                <button class="btn btn-danger btn-sm">
                    <span class="glyphicon glyphicon-remove"></span> Delete
                </button>
            </g:link>
        </div>

        <g:form method="post">
            <g:hiddenField name="id" value="${datasetInstance?.id}"/>
            <g:hiddenField name="version" value="${datasetInstance?.version}"/>
            <fieldset class="form">
                <g:render template="edit-form"/>
            </fieldset>
            <fieldset class="buttons">
                <button type="submit" name="_action_update" value="Update" class="btn btn-success btn-md save">
                    <span class="glyphicon glyphicon-pencil"></span> Update
                </button>
            </fieldset>
        </g:form>
    </div>
</div>
</body>
</html>
