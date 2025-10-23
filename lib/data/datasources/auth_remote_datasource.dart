import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(
    String email,
    String password,
    String name,
    String role,
  );
  Future<void> logout();
  Future<UserModel> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      print('Attempting login for: $email');

      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw AuthException('Login failed: No user returned');
      }

      print('Firebase auth successful, fetching user data...');

      final userDoc = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        throw AuthException('User data not found in Firestore');
      }

      print('Login successful');
      return UserModel.fromJson(userDoc.data()!);
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuth error: ${e.code} - ${e.message}');
      String errorMessage = 'Login failed';
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled';
          break;
        default:
          errorMessage = e.message ?? 'Login failed';
      }
      throw AuthException(errorMessage);
    } catch (e) {
      print('Login error: $e');
      throw AuthException(e.toString());
    }
  }

  @override
  Future<UserModel> register(
    String email,
    String password,
    String name,
    String role,
  ) async {
    try {
      print('Attempting registration for: $email');

      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw AuthException('Registration failed: No user returned');
      }

      print('Firebase auth successful, creating user document...');

      final userModel = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        role: role,
        createdAt: DateTime.now(),
      );

      await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toJson());

      print('Registration successful');
      return userModel;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuth error: ${e.code} - ${e.message}');
      String errorMessage = 'Registration failed';
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        case 'weak-password':
          errorMessage = 'Password is too weak';
          break;
        default:
          errorMessage = e.message ?? 'Registration failed';
      }
      throw AuthException(errorMessage);
    } catch (e) {
      print('Registration error: $e');
      throw AuthException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw AuthException('Logout failed');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final user = firebaseAuth.currentUser;

      if (user == null) {
        throw AuthException('No user logged in');
      }

      print('Getting user data for UID: ${user.uid}');

      final userDoc = await firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        print('User document not found, creating...');
        throw AuthException('User data not found');
      }

      final userData = userDoc.data();
      if (userData == null) {
        throw AuthException('User data is null');
      }

      print('User data retrieved successfully');
      return UserModel.fromJson(userData);
    } on AuthException {
      rethrow;
    } catch (e) {
      print('getCurrentUser error: $e');
      throw AuthException('Failed to get current user: ${e.toString()}');
    }
  }
}
