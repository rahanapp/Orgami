import 'package:flutter/material.dart';

Widget customeTextField(
    {controller,
    String? labelText,
    String? hintText,
    Widget? icon,
    obsecure,
    String? Function(String?)? validator,
    void Function(String)? onSubmitted}) {
  return TextFormField(
    validator: validator,
    onFieldSubmitted: onSubmitted,
    obscureText: obsecure ??false,
    controller: controller,
    decoration: InputDecoration(
      hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      fillColor: const Color.fromARGB(255, 232, 244, 255),
      filled: true,
      hintText: hintText,
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: .2, ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: .2, ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: .2, ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      labelText: labelText,
      labelStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
      suffixIcon: icon,
    ),
  );
}
