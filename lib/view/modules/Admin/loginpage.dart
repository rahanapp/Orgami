import 'package:flutter/material.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';
import 'package:orgami/view/modules/Admin/navigation.dart';

import 'package:orgami/view/widgets/custom_button.dart';
import 'package:orgami/view/widgets/custome_text.dart';
import 'package:orgami/viewmodel/check_login_preference.dart';

class AdminLoginPage extends StatelessWidget {
  AdminLoginPage({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * .3,
          ),
          Center(
            child: customeText(
              text: "ORGAmi",
              size: 44,
              textcolor: black,
            ),
          ),
          SizedBox(
            height: height * .2,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your Email";
                      } else if (!(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                          .hasMatch(value)) {
                        return "Enter correct Email address";
                      } else if (value != "admin@gmail.com") {
                        return "Email is not correct";
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                        labelText: "Enter Email",
                        labelStyle: labelStyle,
                        hintText: "example@gmail.com",
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(),
                        disabledBorder: UnderlineInputBorder(),
                        focusedErrorBorder: UnderlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your password";
                      } else if (value != "123456") {
                        return "password is incorrect";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordController,
                    decoration: const InputDecoration(
                        labelText: "Enter Password",
                        labelStyle: labelStyle,
                        hintText: "********",
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(),
                        disabledBorder: UnderlineInputBorder(),
                        focusedErrorBorder: UnderlineInputBorder()),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  customeButton(
                      onpressed: () {
                        if (_formKey.currentState!.validate()) {
                          setLoginPrefertrue("Admin");
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => NavigationAdmin()),
                              (route) => false);
                        
                        }
                      },
                      context: context,
                      bgColor: const MaterialStatePropertyAll(brown),
                      textcolor: white,
                      text: "Login"),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
