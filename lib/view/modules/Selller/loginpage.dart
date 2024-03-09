import 'package:flutter/material.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';
import 'package:orgami/utils/variables.dart';
import 'package:orgami/view/modules/Selller/navigation.dart';
import 'package:orgami/view/modules/Selller/signup_page.dart';
import 'package:orgami/view/widgets/custom_button.dart';
import 'package:orgami/view/widgets/custome_text.dart';

class SellerLoginPage extends StatelessWidget {
  SellerLoginPage({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                      } else if (value.length < 8) {
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
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forget Password ?",
                          style: TextStyle(color: black),
                        )),
                  ),
                  customeButton(
                      onpressed: () {
                        if (_formKey.currentState!.validate()) {
                          firestoreDb.loginUser(
                              emailController.text,
                              passwordController.text,
                              context,
                              NavigationSeller(),
                              "Seller");
                        }
                      },
                      context: context,
                      bgColor: const MaterialStatePropertyAll(brown),
                      textcolor: white,
                      text: "Login"),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "I don't have an account,",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SellerSignPage()));
                        },
                        child: const Text(
                          "Sign-up",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.amber,
                            color: Colors.amber,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
