import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  FirebaseAuth firebaseAuth;
  Auth({required this.firebaseAuth});

  void showSnackBar(BuildContext context, String content, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.green : Colors.redAccent,
      content: Text(
        content,
        style: TextStyle(color: Colors.white, letterSpacing: 0.5),
      ),
    ));
  }

  // Stream<CustomUser?> get authStateChanges {
  //   return firebaseAuth
  //       .authStateChanges()
  //       .map((User? user) => (user != null) ? CustomUser(uid: user.uid) : null);
  // }

  Future<bool> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      showSnackBar(context, "Signed In", true);
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString(), false);
      return false;
    }
  }

  Future<bool> signInGoogle(BuildContext context) async {
    // final GoogleSignIn googleSignIn =
    //     GoogleSignIn(, scopes: [
    //   'email',
    // ]);
    // googleSignIn.disconnect();
    final GoogleSignIn _googleSignIn =
        GoogleSignIn(hostedDomain: "iiitkalyani.ac.in");
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
          showSnackBar(context,
              'The account already exists with a different credential', false);
        } else if (e.code == 'invalid-credential') {
          showSnackBar(context,
              'Error occurred while accessing credentials. Try again.', false);
        }
        return false;
      } catch (e) {
        showSnackBar(
            context, 'An error occurred while signing in with Google.', false);
        return false;
      }
    } else {
      showSnackBar(context,
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
        showSnackBar(context, "Successfully registered", true);
        return true;
      } else
        throw FirebaseAuthException;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString(), false);
      return false;
    }
  }

  Future<bool> signOut({required BuildContext context}) async {
    try {
      await firebaseAuth.signOut();
      showSnackBar(context, "Successfully signed out", true);
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString(), false);
      return false;
    }
  }
}
