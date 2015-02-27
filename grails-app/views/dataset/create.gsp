<%@ page import="winston.Dataset" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">

    <g:set var="entityName" value="${message(code: 'dataset.label', default: 'Dataset')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="body-container">
    %{--<a href="#create-dataset" class="skip" tabindex="-1"><g:message code="default.link.skip.label"--}%
    %{--default="Skip to content&hellip;"/></a>--}%
    %{--<div class="nav" role="navigation">--}%
    %{--<ul>--}%
    %{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
    %{--<li><g:link class="list" action="list"><g:message code="default.list.label"--}%
    %{--args="[entityName]"/></g:link></li>--}%
    %{--</ul>--}%
    %{--</div>--}%

    <div id="create-dataset" class="content scaffold-create" role="main">
        <div class="page-header">
            <g:if test='${flash.message}'>
                <div class="alert alert-dismissable alert-info">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <h4>Check out</h4>

                    <p>${flash.message}</p>
                </div>
            </g:if>

            <h1 class="lead">Upload dataset</h1>
        </div>

    <div class="lead">
        <g:link class="index" action="index" params="${params}" style="text-decoration: none;">
            <button class="btn btn-info btn-sm">
                <span class="glyphicon glyphicon-list"></span> Home
            </button>
        </g:link>
    </div>

        <g:hasErrors bean="${datasetInstance}">
            <ul class="errors" role="alert">
                <g:eachError bean="${datasetInstance}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                            error="${error}"/></li>
                </g:eachError>
            </ul>
        </g:hasErrors>
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
