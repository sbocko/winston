<html>

<head>
	<title><g:message code='spring.security.ui.login.title'/></title>
	%{--<meta name='layout' content='register'/>--}%

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="${request.contextPath}/bootstrap/css/bootstrap.css" media="screen">
    <link rel="stylesheet"
          href="${request.contextPath}/bootstrap/css/bootstrap-theme.css">
    <link rel="stylesheet"
          href="${request.contextPath}/bootstrap/css/usebootstrap.css">
    <asset:stylesheet src="override.css"/>
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

<div id='login' class="container bs-docs-section">
	<div class="well col-lg-6 centered">

		<g:if test='${flash.message}'>
			<div class="alert alert-dismissable alert-warning">
				<button type="button" class="close" data-dismiss="alert">×</button>
				<h4>Oh no!</h4>
				<p>${flash.message}</p>
			</div>
		</g:if>
		<h1 class="text-center">Please sign in</h1>
		<form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
			<p>
				<input type='text' class='form-control' name='j_username' id='username' placeholder="<g:message code='springSecurity.login.username.label'/>"/>
			</p>

			<p>
				<input type='password' class='form-control' name='j_password' id='password' placeholder="<g:message code="springSecurity.login.password.label"/>"/>
			</p>

			<div class="btn-toolbar centered">
				<input class="" type='checkbox' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
				<label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/> |</label>
				<g:link controller='register' action='forgotPassword'><g:message code='spring.security.ui.login.forgotPassword'/></g:link>

				<input type='submit' class="btn btn-primary to-right" id="submit" value='${message(code: "spring.security.ui.login.login")}'/>
				<g:link controller='register' class="btn btn-default to-right">Register as new User</g:link>
			</div>

		</form>
	</div>
</div>

<script>
$(document).ready(function() {
	$('#username').focus();
});

<s2ui:initCheckboxes/>

</script>

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="${request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script src="${request.contextPath}/bootstrap/js/bootstrap.js"></script>

</body>
</html>
