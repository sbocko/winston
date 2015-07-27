<%@ page import="winston.Dataset" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="bootstrap">

    <g:set var="entityName" value="${message(code: 'dataset.label', default: 'Dataset')}"/>
</head>

<body>
<div class="body-container">
    <div id="show-dataset" class="content scaffold-show" role="main">
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
            <g:link controller="analysis" class="index" action="create"
                    params="[id: datasetInstance.getId()]" style="text-decoration: none;">
                <button class="btn btn-info btn-sm">
                    <span class="glyphicon glyphicon-chevron-left"></span> Back
                </button>
            </g:link>
        </div>

        <p class="lead">
            Every analysis is preceded by a step called <a href="http://en.wikipedia.org/wiki/Data_pre-processing"
                                                           target="_blank">pre-processing</a>.
        Data goes through a series of steps during this phase. They are cleansed through processes such as replacing missing values or
        smoothing the noisy data. They can be normalized, aggregated, generalized, reduced or discretized to better fit into computation models.
        </p>

        <p class="lead">
            Answering the questions below, you will help us to pre-process your data <b>more accurate</b> which leads to better results.
        If you are not sure about the answers, you can run the analysis again with different options selected.
        </p>

        <div class="page-header"></div>

        <g:form class="lead">
            <% attrIdList.sort(){it.positionInDataFile}.each { attr -> %>
            <p class="attribute-question">Attribute <b>${attr.title}</b> has only <%=attr.getNumberOfDistinctValues()%> different values. Are they independent and do not have any order?</p>

            <g:radioGroup name="radioGroup${attr.id}"
                          labels="['yes', 'no']"
                          values="[1, 0]">
                <p class="radio-button">
                    ${it.radio}
                    ${it.label}
                </p>
            </g:radioGroup>

            <hr class="attribute-division-line">
            <% } %>

            <fieldset class="buttons">
                <g:hiddenField name="id" value="${datasetInstance?.id}"/>
                <g:hiddenField name="targetAttributeId" value="${targetAttributeId}"/>
                <g:hiddenField name="task" value="${task}"/>
                <fieldset class="buttons">
                    <button type="submit" name="_action_analyze" value="Next"
                            class="btn btn-success btn-md save">
                        <span class="glyphicon glyphicon-ok"></span> Finish
                    </button>
                </fieldset>
            </fieldset>
        </g:form>
    </div>
</div>
</body>
</html>
