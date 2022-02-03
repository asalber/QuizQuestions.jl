## Could tidy up this HTML to make it look nicer
html_templates = Dict()

const grading_partial = """
  if(correct) {
    msgBox.innerHTML = "<div class='pluto-output admonition note alert alert-success'><span class='glyphicon glyphicon-thumbs-up'>👍&nbsp;Correct</span></div>";
  } else {
    msgBox.innerHTML = "<div class='pluto-output admonition alert alert-danger'><span class='glyphicon glyphicon-thumbs-down'>👎&nbsp; Incorrect</span></div>";
  }
"""

## Basic question
## has label and hint option.
## Hint is put with label when present; otherwise, it appears at bottom of form.
## this is overridden with input widget in how show method is called
html_templates["question_tpl"] = mt"""
<form class="mx-2 my-3" name='WeaveQuestion' data-id='{{:ID}}' data-controltype='{{:TYPE}}'>
  <div class='form-group {{:STATUS}}'>
    <div class='controls'>
      <div class="form-floating input-group" id="controls_{{:ID}}">
    {{#:LABEL}}
        <label for="controls_{{:ID}}">{{{:LABEL}}}{{#:HINT}}<span href="#" title='{{{:HINT}}}'>&nbsp;🎁</span>{{/:HINT}}
</label>
    {{/:LABEL}}
        <div style="padding-top: 5px">
    {{{:FORM}}}
    {{^:LABEL}}{{#:HINT}}<label for="controls_{{:ID}}"><span href="#" title='{{{:HINT}}}'>&nbsp;🎁</span></label>{{/:HINT}}{{/:LABEL}}
        </div>
      </div>
      <div id='{{:ID}}_message' style="padding-bottom: 15px">
      </div>
    </div>
  </div>
</form>

<script text='text/javascript'>
{{{:GRADING_SCRIPT}}
</script>
"""

html_templates["input_grading_script"] = jmt"""
document.getElementById("{{:ID}}").addEventListener("change", function() {
  var correct = {{{:CORRECT}}};
  var msgBox = document.getElementById('{{:ID}}_message');
  $(grading_partial)
});
"""

##
html_templates["inputq_form"] = mt"""
<div class="row">
  <span style="width:90%">
    <input id="{{:ID}}" type="{{:TYPE}}" class="form-control" placeholder="{{:PLACEHOLDER}}">
  </span>
  <span style="width:10%">{{#:UNITS}}{{{:UNITS}}}{{/:UNITS}}{{#:HINT}}<span href="#" title='{{{:HINT}}}'>&nbsp;🎁</span>{{/:HINT}}
  </span>
</div>
"""

## Multiple choice (one of many)
## XXX add {{INLINE}}
html_templates["Radioq"] = mt"""
{{#:ITEMS}}
<div class="form-check">
  <label>
    <input class="form-check-input" type="radio" name="radio_{{:ID}}"
              id="radio_{{:ID}}_{{:VALUE}}" value="{{:VALUE}}">
      <span = class="label-body">
        {{{:LABEL}}}
      </span>
    </input>
  </label>
</div>
{{/:ITEMS}}
"""

html_templates["radio_grading_script"] = """
document.querySelectorAll('input[name="radio_{{:ID}}"]').forEach(function(rb) {
rb.addEventListener("change", function() {
    var correct = rb.value == {{:CORRECT_ANSWER}};
    var msgBox = document.getElementById('{{:ID}}_message');
    $(grading_partial)
})});
"""
