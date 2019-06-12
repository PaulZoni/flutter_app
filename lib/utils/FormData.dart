
List createData(Map form_data) {
  var formBody = new List();

  form_data.forEach((property, value) {
    var encodedKey =  Uri.encodeFull(property);
    var encodedValue =  Uri.encodeFull(value);
    formBody.add(encodedKey + "=" + encodedValue);
  });
  formBody.join("&");

  return formBody;
}