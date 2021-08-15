$(function() {
  if ($(location).attr('pathname') == "/users/edit") {
    $("div.field_with_errors:has(label)").addClass("parent edit");
    $("div.field_with_errors:has(input)").addClass("edit");
  }
});