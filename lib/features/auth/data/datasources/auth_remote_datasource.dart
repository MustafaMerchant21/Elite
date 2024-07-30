import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDatasource {
  Future<String> signUpWithEmailPassword({
    required String name, required String email, required String password
  });

  Future<String> loginWithEmailPassword({
    required String email, required String password
  });
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDatasourceImpl(this.firebaseAuth);

  @override
  Future<String> loginWithEmailPassword({
    required String email, required String password
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw const ServerException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw const ServerException('Wrong password provided for that user.');
      } else {
        throw ServerException(e.message ?? 'An unknown error occurred.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name, required String email, required String password
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Update the user's profile with the name
      await credential.user!.updateProfile(displayName: name);
      // Reload the user to get the updated profile information
      await credential.user!.reload();
      await FirebaseFirestore.instance.collection('users').add({
        'name': name,
        'email':email,
        'admin':false,
        'profileImage':''
      });
      return credential.user!.uid.toString();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw const ServerException('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw const ServerException('The account already exists for that email.');
      } else {
        throw ServerException(e.message ?? 'An unknown error occurred.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
