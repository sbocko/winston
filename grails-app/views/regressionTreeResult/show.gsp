<%@ page import="winston.RegressionTreeResult" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="bootstrap">
	<g:set var="entityName"
		   value="${message(code: 'regressionTreeResult.label', default: 'RegressionTreeResult')}"/>
</head>

<body>
<div class="body-container">
	<div id="show-regressionTreeResult" class="content scaffold-show" role="main">
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
					params="[id: regressionTreeResultInstance.getAnalysis().getId()]"
					style="text-decoration: none;">
				<button class="btn btn-info btn-sm">
					<span class="glyphicon glyphicon-chevron-left"></span> Back
				</button>
			</g:link>
		</div>

		<div class="row">
			<dl class="dl-horizontal">

				<g:if test="${regressionTreeResultInstance?.analysis}">
					<dt>
						<g:message code="regressionTreeResult.analysis.label" default="Analysis"/>
					</dt>
					<dd>
						<span class="vertical-aligner"></span>
						<g:link controller="analysis" action="show"
								id="${regressionTreeResultInstance?.analysis?.id}">${regressionTreeResultInstance?.analysis?.encodeAsHTML()}</g:link>
					</dd>
				</g:if>

				<dt>
					Model type
				</dt>
				<dd>
					<span class="vertical-aligner"></span>
					<a href="http://en.wikipedia.org/wiki/Logistic_regression" target="_blank">Regression tree</a>
				</dd>

				<dt>
					<g:message code="regressionTreeResult.minimumNumberOfInstancesPerLeaf.label" default="Minimum # of instances per leaf"/>
				</dt>
				<dd>
					<span class="vertical-aligner"></span>
					<g:fieldValue bean="${regressionTreeResultInstance}" field="minimumNumberOfInstancesPerLeaf"/>
				</dd>

				<dt>
					<g:message code="regressionTreeResult.minimumVarianceForSplit.label" default="Minimum variance for split"/>
				</dt>
				<dd>
					<span class="vertical-aligner"></span>
					<g:fieldValue bean="${regressionTreeResultInstance}" field="minimumVarianceForSplit"/>
				</dd>

				<dt>
					<g:message code="regressionTreeResult.numberOfFolds.label" default="Number of folds"/>
				</dt>
				<dd>
					<span class="vertical-aligner"></span>
					<g:fieldValue bean="${regressionTreeResultInstance}" field="numberOfFolds"/>
				</dd>

				<dt>
					<g:message code="regressionTreeResult.rmse.label" default="Rmse"/>
				</dt>
				<dd>
					<span class="vertical-aligner"></span>
					<g:fieldValue bean="${regressionTreeResultInstance}" field="rmse"/>
				</dd>

				<dt>
					<g:message code="regressionTreeResult.meanAbsoluteError.label" default="Mean Absolute Error"/>
				</dt>
				<dd>
					<span class="vertical-aligner"></span>
					<g:fieldValue bean="${regressionTreeResultInstance}" field="meanAbsoluteError"/>
				</dd>

				<dt>
					<g:message code="regressionTreeResult.summary.label" default="Summary"/>
				</dt>
				<dd>
					<span class="vertical-aligner"></span>
					<pre><g:fieldValue bean="${regressionTreeResultInstance}" field="summary"/></pre>
				</dd>
			</dl>
		</div>

	</div>
</div>
</body>
</html>
