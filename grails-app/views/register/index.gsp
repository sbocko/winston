<html>

<head>
	<meta name='layout' content='register'/>
	<title><g:message code='spring.security.ui.register.title'/></title>

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet"
		  href="${request.contextPath}/amelia/theme/bootstrap.css" media="screen">
	<link rel="stylesheet"
		  href="${request.contextPath}/amelia/theme/usebootstrap.css">
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

<div class="container bs-docs-section">
	<div class="well col-lg-6 centered">

		<g:if test='${command && command.getErrors().errorCount > 0}'>
			<div class="alert alert-dismissable alert-warning">
				<button type="button" class="close" data-dismiss="alert">×</button>
				<h4>Oh no!</h4>

				<g:each in="${(0..command.getErrors().fieldErrorCount-1).toList()}" var="index" >
					<g:if test='${command.getErrors().getFieldErrors().get(index).getCode().equals("nullable")}'>
						<g:if test='${command.getErrors().getFieldErrors().get(index).getField().equals("password2")}'>
							<p>Please repeat the password in the field below.</p>
						</g:if>
						<g:else>
							<p>Field ${command.getErrors().getFieldErrors().get(index).getField()} can't be empty</p>
						</g:else>
					</g:if>
					<g:else>
						<p><g:message code="${command.errors.getFieldErrors().get(index).getCode().toString()}" /></p>
					</g:else>
				</g:each>
			</div>
		</g:if>

		<h1 class="text-center">Create an account</h1>
		<g:form action='register' name="registerForm" autocomplete='off'>

			<g:if test='${emailSent}'>
				<p class="text-center"><g:message code='spring.security.ui.register.sent'/></p>
			</g:if>

			<g:else>
				<p><input type='text' class='form-control' name='username' placeholder="<g:message code='springSecurity.login.username.label'/>" bean="${command}" value="${command.username}"/></p>

				<p><input type='text' class='form-control' name='email' placeholder="E-mail" bean="${command}" value="${command.email}"/></p>

				<p><input type='password' class='form-control' name='password' placeholder="Password" bean="${command}" value="${command.password}"/></p>

				<p><input type='password' class='form-control' name='password2' placeholder="Password (again)" bean="${command}" value="${command.password2}"/></p>

				<s2ui:submitButton class="btn btn-primary" elementId='create' form='registerForm' messageCode='spring.security.ui.register.submit'/>

			</g:else>

		</g:form>
	</div>
</div>

<script>
$(document).ready(function() {
	$('#username').focus();
});
</script>

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="${request.contextPath}/amelia/bootstrap/bootstrap.min.js"></script>
<script src="${request.contextPath}/amelia/bootstrap/usebootstrap.js"></script>

</body>
</html>
