
import 'package:flutter_app/network/request/IRequest.dart';
import 'package:flutter_app/utils/FormData.dart';

class RequestUserOperations implements IRequest {

  String _token;
  int _page;
  String _urlOperations = "http://b2p-client.qr4.ru/v1/user/get-operations";

  RequestUserOperations(String token, int page) {
    this._token = token;
    this._page = page;
  }

  @override
  Object getBody() {
    Map body = {
      "size": "big",
      "page": _page.toString()
    };
    return createData(body).join("&");
  }

  @override
  Object getHeader() {
    var headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Authorization": "Bearer " + _token
    };

    return headers;
  }

  @override
  String getUrl() => _urlOperations;

}