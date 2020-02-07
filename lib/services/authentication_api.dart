//An abstract class that details all of the methods required of an authentication service class for this app.
//This is used so that we can call this class in our code when we need some authentication, instead of directly calling the firebase service.
//It is useful to do so in case we need to change our backend at some point, we dont have to change all of our code, just the service class.

abstract class AuthenticationApi {
  getAuth();
  Future<String> currentUserUid();
  Future<void> signOut();
  Future<String> signInWithEmailAndPassword({String email, String password});
  Future<String> createUserWithEmailAndPassword({String email, String password});
  Future<void> sendEmailVerification();
  Future<bool> isEmailVerified();
}