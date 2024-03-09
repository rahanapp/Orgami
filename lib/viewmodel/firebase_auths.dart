import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:orgami/view/splash_screeen.dart';
import 'package:orgami/viewmodel/check_login_preference.dart';

class FirebaseAuths {
  FirebaseAuth auth = FirebaseAuth.instance;
    dynamic newUID;

  Future<String> sign(
    email,
    password,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      newUID = userCredential.user!.uid;
      await emailVarification(context);
      print("*********************$newUID**********************");
      return userCredential.user!.uid;
    } catch (e) {
      return customeShowDiolog("$e", context);
    }
  }

  emailVarification(
    context,
  ) async {
    try {
      if (FirebaseAuth.instance.currentUser != null &&
          !FirebaseAuth.instance.currentUser!.emailVerified) {
        await FirebaseAuth.instance.currentUser!.sendEmailVerification().then(
            (value) => customeShowDiolog(
                "Varification email Send to your registered email address ${FirebaseAuth.instance.currentUser!.email} ",
                context));
      }
    } catch (e) {
      customeShowDiolog("$e", context);
    }
  }

  Future<String> login(
    email,
    password,
    context,
  ) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user!.uid;
    } catch (e) {
      return customeShowDiolog("$e", context);
    }
  }

  signOutFromMAil(context) async {
    setLoginPreferfalse();
    newUID = null;
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SplashScreen()),
        (route) => false);
  }

  customeShowDiolog(String title, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: Text(
          title,
          style: GoogleFonts.poppins(),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"))
        ],
      ),
    );
  }
}
