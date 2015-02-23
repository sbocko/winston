<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title><g:layoutTitle default="Winston" /></title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="${request.contextPath}/amelia/theme/bootstrap.css" media="screen">
    <link rel="stylesheet"
          href="${request.contextPath}/amelia/theme/usebootstrap.css">
    <asset:stylesheet src="override.css"/>
    <g:layoutHead/>
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
          <script src="bootstrap/html5shiv.js"></script>
          <script src="bootstrap/respond.min.js"></script>
        <![endif]-->
</head>
<body>
<!-- Navigation bar -->
<div class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a href="#" class="navbar-brand">Winston</a>
        </div>
        <div class="navbar-collapse collapse" id="navbar-main">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="http://data-mining.sk/web/" target="_blank">About</a></li>
                <sec:ifLoggedIn>
                    <li><g:link controller="logout" >Log out</g:link></li>
                </sec:ifLoggedIn>
                <sec:ifNotLoggedIn>
                    <li><g:link controller="login" action="auth">Log in</g:link></li>
                </sec:ifNotLoggedIn>
            </ul>
        </div>
    </div>
</div>

<g:layoutBody/>

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="${request.contextPath}/amelia/bootstrap/bootstrap.min.js"></script>
<script src="${request.contextPath}/amelia/bootstrap/usebootstrap.js"></script>
</body>
</html>
