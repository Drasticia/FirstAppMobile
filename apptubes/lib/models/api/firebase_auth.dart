import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign In Anonymously
  Future<User?> signInAnonymous() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      return credential.user;
    } catch(e){
      print("Gagal melakukan sign-in");
      print(e.toString());
    }
    return null;
  }

  // Sign Up method
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e){
      print("Akun sudah pernah didaftarkan.");
    }
    return null;
  }

  // Sign In method
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e){
      print(e);
    }
    return null;
  }

  // Send email for reset password
  Future<User?> passwordReset(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
    } catch(e){
      print(e.toString());
    }
    return null;
  }

}