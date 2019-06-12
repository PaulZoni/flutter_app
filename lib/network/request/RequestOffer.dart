
import 'package:flutter_app/network/request/IRequest.dart';
import 'package:flutter_app/utils/FormData.dart';

class RequestOffer implements IRequest {

  String _urlOffer = "https://b2p-client.qr4.ru/v1/user/get-products";
  String _token;

  RequestOffer(String token) {
    this._token = token;
  }

  @override
  Object getBody() {

    Map body = {
      "page": "1",
      "size": "huge"
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
  String getUrl() => _urlOffer;
}