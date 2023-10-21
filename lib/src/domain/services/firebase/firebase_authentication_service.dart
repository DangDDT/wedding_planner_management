abstract class FirebaseAuthenticationService {
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<String> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<String> getCurrentUser();
  Future<bool> isUserLoggedIn();
}
