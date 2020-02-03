import 'package:firebase_auth/firebase_auth.dart';
import 'package:journal/services/authentication_api.dart';

class Authentication implements AuthenticationApi{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  getFirebaseAuth() {
    return _firebaseAuth;
  }

  Future<String> currentUserUid() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  Future<String> signInWithEmailAndPassword({String email, String password}) async {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword({String email, String password}) async {
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
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