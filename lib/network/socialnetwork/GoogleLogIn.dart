import 'package:flutter_app/entity/User.dart';
import 'package:google_sign_in/google_sign_in.dart';


class GoogleLogIn {

  static final GoogleLogIn _singleton = new GoogleLogIn._internal();

  factory GoogleLogIn() {
    return _singleton;
  }

  GoogleLogIn._internal();

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> handleSignIn(Function callback) async {
    try {

      await _googleSignIn.signIn();
      callback(new User(
        _googleSignIn.currentUser.id,
        _googleSignIn.currentUser.displayName,
      ));

    } catch (error) {
      callback(null);
    }
  }

  Future<void> handleSignOut() async {
    _googleSignIn.disconnect();
  }
}

