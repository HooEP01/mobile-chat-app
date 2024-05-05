import 'dart:io';

import 'package:nylo_framework/nylo_framework.dart';

import '/app/controllers/controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends Controller {
  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential? userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential is UserCredential) {
        await login(userCredential.user);
        return userCredential;
      }
    } on Exception catch (e) {
      print('exception->$e');
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      await logout();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  login(user) async {
    await Auth.set(user);
  }

  logout() async {
    await Auth.remove();
  }
}
