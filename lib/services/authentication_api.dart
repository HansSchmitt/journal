//An abstract class that details all of the methods required of an authentication service class for this app.

abstract class AuthenticationApi {
  getAuth();
  Future<String> currentUserUid();
  Future<void> signOut();
  Future<String> signInWithEmailAndPassword({String email, String password});
  Future<String> createUserWithEmailAndPassword({String email, String password});
  Future<void> sendEmailVerification();
  Future<bool> isEmailVerified();
}