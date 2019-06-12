import 'package:flutter_app/network/request/IRequest.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app/network/NetworkService.dart';

class NetworkHelper {

  NetworkService _networkService;

  NetworkHelper() {
    this._networkService = new NetworkService();
  }

  Observable requestObservable(IRequest request) {
    return Observable.fromFuture(
        this._networkService.execute(request)
    );
  }
}