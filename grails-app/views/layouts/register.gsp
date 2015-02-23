<html>

<head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <title><g:layoutTitle default='User Registration'/></title>

    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>

    <s2ui:resources module='register'/>
    <asset:stylesheet src="override.css"/>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="${request.contextPath}/amelia/theme/bootstrap.css" media="screen">
    <link rel="stylesheet"
          href="${request.contextPath}/amelia/theme/usebootstrap.css">

    <%--

    The 'resources' tag in SecurityUiTagLib renders these tags if you're not using the resources plugin:

        <g:javascript library='jquery' plugin='jquery' />
        <link rel="stylesheet" media="screen" href="${resource(dir:'css',file:'reset.css',plugin:'spring-security-ui')}"/>
        <link rel="stylesheet" media="screen" href="${resource(dir:'css',file:'spring-security-ui.css',plugin:'spring-security-ui')}"/>
        <jqui:resources />
        <link rel="stylesheet" media="screen" href="${resource(dir:'css/smoothness',file:'jquery-ui-1.10.3.custom.css',plugin:'spring-security-ui')}"/>
        <link rel="stylesheet" media="screen" href="${resource(dir:'css',file:'jquery.jgrowl.css',plugin:'spring-security-ui')}"/>
        <link rel="stylesheet" media="screen" href="${resource(dir:'css',file:'jquery.safari-checkbox.css',plugin:'spring-security-ui')}"/>
        <link rel="stylesheet" media="screen" href="${resource(dir:'css',file:'auth.css',plugin:'spring-security-ui')}"/>

    or these if you are:

       <r:require module="register"/>
       <r:layoutResources/>

    If you need to customize the resources, replace the <s2ui:resources> tag with
    the explicit tags above and edit those, not the taglib code.
    --%>

    <g:layoutHead/>

</head>

<body>

<!-- Navigation bar -->
<div class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <g:link uri="/" class="navbar-brand">Winston</g:link>
        </div>
        <div class="navbar-collapse collapse" id="navbar-main">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="http://data-mining.sk/web/" target="_blank">About</a></li>
            </ul>
        </div>
    </div>
</div>

<s2ui:layoutResources module='register'/>
<g:layoutBody/>
<%--
<g:javascript src='jquery/jquery.jgrowl.js' plugin='spring-security-ui'/>
<g:javascript src='jquery/jquery.checkbox.js' plugin='spring-security-ui'/>
<g:javascript src='spring-security-ui.js' plugin='spring-security-ui'/>
--%>

<s2ui:showFlash/>

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="${request.contextPath}/amelia/bootstrap/bootstrap.min.js"></script>
<script src="${request.contextPath}/amelia/bootstrap/usebootstrap.js"></script>

</body>
</html>
