import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orgami/model/seller_model.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';
import 'package:orgami/viewmodel/firestore.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewRequestPageAdmin extends StatelessWidget {
  const NewRequestPageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.keyboard_arrow_left_outlined,
              color: black,
              size: 40,
            )),
        backgroundColor: white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "New Requests",
          style: poppinsStyle(
            FontWeight.w700,
            20,
            black,
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromARGB(166, 190, 198, 206),
        ),
        child: Consumer<FirestoreDb>(builder: (context, firestore, child) {
          return FutureBuilder(
              future: firestore.fetchRegisterdSeller(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                final data = firestore.registerList;
                return data.isEmpty
                    ? const Center(
                        child: Text("No request yet"),
                      )
                    : GridView.builder(
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                            childAspectRatio: height * .0009),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: brown,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width: width,
                                    // height: height * .13,
                                    child: const Icon(
                                      CupertinoIcons.person_alt_circle,
                                      color: white,
                                      size: 70,
                                    ),
                                  ),
                                ),
                                Text(
                                  data[index].name,
                                  style:
                                      poppinsStyle(FontWeight.w600, 18, black),
                                ),
                                Text(
                                  data[index].address,
                                  style:
                                      poppinsStyle(FontWeight.w600, 14, black),
                                ),
                                Text(
                                  data[index].farmName,
                                  style: poppinsStyle(FontWeight.w600, 14,
                                      const Color.fromARGB(142, 82, 81, 81)),
                                ),
                                Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      width: 60,
                                      child: ElevatedButton(
                                        
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  acceptButtonColor(
                                                      data[index].status),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                          onPressed: () {
                                            if (data[index].status ==
                                                "PENDING") {
                                              confirmationMessage(
                                                  context,
                                                  "Are you sure about Activating this account",
                                                  Colors.green,
                                                  data[index].mobileNumber,
                                                  firestore,
                                                  data[index].sellerId,
                                                  data[index].email,
                                                  data[index].password,
                                                  "ACTIVATED",
                                                  "Congrats,your request for registering ORGAmi is Approved. Now you can login with registerd email and password ... ",
                                                  SellerModel(
                                                      address:
                                                          data[index].address,
                                                      password:
                                                          data[index].password,
                                                      email: data[index].email,
                                                      mobileNumber: data[index]
                                                          .mobileNumber,
                                                      name: data[index].name,
                                                      pincode:
                                                          data[index].pincode,
                                                      product:
                                                          data[index].product,
                                                      status: "ACTIVATED",
                                                      farmName: data[index]
                                                          .farmName));
                                            }
                                          },
                                          child: Text(
                                            
                                          
                                            
                                            acceptButtonText(
                                                data[index].status),
                                            style: poppinsStyle(
                                                FontWeight.w600, 14, white),
                                                
                                                                                                maxLines: 1,


                                          ),
                                          
                                          
                                          ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 60,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            if (data[index].status ==
                                                "PENDING") {
                                              confirmationMessage(
                                                  context,
                                                  "If once reject this account,it will permenently reject \nAre you sure about rejecting this account",
                                                  Colors.red,
                                                  data[index].mobileNumber,
                                                  firestore,
                                                  data[index].sellerId,
                                                  data[index].email,
                                                  data[index].password,
                                                  "REJECTED",
                                                  "Sorry,your request for registering ORGAmi is rejected by some reason",
                                                  SellerModel(
                                                    address:
                                                        data[index].address,
                                                    password:
                                                        data[index].password,
                                                    email: data[index].email,
                                                    mobileNumber: data[index]
                                                        .mobileNumber,
                                                    name: data[index].name,
                                                    pincode:
                                                        data[index].pincode,
                                                    product:
                                                        data[index].product,
                                                    status: data[index].status,
                                                    farmName:
                                                        data[index].farmName,
                                                  ));
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  rejectButtonColor(
                                                      data[index].status),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                          child: Text(
                                            rejectButtonText(
                                                data[index].status),
                                            style: poppinsStyle(
                                                FontWeight.w600, 14, white),
                                                maxLines: 1,
                                          )),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          );
                        },
                      );
              });
        }),
      ),
    );
  }

  confirmationMessage(
      context,
      content,
      Color buttonColor,
      conNumber,
      FirestoreDb firestore,
      docId,
      email,
      password,
      status,
      whatsAppMessage,
      SellerModel sellermodel) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Alert"),
              content: Text(content),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: buttonColor),
                    onPressed: () async {
                      await firestore
                          .updateSellerRegister(docId, status, email, password,
                              context, sellermodel,)
                          .then((value) => whatsapp(conNumber, whatsAppMessage))
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                      
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(color: white),
                    ))
              ],
            ));
  }

  acceptButtonColor(status) {
    switch (status) {
      case "PENDING":
        return Colors.amber;
      case "ACTIVATED":
        return Colors.green;
      case "REJECTED":
        return grey;
    }
  }

  acceptButtonText(status) {
    switch (status) {
      case "PENDING":
        return "Accept";
      case "ACTIVATED":
        return "Accepted";
      case "REJECTED":
        return "Accept";
    }
  }

  rejectButtonText(status) {
    switch (status) {
      case "PENDING":
        return "Reject";
      case "ACTIVATED":
        return "Reject";
      case "REJECTED":
        return "Rejected";
    }
  }

  rejectButtonColor(status) {
    switch (status) {
      case "PENDING":
        return Colors.red;
      case "ACTIVATED":
        return grey;
      case "REJECTED":
        return grey;
    }
  }

  whatsapp(contactNumber, message) async {
    var contact = "+91$contactNumber";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi,$message";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } catch (e) {
      print(e);
    }
  }
}
