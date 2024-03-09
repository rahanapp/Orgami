import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orgami/utils/colors.dart';

TextStyle splashTxt = GoogleFonts.rozhaOne(
  color: Color(0xFF27292E),
  fontSize: 56,
  fontWeight: FontWeight.w400,
  height: 0.03,
);
const labelStyle =
    TextStyle(fontWeight: FontWeight.normal, color: black, fontSize: 16);

TextStyle poppinsStyle(FontWeight fontWeight, double size, color) {
  return GoogleFonts.poppins(
    fontWeight: fontWeight,
    fontSize: size,
    color: color,
  );
}
