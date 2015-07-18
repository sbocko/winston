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
        <g:link class="index" action="create"
                params="[id: datasetInstance.getId()]" style="text-decoration: none;">
            <button class="btn btn-info btn-sm">
                <span class="glyphicon glyphicon-chevron-left"></span> Back
            </button>
        </g:link>
    </div>

    <p class="lead">
        A method, which will analyze your data is called
        <a href="https://en.wikipedia.org/wiki/Regression_analysis" target="_blank">regression</a>.
    It solves the problem of <b>assigning</b> a numeric value to a new object based on its similarity
    to previous examples of other objects. For example, a regression model could be used to evaluate
    a price of a flat based on the similar flats in neighborhood.
    </p>

    <p class="lead">
        Before we analyze your data, you have to <b>choose an attribute</b> which represents an <b>outcome</b> for you.
    This target attribute has to be numeric with standard ordering. A predictive model with discrete values
    uses a classification method, not a regression method.
    </p>

    <p class="lead">
        Choose a target attribute:
    </p>
    <g:form>
        <g:radioGroup name="targetAttributeRadioGroup"
                      labels="${datasetInstance.getAttributes().sort() { it.positionInDataFile }.title}"
                      values="${datasetInstance.getAttributes().sort() { it.positionInDataFile }.id}"
                      value="${params.currentTargetAttribute}">
            <p class="lead radio-button">
                ${it.radio}
                ${it.label}
            </p>
        </g:radioGroup>

        <fieldset class="buttons">
            <g:hiddenField name="id" value="${datasetInstance?.id}"/>
            <g:hiddenField name="task" value="${task}"/>
            <fieldset class="buttons">
                <button type="submit" name="_action_getTargetAttribute" value="Next"
                        class="btn btn-success btn-md save">
                    Continue <span class="glyphicon glyphicon-chevron-right"></span>
                </button>
            </fieldset>
        </fieldset>
    </g:form>
</div>
</body>
</html>
