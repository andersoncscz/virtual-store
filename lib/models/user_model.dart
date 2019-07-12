import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends Model {

  bool isLoading = false;

  Map<String, dynamic> user = Map();
  FirebaseUser _firebaseUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static UserModel of(BuildContext context) => ScopedModel.of<UserModel>(context);

  Future<void> signInWithCredentials({ @required Map<String, dynamic> user, @required String password, @required VoidCallback onSucess, @required VoidCallback onFail}) async {
    try {
      onLoading();
      _firebaseUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: user['email'],
        password: password,
      );
      _getUser();
      _handleCallback(onSucess, shouldNotifyListeners: false);
    } catch (e) {
      _handleCallback(onFail);
    }
  }

  Future<void> signUp({ @required Map<String, dynamic> user, @required String password, @required VoidCallback onSucess, @required VoidCallback onFail}) async {
    try {
      onLoading();
      _firebaseUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user['email'],
        password: password,
      );
      await save(user: user);
      _handleCallback(onSucess, shouldNotifyListeners: false);
    } catch (e) {
      _handleCallback(onFail);
    }

  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _resetFields();
  }

  bool isSignedIn() => _firebaseUser != null;

  FirebaseUser getSignedInUser() {
    return _firebaseUser;
  }

  Future<void> save({ @required Map<String, dynamic> user}) async {
    await Firestore
            .instance
            .collection('users')
            .document(_firebaseUser.uid)
            .setData(user);
    await _getUser();
  }

  Future<void> update({ @required Map<String, dynamic> user}) async {
    await Firestore
            .instance
            .collection('users')
            .document(_firebaseUser.uid)
            .updateData(user);
    await _getUser();
  }  

  Future<void> _getUser() async {
    if (_firebaseUser == null) {
      _firebaseUser = await _firebaseAuth.currentUser();
    }
    else {
      DocumentSnapshot docUser = await Firestore.instance.collection('users').document(_firebaseUser.uid).get();
      user = docUser.data;
    }
  }

  Future<void> uploadProfilePicture(File imageFile) async {
    
    if (imageFile != null) {
      StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child(_firebaseUser.uid + DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(imageFile);
      
      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      
      String profilePictureUrl = await taskSnapshot.ref.getDownloadURL();
      user['profile_picture'] = profilePictureUrl;
      
      update(user: user);
    }
  }

  void recoverPassword(String email) {
    _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  void _handleCallback(VoidCallback callback, {bool shouldNotifyListeners : true}) async {
    callback();
    isLoading = false;
    if (shouldNotifyListeners) {
      notifyListeners();   
    }
  }

  void _resetFields() {
    user = Map();
    _firebaseUser = null;
    notifyListeners();
  }

  void onLoading() {
    isLoading = true;
    notifyListeners();
  }

  void onLoadFinished() {
    isLoading = false;
    notifyListeners();
  }

}