$(function() {
  if ($(location).attr('pathname') == "/users/edit") {
    $("div.field_with_errors:has(label)").addClass("parent edit");
    $("div.field_with_errors:has(input)").addClass("edit");
  } else if ($(location).attr('pathname') == "/users/profile") {
    $("div.field_with_errors:has(label)").addClass("parent profile");
    $("div.field_with_errors:has(input)").addClass("profile");
    $("label").css("max-width","100%");
    $("input").css("max-width","100%");
  } else if ($(location).attr('pathname') == "/rooms/new") {
    $("div.field_with_errors:has(label)").addClass("parent room_new");
    $("div.field_with_errors:has(input)").addClass("room_new");
    $("div.field_with_errors:has(textarea)").addClass("room_new");
    $("label").css("max-width","100%");
    $("input").css("max-width","100%");
    $("textarea").css("max-width","100%");
  }
});