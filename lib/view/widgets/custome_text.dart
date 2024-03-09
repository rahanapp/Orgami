import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customeText(
    {String? text, Color? textcolor, double? size, FontWeight? fontweight}) {
  return Text(
    "$text",
    style: GoogleFonts.poppins(
      color: textcolor,
      fontWeight: fontweight,
      fontSize: size,
    ),
  );
}
