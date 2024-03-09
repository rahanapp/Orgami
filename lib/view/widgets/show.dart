import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

succesRegistrationMessage(context, String email, toPage) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text("Succesfuly Registered with $email.Now you can login with your email and password",),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => toPage),
                    (route) => false);
              },
              child: Text(
                "Login",
                style: GoogleFonts.poppins(),
              ))
        ],
      );
    },
  );
}

