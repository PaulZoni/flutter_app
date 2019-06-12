import 'dart:core';
import 'package:flutter_app/network/request/IRequest.dart';
import 'package:flutter_app/utils/FormData.dart';

class RequestDataUser implements IRequest {

  String _token;
  String _userId;
  String _lastMessageId;
  String _urlDataUser = "http://b2p-client.qr4.ru/v1/user/get-data";

  RequestDataUser(String token, String lastMessageId, String userId) {
    this._token = token;
    this._lastMessageId = lastMessageId;
    this._userId = userId;
  }

  @override
  Object getBody() {
    Map body = {
      "user_id": _userId,
      "size": "big",
      "last_message_id": _lastMessageId,
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
  String getUrl() {
    return _urlDataUser;
  }
}