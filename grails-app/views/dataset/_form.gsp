<%@ page import="winston.Dataset" %>

<div class="input-group col-md-4 lead fieldcontain ${hasErrors(bean: datasetInstance, field: 'title', 'error')}">
    <label for="title" class="input-group-addon">
        <g:message code="dataset.title.label" default="Title"/>
    </label>
    <g:textField class="form-control" placeholder="give a name to your dataset..." name="title"
                 value="${datasetInstance?.title}"/>
</div>

%{--http://weblogs.asp.net/jdanforth/formatting-file-upload-input-with-bootstrap--}%
<script type="text/javascript">
    $(document).ready(function () {
        $(document).on('change', '.btn-file :file', function () {
            var input = $(this),
                    numFiles = input.get(0).files ? input.get(0).files.length : 1,
                    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
            input.trigger('fileselect', [numFiles, label]);
        });

        $('.btn-file :file').on('fileselect', function (event, numFiles, label) {
            console.log(numFiles);
            console.log(label);
            $("#filename_input_field").val(label);
        });
    });
</script>
<div class="input-group col-md-4 lead fieldcontain ${hasErrors(bean: datasetInstance, field: 'dataFile', 'error')}">
    <span class="input-group-btn">
        <span class=" btn btn-default btn-file">
            Browse <input type="file" name="dataFile" id="dataFile"/>
        </span>
    </span>
    <input type="text" placeholder="choose a file" id="filename_input_field" class="form-control" readonly/>
</div>

<div class="input-group col-md-4 lead fieldcontain ${hasErrors(bean: datasetInstance, field: 'missingValuePattern', 'error')} ">
    <label for="missingValuePattern" class="input-group-addon">
        <g:message code="dataset.missingValuePattern.label" default="Missing Value Pattern"/>
    </label>
    <g:textField class="form-control" placeholder="label for missing values (e.g. ?)" name="missingValuePattern" value="${datasetInstance?.missingValuePattern}"/>
</div>

<div class="form-group col-md-4 lead fieldcontain ${hasErrors(bean: datasetInstance, field: 'description', 'error')} ">
    <label class="lead" for="description">
        <g:message class="input-group-addon" code="dataset.description.label" default="Description"/>
    </label>
    <g:textArea class="form-control" placeholder="This is a place for your notes..." name="description" cols="40" rows="5" maxlength="5000" value="${datasetInstance?.description}"/>
</div>


