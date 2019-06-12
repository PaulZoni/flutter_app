import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_app/entity/User.dart';
import 'package:flutter_app/network/request/IRequest.dart';

class RequestHandleUser implements IRequest {

  User _user;
  String _url = "http://b2p-auth.qr4.ru/v1/auth/login";

  RequestHandleUser(User user) {
    this._user = user;
  }

  String makeRandKey() {
    var r = new Random();
    String text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    text += possible.substring(r.nextInt(possible.length));
    return text;
  }

  @override
  Object getBody() {
    String randKey = makeRandKey();
    String key = _user.getId() + 'gg' + randKey;
    var bytes = utf8.encode(key);
    var body = {
      "soc_id": _user.getId(),
      "soc_network": "gg",
      "user_name": _user.getName(),
      "key": md5.convert(bytes).toString(),
      "rand_key": randKey,
      "client_id": "client_app",
      "response_type": "token",
      "state": "Мама мыла раму",
      "scope": "client_app",
    };

    return body;
  }

  @override
  Object getHeader() {
    return null;
  }

  @override
  String getUrl() => _url;
}