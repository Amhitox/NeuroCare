import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neurocare/Serivces/google_service.dart';

final GoogleSignIn google = GoogleSignIn();

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<UserCredential?> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw 'No user found for that email.';
        case 'wrong-password':
          throw 'Wrong password provided.';
        case 'invalid-email':
          throw 'Invalid email address.';
        case 'user-disabled':
          throw 'This account has been disabled.';
        default:
          throw 'An error occurred during login.';
      }
    } catch (e) {
      throw 'An unexpected error occurred.';
    }
  }

  static Future<UserCredential?> signUp(
      String email, String password, String name) async {
    UserCredential? user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseFirestore.instance.collection('users').doc(user.user!.uid).set({
      'id': user.user!.uid,
      'name': name,
      'email': email,
      'phone': user.user!.phoneNumber ?? '0622107249',
      'status': 'active',
      'joinDate': DateTime.now().toIso8601String(),
      'medicalHistory': ['amhita', 'dhsis'],
    });
    return user;
  }

  static Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('email sent');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<UserCredential?> loginWithGoogle() async {
    return GoogleSignInService.signInWithGoogle();
  }

  static Future<String?> getCurrentUserUid() async {
    return _auth.currentUser?.uid;
  }

  static Future signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
      await GoogleSignIn().disconnect();

      print('ur out');
    } catch (e) {
      print('problem signOut');
    }
  }
}
