import 'package:google_sign_in/google_sign_in.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '/app/controllers/controller.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends Controller {
  @override
  construct(BuildContext context) {
    super.construct(context);
  }

  Future<dynamic> signInWithGoogle() async {
    try {

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print("This is the user crendential");


      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      print("This is the user authentication");


      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print("This is the user google auth provider");


      final UserCredential? userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      print(userCredential);
      if (userCredential is UserCredential) {
        await login(userCredential.user);
        return true;
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
