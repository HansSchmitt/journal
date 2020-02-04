import 'package:firebase_auth/firebase_auth.dart';
import 'package:journal/services/authentication_api.dart';

class Authentication implements AuthenticationApi {
  //The Authentication class is a service class directly related to the use of Firebase as the authentication service.
  //It implements the abstract AuthenticationApi class so that other classes can
  //depend directly on the AuthenticationApi class(which has all methods needed from an authentication service)
  //and then be injected with this Authentication class. This allows us to change our authentication
  //provider by just changing this class and without having to change other code.

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  getAuth() {
    return _firebaseAuth;
  }

  Future<String> currentUserUid() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  Future<String> signInWithEmailAndPassword(
      {String email, String password}) async {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      {String email, String password}) async {
    _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}
