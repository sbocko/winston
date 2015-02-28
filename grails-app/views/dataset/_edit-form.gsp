<%@ page import="winston.Dataset" %>

<div class="input-group col-md-4 lead fieldcontain ${hasErrors(bean: datasetInstance, field: 'title', 'error')} ">
	<label for="title" class="input-group-addon">
		<g:message code="dataset.title.label" default="Title" />
	</label>
	<g:textField class="form-control" name="title" placeholder="name your dataset..." value="${datasetInstance?.title}"/>
</div>

<div class="form-group col-md-4 lead fieldcontain ${hasErrors(bean: datasetInstance, field: 'description', 'error')} ">
    <label class="lead" for="description">
        <g:message class="input-group-addon" code="dataset.description.label" default="Description"/>
    </label>
    <g:textArea class="form-control" placeholder="This is a place for your notes..." name="description" cols="40" rows="5" maxlength="5000" value="${datasetInstance?.description}"/>
</div>