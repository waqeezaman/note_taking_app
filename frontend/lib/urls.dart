String androidHost = "10.0.2.2:8000";

var retrieveURL = Uri.http(androidHost, '/api/all_notes/');
var deleteURL = Uri.http(androidHost, '/api/delete/');
var getNoteURL = Uri.http(androidHost, '/api/note/');
var createURL = Uri.http(androidHost, '/api/create_note/');

Uri getDeleteURL(int id) {
  var deleteURL = Uri.http(androidHost, '/api/delete_note/$id/');
  return deleteURL;
}

Uri getUpdateURL(int id) {
  var updateURL = Uri.http(androidHost, '/api/update_note/$id/');
  return updateURL;
}
