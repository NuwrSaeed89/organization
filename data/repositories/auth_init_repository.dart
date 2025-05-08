import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthInitRepository extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Waits until currentUser is not null
  Future<AuthInitRepository> init() async {
    if (_auth.currentUser == null) {
      // Listen to auth changes until a user is available
      await _auth.authStateChanges().firstWhere((user) => user != null);
    }
    return this;
  }

  /// Optionally expose the user UID
  String get userId => _auth.currentUser?.uid ?? '';
}
