import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Kullanıcı bilgilerini Firestore'dan getirir
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) return doc.data();
    return null;
  }

  // Kullanıcı bilgilerini Firestore'a kaydeder/günceller
  Future<void> updateUserData({
    required String userId,
    required String birthDate,
    required String birthPlace,
    required String city,
  }) async {
    await _firestore.collection('users').doc(userId).set({
      'birthDate': birthDate,
      'birthPlace': birthPlace,
      'city': city,
    }, SetOptions(merge: true));
  }
}
