<%@ page import="winston.Dataset" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">

    <g:set var="entityName" value="${message(code: 'dataset.label', default: 'Dataset')}"/>
</head>

<body>
<div id="create-analysis" class="content scaffold-show" role="main">

    <div class="page-header">
        <g:if test='${flash.message}'>
            <div class="alert alert-dismissable alert-info">
                <button type="button" class="close" data-dismiss="alert">×</button>
                <h4>Check out</h4>

                <p>${flash.message}</p>
            </div>
        </g:if>

        <g:if test='${flash.error}'>
            <div class="alert alert-dismissable alert-danger">
                <button type="button" class="close" data-dismiss="alert">×</button>
                <h4>Oh no!</h4>

                <p>${flash.error}</p>
            </div>
        </g:if>

        <g:if test="${datasetInstance != null && datasetInstance.getTitle() != null}">
            <h1 class="lead">Analyze ${datasetInstance.getTitle()}</h1>
        </g:if>
        <g:else>
            <h1 class="lead">Analyze</h1>
        </g:else>
    </div>

    <div class="lead">
        <g:link controller="dataset" class="index" action="show"
                params="[id: datasetInstance.getId()]" style="text-decoration: none;">
            <button class="btn btn-info btn-sm">
                <span class="glyphicon glyphicon-chevron-left"></span> Back
            </button>
        </g:link>
    </div>

    <p class="lead">
        Data-mining deals with several tasks which differ in the kind of knowledge to be mined from your data.
        Basically, there are two major groups:
    </p>

    <ol class="lead" type="1">
        <li>
            <p class="bottom-padding"><b>Predictive</b> - this group solves the problem of assigning a new object to a certain class based on its similarity
                                to previous examples of other objects. For example, a predictive model could be used to predict
                                loan applicants as low, medium, or high credit risks based on observed data for many loan applicants
                                over a period of time. Choose regression task if you want to predict value of numeric attribute or
                                classification otherwise.</p>

            <div class="text-center lead">
                <g:link class="index" action="regression"
                        params="[id: datasetInstance.getId()]" style="text-decoration: none;">
                    <button type="button" class="btn btn-lg btn-default">Use regression</button>
                </g:link>

                <g:link class="index" action="classification"
                        params="[id: datasetInstance.getId()]" style="text-decoration: none;">
                    <button type="button" class="btn btn-lg btn-default">Use classification</button>
                </g:link>
            </div>

        </li>
        <li>
            <p class="bottom-padding"><b>Descriptive</b> -  models deal with the general properties of your data.
                                It can find associations and correlations between attributes. Also you can find frequent
                                patterns in your data or discover hidden clusters. Choose pattern mining if you want to
                                learn more about your data.</p>

            <div class="text-center lead">
                <g:link class="index" action="pattern"
                        params="[id: datasetInstance.getId()]" style="text-decoration: none;">
                    <button type="button" class="btn btn-lg btn-default">Use pattern mining</button>
                </g:link>
            </div>

        </li>
    </ol>




</div>
</body>
</html>
