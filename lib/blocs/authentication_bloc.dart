import 'dart:async';
import '../services/authentication_api.dart';

class AuthenticationBloc {

  final AuthenticationApi authenticationApi; //An abstract class that details methods required from any authentication service used by this app.

  final StreamController<String> _authenticationController = StreamController<String>();
  Sink<String> get addUser => _authenticationController.sink;
  Stream<String> get user => _authenticationController.stream;

  final StreamController<bool> _logoutController = StreamController<bool>();
  Sink<bool> get logoutUser => _logoutController.sink;
  Stream<bool> get listLogoutUser => _logoutController.stream;

  //This constructor takes in an AuthenticationApi type, however in practice we
  // inject an authentication service class that implements the AuthenticationApi class.
  //Having this class take in the abstract class gives us the option to change the
  //authentication service provider sometime in the future
  //without having to change this code.
  AuthenticationBloc(this.authenticationApi) {
    onAuthChanged();
  }

  void dispose() {
    _authenticationController.close();
    _logoutController.close();
  }

  //This method creates listeners that
  void onAuthChanged() {
    //This listener awaits information from the Stream<FirebaseUser> onAuthStateChanged stream,
    //and then adds the user uid to the Sink<String> addUser sink.
    //Subsequently, any code listening on the Stream<String> user stream will be notified of a user being authenticated.
    authenticationApi
        .getAuth()
        .onAuthStateChanged
        .listen((user) {
          final String uid = user != null ? user.uid : null;
          addUser.add(uid);
    });

    //This listener awaits information from the Stream<bool> listLogoutUser stream,
    //and if the result is true(a log out command was sent) the user is signed out.
    _logoutController.stream.listen((logout) {
      if (logout == true) {
        _signOut();
      }
    });
  }

  //This method uses the authentication service class to sign the user out of the app and end the authentication instance.
  void _signOut() {
    authenticationApi.signOut();
  }
}