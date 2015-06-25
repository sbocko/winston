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
        A method, which will analyze your data is called
        <a href="http://en.wikipedia.org/wiki/Statistical_classification" target="_blank">classification</a>.
    It solves the problem of <b>assigning</b> a new object to a <b>certain class</b> based on its similarity
    to previous examples of other objects. For example, a classification model could be used to identify
    loan applicants as low, medium, or high credit risks based on observed data for many loan applicants
    over a period of time.
    </p>

    <p class="lead">
        Before we analyze your data, you have to <b>choose an attribute</b> which represents an <b>outcome</b> for you.
    This target attribute has to be discrete and do not imply order. Continuous, floating-point values
    would indicate a numerical, rather than a categorical, target. A predictive model with a numerical
    target uses a regression method, not a classification method.
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
