<%@ page import="winston.LinearRegressionResult" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="bootstrap">
	<g:set var="entityName"
		   value="${message(code: 'linearRegressionResult.label', default: 'LinearRegressionResult')}"/>
</head>

<body>
<div class="body-container">
	<div id="show-linearRegressionResult" class="content scaffold-show" role="main">
		<div class="page-header">
			<g:if test='${flash.message}'>
				<div class="alert alert-dismissable alert-info">
					<button type="button" class="close" data-dismiss="alert">×</button>
					<h4>Check out</h4>

					<p>${flash.message}</p>
				</div>
			</g:if>

			<h1 class="lead">Model detail</h1>
		</div>

		<div class="lead">
			<g:link controller="analysis" class="index" action="show"
					params="[id: linearRegressionResultInstance.getAnalysis().getId()]"
					style="text-decoration: none;">
				<button class="btn btn-info btn-sm">
					<span class="glyphicon glyphicon-chevron-left"></span> Back
				</button>
			</g:link>
		</div>

		<div class="row">
			<dl class="dl-horizontal">

				<g:if test="${linearRegressionResultInstance?.analysis}">
					<dt>
						<g:message code="linearRegressionResult.analysis.label" default="Analysis"/>
					</dt>
					<dd>
						<span class="vertical-aligner"></span>
						<g:link controller="analysis" action="show"
								id="${linearRegressionResultInstance?.analysis?.id}">${linearRegressionResultInstance?.analysis?.encodeAsHTML()}</g:link>
					</dd>
				</g:if>

				<dt>
					Model type
				</dt>
				<dd>
					<span class="vertical-aligner"></span>
					<a href="http://en.wikipedia.org/wiki/Logistic_regression" target="_blank">Linear regression</a>
				</dd>

				<dt>
					<g:message code="linearRegressionResult.ridge.label" default="Ridge"/>
				</dt>
				<dd>
					<span class="vertical-aligner"></span>
					<g:fieldValue bean="${linearRegressionResultInstance}" field="ridge"/>
				</dd>

				<dt>
					<g:message code="linearRegressionResult.rmse.label" default="Rmse"/>
				</dt>
				<dd>
					<span class="vertical-aligner"></span>
					<g:fieldValue bean="${linearRegressionResultInstance}" field="rmse"/>
				</dd>

				<dt>
					<g:message code="linearRegressionResult.meanAbsoluteError.label" default="Mean Absolute Error"/>
				</dt>
				<dd>
					<span class="vertical-aligner"></span>
					<g:fieldValue bean="${linearRegressionResultInstance}" field="meanAbsoluteError"/>
				</dd>

				<dt>
					<g:message code="linearRegressionResult.summary.label" default="Summary"/>
				</dt>
				<dd>
					<span class="vertical-aligner"></span>
					<pre><g:fieldValue bean="${linearRegressionResultInstance}" field="summary"/></pre>
				</dd>
			</dl>
		</div>

	</div>
</div>
</body>
</html>
