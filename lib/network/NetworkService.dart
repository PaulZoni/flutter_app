import 'package:flutter_app/network/request/IRequest.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class NetworkService {

  Future<http.Response> execute(IRequest networkRequest) async {

      try {
        var answer = await http.post(
            networkRequest.getUrl(),
            body:  networkRequest.getBody() ,
            headers: networkRequest.getHeader(),
        );

        return answer;
      }catch (e) {
        log("NetworkService.dart ");
        return null;
      }
  }
}