import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models/models.dart' as model;
import '../authentication_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

extension AuthenticationStatusX on AuthenticationStatus {
  get isAuthenticated => this == AuthenticationStatus.authenticated;
}

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthenticationRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firebaseFirestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

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

  String? get _currentUserId => _firebaseAuth.currentUser?.uid;

  Future<void> logOut() {
    return _firebaseAuth.signOut();
  }

  Stream<model.User> user(String id) {
    return _firebaseFirestore
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snap) => model.User.fromEntity(UserEntity.fromDocumentSnapshot(snap)));
  }

  Future<UserCredential> loginWithEmailAndPassword({required String email, required String password}) async {
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createUserWithEmailAndPassword({required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } catch (e) {
      print('Create error $e');
      throw e;
    }
  }
}
