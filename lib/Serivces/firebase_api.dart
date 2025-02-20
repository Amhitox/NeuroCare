import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neurocare/Serivces/google_service.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn google = GoogleSignIn();

class Auth {
  Future<UserCredential?> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential?> signUp(
      String email, String password, String name) async {
    UserCredential? user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseFirestore.instance.collection('users').doc(user.user!.uid).set({
      'id': user.user!.uid,
      'name': name,
      'email': email,
      'phone': user.user!.phoneNumber ?? '',
      'status': 'active',
      'joinDate': DateTime.now().toIso8601String(),
      'emergencyContacts': [],
      'medicalHistory': [],
      'role': 'client',
      'signInMethod': 'google',
    });
    return user;
  }

  Future<GoogleSignInService> loginWithGoogle() async {
    return GoogleSignInService();
  }
}
