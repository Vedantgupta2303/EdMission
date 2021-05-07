import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants.dart';

class Auth {
  FirebaseAuth firebaseAuth;
  Auth({required this.firebaseAuth});

  Future<bool> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      kShowSnackBar(context, "Signed In", true);
      return true;
    } on FirebaseAuthException catch (e) {
      kShowSnackBar(context, e.message.toString(), false);
      return false;
    }
  }

  Future<bool> signInGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          kShowSnackBar(context,
              'The account already exists with a different credential', false);
        } else if (e.code == 'invalid-credential') {
          kShowSnackBar(context,
              'Error occurred while accessing credentials. Try again.', false);
        }
        return false;
      } catch (e) {
        kShowSnackBar(
            context, 'An error occurred while signing in with Google.', false);
        return false;
      }
    } else {
      kShowSnackBar(context,
          'Institute google account not linked or login-error!', false);
    }
    return false;
  }

  Future<bool> register(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var result =
          await signIn(email: email, password: password, context: context);
      if (result) {
        kShowSnackBar(context, "Successfully registered", true);
        return true;
      } else
        throw FirebaseAuthException;
    } on FirebaseAuthException catch (e) {
      kShowSnackBar(context, e.message.toString(), false);
      return false;
    }
  }

  Future<bool> signOut({required BuildContext context}) async {
    try {
      await firebaseAuth.signOut();
      kShowSnackBar(context, "Successfully signed out", true);
      return true;
    } on FirebaseAuthException catch (e) {
      kShowSnackBar(context, e.message.toString(), false);
      return false;
    }
  }
}
