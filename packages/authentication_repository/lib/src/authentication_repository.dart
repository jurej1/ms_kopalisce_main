import 'package:firebase_auth/firebase_auth.dart';

import 'models/models.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

extension AuthenticationStatusX on AuthenticationStatus {
  bool get isAuthenticated => this == AuthenticationStatus.authenticated;
}

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;

  AuthenticationRepository({FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<AuthenticationUser?> get authenticationUser {
    return _firebaseAuth.authStateChanges().map(
      (user) {
        if (user == null) return null;
        return AuthenticationUser(
          UserInfo(
            {
              'uid': user.uid,
              'displayName': user.displayName,
              'email': user.email,
              'phoneNumber': user.phoneNumber,
              'photoURL': user.photoURL,
              'providerId': user.providerData.first.providerId,
            },
          ),
        ); // Test this user info
      },
    );
  }

  Future<void> logOut() {
    return _firebaseAuth.signOut();
  }

  Future<UserCredential> loginWithEmailAndPassword({required String email, required String password}) async {
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createUserWithEmailAndPassword({required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } catch (e) {
      throw e;
    }
  }
}
