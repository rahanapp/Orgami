import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orgami/model/buyer_model.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';
import 'package:orgami/utils/variables.dart';
import 'package:orgami/view/modules/Buyer/loginpage.dart';
import 'package:orgami/view/widgets/custom_button.dart';
import 'package:orgami/view/widgets/custome_text.dart';
import 'package:orgami/view/widgets/show.dart';
import 'package:orgami/viewmodel/controller.dart';
import 'package:orgami/viewmodel/firestore.dart';
import 'package:provider/provider.dart';

class BuyerSignPage extends StatefulWidget {
  BuyerSignPage({super.key});

  @override
  State<BuyerSignPage> createState() => _BuyerSignPageState();
}

class _BuyerSignPageState extends State<BuyerSignPage> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var conformpasswordController = TextEditingController();

  var fullNameController = TextEditingController();

  var pinController = TextEditingController();

  var addressController = TextEditingController();

  var phonenumberController = TextEditingController();

  final _fromkey = GlobalKey<FormState>();
  BuyerModel? buyerModel;
  String? uID;
  final db = FirebaseFirestore.instance;
  bool isVerified = false;

  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    print("h");
    // if (isVerified) {
    print("hi");
    timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(context, BuyerLoginPage(),
            emailController.text, "Buyer", buyerModel, uID));
    // }

    super.initState();
  }

  checkEmailVerified(context, toPage, email, collection, model, uID) async {
    print("hii");
    await FirebaseAuth.instance.currentUser?.reload();
    if (isVerified == true) {
      print("hii");
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      if (isEmailVerified) {
        if (collection == "Buyer") {
          BuyerModel buyerModel = model;
          await db
              .collection(collection)
              .doc(uID)
              .set(buyerModel.tojson(uID))
              .then(
                  (value) => succesRegistrationMessage(context, email, toPage));
        }

        timer?.cancel();
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<FirestoreDb>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Form(
            key: _fromkey,
            child: Column(
              children: [
                SizedBox(
                  height: height * .1,
                ),
                customeText(text: "Register", size: 40),
                SizedBox(
                  height: height * .02,
                ),
                TextFormField(
                  validator: (value) {
                     if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                } else {
                      return null;
                    }
                  },
                  controller: fullNameController,
            
                  decoration: const InputDecoration(
                      prefix: Icon(CupertinoIcons.person_fill),
                      labelText: "Full Name",
                      labelStyle: labelStyle,
                      // hintText: "example",
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
                      return "Enter your pincode";
                    } else {
                      return null;
                    }
                  },
                  controller: pinController,
                  decoration: const InputDecoration(
                      labelText: "Pincode",
                      labelStyle: labelStyle,
                      hintText: "********",
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
                      return "Enter your address";
                    } else {
                      return null;
                    }
                  },
                  controller: addressController,
                  decoration: const InputDecoration(
                      labelText: "Address",
                      labelStyle: labelStyle,
                      hintText: "",
                      enabledBorder: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                      disabledBorder: UnderlineInputBorder(),
                      focusedErrorBorder: UnderlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your Mobile number";
                    } else if (!(RegExp(r'^\d{10}$').hasMatch(value))) {
                      return "The number is not valid";
                    } else {
                      return null;
                    }
                  },
                  controller: phonenumberController,
                  decoration: const InputDecoration(
                      prefixText: "+91 ",
                      labelText: "Mobile Number",
                      labelStyle: labelStyle,
                      hintText: "0123456789",
                      enabledBorder: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                      disabledBorder: UnderlineInputBorder(),
                      focusedErrorBorder: UnderlineInputBorder()),
                ),

                const SizedBox(
                  height: 20,
                ),
                // Divider(),
                const SizedBox(
                  height: 20,
                ),
                Consumer<Controller>(builder: (context, controller, child) {
                  return TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your password";
                      } else if (value.length < 8) {
                        return "password must contain 8 digit";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordController,
                    obscureText: controller.isSecure,
                    decoration: InputDecoration(
                        suffix: IconButton(
                            onPressed: () {
                              controller.isSecuree();
                            },
                            icon: controller.isSecure
                                ? const Icon(CupertinoIcons.eye_slash_fill)
                                : const Icon(Icons.remove_red_eye_rounded)),
                        labelText: "Enter Password",
                        labelStyle: labelStyle,
                        hintText: "********",
                        enabledBorder: const UnderlineInputBorder(),
                        focusedBorder: const UnderlineInputBorder(),
                        disabledBorder: const UnderlineInputBorder(),
                        focusedErrorBorder: const UnderlineInputBorder()),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                Consumer<Controller>(builder: (context, controller, child) {
                  return TextFormField(
                    obscureText: controller.isSecure,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Confirm your password";
                      } else if (value != passwordController.text) {
                        return "Password is does't match";
                      } else {
                        return null;
                      }
                    },
                    controller: conformpasswordController,
                    decoration: InputDecoration(
                        suffix: IconButton(
                            onPressed: () {
                              controller.isSecuree();
                            },
                            icon: controller.isSecure
                                ? const Icon(CupertinoIcons.eye_slash_fill)
                                : const Icon(Icons.remove_red_eye_rounded)),
                        labelText: "Conform Password",
                        labelStyle: labelStyle,
                        hintText: "********",
                        enabledBorder: const UnderlineInputBorder(),
                        focusedBorder: const UnderlineInputBorder(),
                        disabledBorder: const UnderlineInputBorder(),
                        focusedErrorBorder: const UnderlineInputBorder()),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),

                Consumer<Controller>(builder: (context, controller, child) {
                  return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          checkColor: white,
                          activeColor: Colors.green,
                          value: controller.termsAndCondition,
                          onChanged: (value) {
                            controller.ischeckboxClicked(value, 4);
                          }),

                          SizedBox(
                         
                          width: width*.7,
                          height: height*.07,
                            child: RichText(text: TextSpan(
                            style:GoogleFonts.poppins(color: black) ,
                            children: [
                            TextSpan(
                              text:  "I agree to all the ",
                        style: GoogleFonts.poppins(),
                            ),
                            TextSpan(text:  "Terms and Conditions ",
                            
                          style: GoogleFonts.poppins(
                            
                              color: Colors.amber,
                              fontWeight: FontWeight.w500),),
                              TextSpan(text:  "and ",
                        style: GoogleFonts.poppins(),),
                        TextSpan(text:  "Privacy policy ",
                      // maxLines: 2,
                      style: GoogleFonts.poppins(
                          color: Colors.amber, fontWeight: FontWeight.w500),)

                          ]))),
                      
                    ],
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                // CheckboxListTile(value: value, onChanged: onChanged),
                Consumer<Controller>(builder: (context, controller, child) {
                  return customeButton(
                      onpressed: () {
                        if (_fromkey.currentState!.validate()) {
                          if (controller.termsAndCondition == true) {
                            auth
                                .sign(emailController.text,
                                    passwordController.text, context)
                                .then((value) {
                              uID = value;
                              buyerModel = BuyerModel(
                                  address: addressController.text,
                                  email: emailController.text,
                                  mobileNumber: phonenumberController.text,
                                  name: fullNameController.text,
                                  pincode: pinController.text);

                              isVerified = true;
                              setState(() {});
                              print(isVerified);
                            });

                            //  firestoreDb.signinUser(
                            //     emailController.text,
                            //     passwordController.text,
                            //     context,
                            //     "Buyer",
                            //     BuyerLoginPage(),
                            //     BuyerModel(
                            //         address: addressController.text,
                            //         email: emailController.text,
                            //         mobileNumber: phonenumberController.text,
                            //         name: fullNameController.text,
                            //         pincode: pinController.text));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "agree the Terms and Condition and proceed")));
                          }
                        }
                      },
                      context: context,
                      bgColor: const MaterialStatePropertyAll(black),
                      textcolor: white,
                      text: "Sign up");
                }),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
