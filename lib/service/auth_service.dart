import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get userChanges => _auth.authStateChanges();
  String? errorMessage;

  Future<User?> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    }
    on FirebaseAuthException catch(e) {
      if(e.code == 'invalid-credential') {
        errorMessage = "Email or Password is wrong";
      }
      else if(e.code == 'user-disabled') {
        errorMessage = "Your account are banned by admin";
      }
      else {
        errorMessage = "Cannot login. Something went wrong !";
      }
      return null;
    }
    catch(e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}