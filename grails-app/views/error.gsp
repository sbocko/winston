<!DOCTYPE html>
<html>
<head>
    <title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
    <meta name="layout" content="bootstrap">
    <g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
</head>

<body>
<g:if env="development">
    <g:renderException exception="${exception}"/>
</g:if>
<g:else>
    <div class="page-header">
        <h1 class="lead">Internal Error</h1>
    </div>

    <div class="lead">
        <p class="lead">Something bad happened. Please try again later. Sorry for inconvenience.</p>
    </div>
</g:else>
</body>
</html>
