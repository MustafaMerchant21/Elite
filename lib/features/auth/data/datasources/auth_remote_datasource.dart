import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:elite/features/auth/data/models/user_model.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel> signUpWithEmailPassword(
      {required String name, required String email, required String password});

  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password});
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  AuthRemoteDatasourceImpl(this.firebaseAuth, this.firebaseStorage);

  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user != null) {
        // Fetch user data from Firestore
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userData.exists) {
          return UserModel(
            id: user.uid,
            email: user.email ?? '',
            name: userData.data()?['name'] ?? '',
          );
        } else {
          throw const ServerException('User data not found in Firestore.');
        }
      } else {
        throw const ServerException('Failed to sign in user.');
      }
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
  Future<UserModel> signUpWithEmailPassword(
      {required String name,
        required String email,
        required String password}) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user != null) {
        // Update the user's profile with the name
        await user.updateProfile(displayName: name);
        await user.reload();

        // Picking a random image from a predefined list of avatars
        final List<String> allAvatars = [
          'assets/images/Female avatars/1.png',
          'assets/images/Female avatars/10.png',
          'assets/images/Female avatars/14.png',
          'assets/images/Female avatars/15.png',
          'assets/images/Female avatars/16.png',
          'assets/images/Female avatars/18.png',
          'assets/images/Female avatars/20.png',
          'assets/images/Female avatars/21.png',
          'assets/images/Female avatars/23.png',
          'assets/images/Female avatars/25.png',
          'assets/images/Female avatars/27.png',
          'assets/images/Female avatars/28.png',
          'assets/images/Female avatars/30.png',
          'assets/images/Female avatars/32.png',
          'assets/images/Female avatars/35.png',
          'assets/images/Female avatars/38.png',
          'assets/images/Female avatars/39.png',
          'assets/images/Female avatars/4.png',
          'assets/images/Female avatars/40.png',
          'assets/images/Female avatars/41.png',
          'assets/images/Female avatars/44.png',
          'assets/images/Female avatars/45.png',
          'assets/images/Female avatars/47.png',
          'assets/images/Female avatars/48.png',
          'assets/images/Female avatars/50.png',
          'assets/images/Female avatars/51.png',
          'assets/images/Female avatars/52.png',
          'assets/images/Female avatars/56.png',
          'assets/images/Female avatars/57.png',
          'assets/images/Female avatars/58.png',
          'assets/images/Female avatars/6.png',
          'assets/images/Female avatars/60.png',
          'assets/images/Female avatars/61.png',
          'assets/images/Female avatars/62.png',
          'assets/images/Female avatars/63.png',
          'assets/images/Female avatars/66.png',
          'assets/images/Female avatars/7.png',
          'assets/images/Female avatars/9.png',
          'assets/images/Male avatars/42.png',
          'assets/images/Male avatars/43.png',
          'assets/images/Male avatars/46.png',
          'assets/images/Male avatars/49.png',
          'assets/images/Male avatars/53.png',
          'assets/images/Male avatars/54.png',
          'assets/images/Male avatars/55.png',
          'assets/images/Male avatars/59.png',
          'assets/images/Male avatars/64.png',
          'assets/images/Male avatars/65.png',
          'assets/images/Male avatars/Avatar=11.png',
          'assets/images/Male avatars/Avatar=12.png',
          'assets/images/Male avatars/Avatar=13.png',
          'assets/images/Male avatars/Avatar=17.png',
          'assets/images/Male avatars/Avatar=19.png',
          'assets/images/Male avatars/Avatar=2.png',
          'assets/images/Male avatars/Avatar=22.png',
          'assets/images/Male avatars/Avatar=24.png',
          'assets/images/Male avatars/Avatar=26.png',
          'assets/images/Male avatars/Avatar=29.png',
          'assets/images/Male avatars/Avatar=3.png',
          'assets/images/Male avatars/Avatar=31.png',
          'assets/images/Male avatars/Avatar=33.png',
          'assets/images/Male avatars/Avatar=34.png',
          'assets/images/Male avatars/Avatar=36.png',
          'assets/images/Male avatars/Avatar=37.png',
          'assets/images/Male avatars/Avatar=5.png',
          'assets/images/Male avatars/Avatar=8.png',
        ];
        final List<String> femaleAvatars = [
          'assets/images/Female avatars/1.png',
          'assets/images/Female avatars/10.png',
          'assets/images/Female avatars/14.png',
          'assets/images/Female avatars/15.png',
          'assets/images/Female avatars/16.png',
          'assets/images/Female avatars/18.png',
          'assets/images/Female avatars/20.png',
          'assets/images/Female avatars/21.png',
          'assets/images/Female avatars/23.png',
          'assets/images/Female avatars/25.png',
          'assets/images/Female avatars/27.png',
          'assets/images/Female avatars/28.png',
          'assets/images/Female avatars/30.png',
          'assets/images/Female avatars/32.png',
          'assets/images/Female avatars/35.png',
          'assets/images/Female avatars/38.png',
          'assets/images/Female avatars/39.png',
          'assets/images/Female avatars/4.png',
          'assets/images/Female avatars/40.png',
          'assets/images/Female avatars/41.png',
          'assets/images/Female avatars/44.png',
          'assets/images/Female avatars/45.png',
          'assets/images/Female avatars/47.png',
          'assets/images/Female avatars/48.png',
          'assets/images/Female avatars/50.png',
          'assets/images/Female avatars/51.png',
          'assets/images/Female avatars/52.png',
          'assets/images/Female avatars/56.png',
          'assets/images/Female avatars/57.png',
          'assets/images/Female avatars/58.png',
          'assets/images/Female avatars/6.png',
          'assets/images/Female avatars/60.png',
          'assets/images/Female avatars/61.png',
          'assets/images/Female avatars/62.png',
          'assets/images/Female avatars/63.png',
          'assets/images/Female avatars/66.png',
          'assets/images/Female avatars/7.png',
          'assets/images/Female avatars/9.png',
        ];
        final List<String> maleAvatars = [
          'assets/images/Male avatars/42.png',
          'assets/images/Male avatars/43.png',
          'assets/images/Male avatars/46.png',
          'assets/images/Male avatars/49.png',
          'assets/images/Male avatars/53.png',
          'assets/images/Male avatars/54.png',
          'assets/images/Male avatars/55.png',
          'assets/images/Male avatars/59.png',
          'assets/images/Male avatars/64.png',
          'assets/images/Male avatars/65.png',
          'assets/images/Male avatars/Avatar=11.png',
          'assets/images/Male avatars/Avatar=12.png',
          'assets/images/Male avatars/Avatar=13.png',
          'assets/images/Male avatars/Avatar=17.png',
          'assets/images/Male avatars/Avatar=19.png',
          'assets/images/Male avatars/Avatar=2.png',
          'assets/images/Male avatars/Avatar=22.png',
          'assets/images/Male avatars/Avatar=24.png',
          'assets/images/Male avatars/Avatar=26.png',
          'assets/images/Male avatars/Avatar=29.png',
          'assets/images/Male avatars/Avatar=3.png',
          'assets/images/Male avatars/Avatar=31.png',
          'assets/images/Male avatars/Avatar=33.png',
          'assets/images/Male avatars/Avatar=34.png',
          'assets/images/Male avatars/Avatar=36.png',
          'assets/images/Male avatars/Avatar=37.png',
          'assets/images/Male avatars/Avatar=5.png',
          'assets/images/Male avatars/Avatar=8.png',
        ];
        final String randomImagePath =
        allAvatars[Random().nextInt(allAvatars.length)];

        // Load the asset into a File
        final ByteData data = await rootBundle.load(randomImagePath);
        final Uint8List bytes = data.buffer.asUint8List();

        // Get the temporary directory
        final Directory tempDir = await getTemporaryDirectory();
        final File tempFile = File('${tempDir.path}/temp_image.png');

        // Write the bytes to the file
        await tempFile.writeAsBytes(bytes);

        // Upload the image to Firebase Storage
        final storageRef = firebaseStorage
            .ref()
            .child('profileImages/${user.uid}.png');
        final uploadTask = await storageRef.putFile(tempFile);
        final profileImageUrl = await uploadTask.ref.getDownloadURL();

        // Store the user information in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'admin': false,
          'profileImage': profileImageUrl,
        });

        return UserModel(
          id: user.uid,
          email: email,
          name: name,
        );
      } else {
        throw const ServerException('Failed to sign up user.');
      }
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
