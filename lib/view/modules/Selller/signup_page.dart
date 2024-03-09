import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orgami/model/seller_model.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';
import 'package:orgami/utils/variables.dart';
import 'package:orgami/view/splash_screeen.dart';
import 'package:orgami/view/widgets/custom_button.dart';
import 'package:orgami/view/widgets/custome_text.dart';
import 'package:orgami/viewmodel/controller.dart';
import 'package:provider/provider.dart';

class SellerSignPage extends StatelessWidget {
  SellerSignPage({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var conformpasswordController = TextEditingController();

  var fullNameController = TextEditingController();
  var pinController = TextEditingController();
  var addressController = TextEditingController();
  var farmController = TextEditingController();
  var phonenumberController = TextEditingController();

  List<String> selectedProduct = [];
  final _fromkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print(selectedProduct.length);
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
                    if (value!.isEmpty) {
                      return "Enter your Name";
                    }else if(!(RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")).hasMatch(value))
                    {
 return "Enter Valid Name";
                    }
                     else {
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
                  keyboardType: TextInputType.emailAddress,
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
                  keyboardType: TextInputType.number,
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
                 keyboardType: TextInputType.number,
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
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your Farm Name";
                    } else {
                      return null;
                    }
                  },
                  controller: farmController,
                  decoration: const InputDecoration(
                      labelText: "Farm Name",
                      labelStyle: labelStyle,
                      // hintText: "example@gmail.com",
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
                    obscureText: controller.isSecure,
                    controller: passwordController,
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

                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: width * .27,
                    height: 35,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 137, 135, 135),
                        borderRadius: BorderRadius.circular(5)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: customeText(
                          size: 18,
                          text: "Products",
                          fontweight: FontWeight.bold),
                    ),
                  ),
                ),

                Consumer<Controller>(builder: (context, controller, child) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              checkColor: white,
                              activeColor: black,
                              value: controller.ischeckbox1Enabled,
                              onChanged: (value) {
                                controller.ischeckboxClicked(value, 0);
                                if (value == true) {
                                  selectedProduct.add("Milk");
                                } else {
                                  selectedProduct.remove("Milk");
                                }
                              }),
                          Text(
                            "Milk",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              checkColor: white,
                              activeColor: black,
                              value: controller.ischeckbox2Enabled,
                              onChanged: (value) {
                                controller.ischeckboxClicked(value, 1);
                                if (value == true) {
                                  selectedProduct.add("Curd");
                                } else {
                                  selectedProduct.remove("Curd");
                                }
                              }),
                          Text(
                            "Curd",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              checkColor: white,
                              activeColor: black,
                              value: controller.ischeckbox3Enabled,
                              onChanged: (value) {
                                controller.ischeckboxClicked(value, 2);
                                if (value == true) {
                                  selectedProduct.add("Butter");
                                } else {
                                  selectedProduct.remove("Butter");
                                }
                              }),
                          Text(
                            "Butter",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              checkColor: white,
                              activeColor: black,
                              value: controller.ischeckbox4Enabled,
                              onChanged: (value) {
                                controller.ischeckboxClicked(value, 3);
                                if (value == true) {
                                  selectedProduct.add("Butter MIlk");
                                } else {
                                  selectedProduct.remove("Butter Milk");
                                }
                              }),
                          Text(
                            "Butter milk",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
                SizedBox(
                  height: height * .02,
                ),

                Consumer<Controller>(builder: (context, controller, child) {
                  return Row(
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
                  //     Text(
                  //       "I agree to all the",
                  //       style: GoogleFonts.poppins(),
                  //     ),
                  //     TextButton(
                  //       onPressed: () {},
                  //       child: Text(
                  //         "Terms and Conditions",
                  //         style: GoogleFonts.poppins(
                  //             color: Colors.amber,
                  //             fontWeight: FontWeight.w500),
                  //       ),
                  //     ),
                  //     Text(
                  //       "and",
                  //       style: GoogleFonts.poppins(),
                  //     ),
                    ],
                  );
                }),
                // CheckboxListTile(value: value, onChanged: onChanged),
                Consumer<Controller>(builder: (context, controller, child) {
                  return customeButton(
                      onpressed: () {
                        if (_fromkey.currentState!.validate()) {
                          if (controller.termsAndCondition == true) {
                            if (controller.ischeckbox1Enabled == true ||
                                controller.ischeckbox2Enabled == true ||
                                controller.ischeckbox3Enabled == true ||
                                controller.ischeckbox4Enabled == true) {
                              firestoreDb
                                  .registerSeller(SellerModel(
                                    password: passwordController.text,
                                      status: "PENDING",
                                      address: addressController.text,
                                      email: emailController.text,
                                      mobileNumber: phonenumberController.text,
                                      name: fullNameController.text,
                                      pincode: pinController.text,
                                      product: selectedProduct,
                                      farmName: farmController.text))
                                  .then((value) => showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: const Text(
                                                "Your details is send to verification.After that  our team will contact you"),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const SplashScreen()),
                                                            (route) => false);
                                                  },
                                                  child: const Text("Ok"))
                                            ],
                                          )));
                              // firestoreDb.signinUser(
                              //     emailController.text,
                              //     passwordController.text,
                              //     context,
                              //     "Seller",
                              //     SellerLoginPage(),
                              //     SellerModel(
                              //       status: "PENDING",
                              //         address: addressController.text,
                              //         email: emailController.text,
                              //         mobileNumber: phonenumberController.text,
                              //         name: fullNameController.text,
                              //         pincode: pinController.text,
                              //         product: selectedProduct,
                              //         farmName: farmController.text));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Select minimum 1 product")));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "agree the Terms and Condition and proceed")));
                          }
                        }
                      },
                      context: context,
                      bgColor: const MaterialStatePropertyAll(brown),
                      textcolor: white,
                      text: "Register Farm");
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
