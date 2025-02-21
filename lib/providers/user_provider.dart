import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurocare/Serivces/firebase_api.dart';

final userProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  String? currentUser = await Auth.getCurrentUserUid();
  if (currentUser == null) return null;

  DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('users')
      .doc(currentUser)
      .get();

  if (!snapshot.exists || snapshot.data() == null) {
    print('Document does not exist or data is null');
    return null;
  }

  final userData = snapshot.data();
  print('Fetched user data from Firestore: $userData');
  print('Medical History from Firestore: ${userData?['medicalHistory']}');

  return userData!;
});
