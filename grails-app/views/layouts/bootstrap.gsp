<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title><g:layoutTitle default="Winston"/></title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="${request.contextPath}/bootstrap/css/bootstrap.css" media="screen">
    <link rel="stylesheet"
          href="${request.contextPath}/bootstrap/css/bootstrap-theme.css">
    <link rel="stylesheet"
          href="${request.contextPath}/bootstrap/css/usebootstrap.css">
    <asset:stylesheet src="override.css"/>
    <g:layoutHead/>
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
          <script src="bootstrap/html5shiv.js"></script>
          <script src="bootstrap/respond.min.js"></script>
        <![endif]-->

    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="${request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${request.contextPath}/bootstrap/js/bootstrap.js"></script>
</head>

<body>
<!-- Navigation bar -->
<div class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <g:link uri="/" class="navbar-brand">Winston</g:link>
            %{--<a href="#" class="navbar-brand">Winston</a>--}%
        </div>

        <div class="navbar-collapse collapse" id="navbar-main">
            <ul class="nav navbar-nav">
                <sec:ifLoggedIn>
                    <li>
                        <g:link controller="dataset" action="list">My datasets</g:link>
                    </li>
                </sec:ifLoggedIn>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="http://data-mining.sk/web/" target="_blank">About</a></li>
                <sec:ifLoggedIn>
                    <li><g:link controller="logout">Log out</g:link></li>
                </sec:ifLoggedIn>
                <sec:ifNotLoggedIn>
                    <li><g:link controller="login" action="auth">Log in</g:link></li>
                </sec:ifNotLoggedIn>
            </ul>
        </div>
    </div>
</div>

<div class="container">
    <g:layoutBody/>
    <div class="page-header"/> %{--for some extra white space at the bottom--}%
</div>
</body>
</html>
