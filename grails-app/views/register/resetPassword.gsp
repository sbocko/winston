<html>

<head>
    <title><g:message code='spring.security.ui.resetPassword.title'/></title>
    <meta name='layout' content='register'/>

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

        <g:if test='${flash.error}'>
            <div class="alert alert-dismissable alert-warning">
                <button type="button" class="close" data-dismiss="alert">×</button>
                <h4>Oh no!</h4>
                <p>${flash.error}</p>
            </div>
        </g:if>
        <h1 class="text-center"><g:message class='text-center' code='spring.security.ui.resetPassword.description'/></h1>
        <g:form action='resetPassword' name='resetPasswordForm' autocomplete='off'>
            <g:hiddenField name='t' value='${token}'/>
            <div class="sign-in">


                %{--<p><input type='text' class='form-control' name='password' placeholder="Password"/></p>--}%
                <p><s2ui:passwordFieldRow name='password' labelCode='resetPasswordCommand.password.label' bean="${command}"
                                       labelCodeDefault='Password' value="${command?.password}"/></p>

                <p><s2ui:passwordFieldRow name='password2' labelCode='resetPasswordCommand.password2.label'
                                       bean="${command}"
                                       labelCodeDefault='Password (again)' value="${command?.password2}"/></p>


                <s2ui:submitButton class="btn btn-primary" elementId='reset' form='resetPasswordForm'
                                   messageCode='spring.security.ui.resetPassword.submit'/>

            </div>
        </g:form>
    </div>
</div>


<script>
    $(document).ready(function () {
        $('#password').focus();
    });
</script>

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="${request.contextPath}/amelia/bootstrap/bootstrap.min.js"></script>
<script src="${request.contextPath}/amelia/bootstrap/usebootstrap.js"></script>

</body>
</html>
