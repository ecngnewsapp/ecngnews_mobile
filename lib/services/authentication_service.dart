import 'dart:io';

import 'package:ecngnews/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class AuthenticationService {
  AuthenticationService() {
    checkSignIn();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();
  // final FacebookLogin fbLogin = new FacebookLogin();
  String randomUserImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/ecngnewsapp-346cd.appspot.com/o/defaul_avatar.png?alt=media&token=d39fd4fb-8905-4441-b8f7-f4605c7aaab5';

  String timestamp;
  Future signInAnonymously() async {
    try {
      final FirebaseUser user = (await _firebaseAuth.signInAnonymously()).user;
      assert(user != null);
      assert(user.isAnonymous);
      assert(!user.isEmailVerified);
      assert(await user.getIdToken() != null);
      if (Platform.isIOS) {
        // Anonymous auth doesn't show up as a provider on iOS
        assert(user.providerData.isEmpty);
      } else if (Platform.isAndroid) {
        // Anonymous auth does show up as a provider on Android
        assert(user.providerData.length == 1);
        assert(user.providerData[0].providerId == 'firebase');
        assert(user.providerData[0].uid != null);
        assert(user.providerData[0].displayName == null);
        assert(user.providerData[0].photoUrl == null);
        assert(user.providerData[0].email == null);
      }

      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
      assert(user.uid == currentUser.uid);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      await preferences.setBool('isAnonymous', user.isAnonymous);

      return currentUser;
    } catch (e) {
      return e.message;
    }
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googlSignIn
        .signIn()
        .catchError((error) => print('error : $error'));
    if (googleUser != null) {
      try {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        SharedPreferences preferences = await SharedPreferences.getInstance();
        FirebaseUser userDetails =
            (await _firebaseAuth.signInWithCredential(credential)).user;

        preferences.setBool('isAnonymous', userDetails.isAnonymous);
        // throw new Error();
        return userDetails;
      } catch (e) {
        return e.toString();
      }
    } else {}
  }

  Future<FirebaseUser> signUpwithEmailPassword(
      {userName, userEmail, userPassword}) async {
    try {
      final FirebaseUser user =
          (await _firebaseAuth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      ))
              .user;
      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
      print(currentUser.toString());
      return currentUser;
    } catch (e) {
      return e;
    }
  }

  Future signInwithEmailPassword(userEmail, userPassword) async {
    try {
      final FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: userEmail, password: userPassword))
          .user;
      assert(user != null);
      assert(await user.getIdToken() != null);
      final FirebaseUser currentUser = await _firebaseAuth.currentUser();

      return currentUser;
    } catch (e) {
      return e;
    }
  }

  Future checkUserExists() async {
    await Firestore.instance
        .collection('users')
        .getDocuments()
        .then((QuerySnapshot snap) {
      List values = snap.documents;
      List uids = [];
      values.forEach((element) {
        uids.add(element['uid']);
      });
    });
  }

  Future saveToFirebase(User user) async {
    await getTimestamp();
    final DocumentReference ref =
        Firestore.instance.collection('users').document(user.id);
    await ref.setData({
      'name': user.name,
      'email': user.email,
      'uid': user.id,
      'image url': user.avatar,
      'timestamp': timestamp,
      'loved items': [],
      'bookmarked items': []
    });
  }

  Future getTimestamp() async {
    DateTime now = DateTime.now();
    String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
    timestamp = _timestamp;
  }

  Future saveDataToSP(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString('name', user.name);
    await sharedPreferences.setString('email', user.email);
    await sharedPreferences.setString('avatar', user.avatar);
    await sharedPreferences.setString('uid', user.id);
  }

  Future getUserDataFromSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    User user = User(
        name: await sharedPreferences.get('name'),
        email: await sharedPreferences.get('email'),
        avatar: await sharedPreferences.get('avatar'),
        id: sharedPreferences.get('uid'));
    return user;
  }

  Future getUserData(uid) async {
    User user;
    await Firestore.instance
        .collection('users')
        .document(uid)
        .get()
        .then((DocumentSnapshot snap) {
      user = User(
        id: snap.data['uid'],
        name: snap.data['name'],
        email: snap.data['email'],
        avatar: snap.data['image url'],
        lovedItems: snap.data['loved items'],
        bookmarkedItems: snap.data['bookmarked items'],
      );
    });
    return user;
  }

  Future setSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('signed in', true);
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
    final sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  Future checkSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final isSignedIn = sp.getBool('signed in') ?? false;

    return isSignedIn;
  }

  Future checkUserAnonymous() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      var isAnonymous = await sp.get('isAnonymous');
      print('value $isAnonymous');
      if (isAnonymous) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e;
    }
  }
}
