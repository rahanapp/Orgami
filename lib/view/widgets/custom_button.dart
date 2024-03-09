import 'package:flutter/material.dart';
import 'package:orgami/view/widgets/custome_text.dart';

Widget customeButton(
    {String? text,
    required BuildContext context,
    image,
    num buttonwidth = .84,
    num buttonHight = .06,
    void Function()? onpressed,
    MaterialStateProperty<Color?>? bgColor,
    textcolor}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * buttonwidth,
    height: MediaQuery.of(context).size.height * buttonHight,
    child: ElevatedButton(
      onPressed: onpressed,
      style: ButtonStyle(
        backgroundColor: bgColor,
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image ?? const SizedBox(),
          customeText(
                  text: text,
                  textcolor: textcolor,
                  size: 20,
                  fontweight: FontWeight.w600) ??
              SizedBox()
        ],
      ),
    ),
  );
}
