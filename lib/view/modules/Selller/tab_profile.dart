import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';
import 'package:orgami/view/modules/Selller/aboutus_page.dart';
import 'package:orgami/view/modules/Selller/dailyupdate_page.dart';
import 'package:orgami/view/widgets/custom_button.dart';
import 'package:orgami/viewmodel/firebase_auths.dart';
import 'package:orgami/viewmodel/firestore.dart';

class SellerProfilePage extends StatelessWidget {
  FirestoreDb firestore;
  SellerProfilePage({super.key, required this.firestore});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "My Store",
          style: poppinsStyle(FontWeight.w700, 20, black),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30, right: 30, top: 80),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.4),
                    // blurStyle: BlurStyle.outer,
                    blurRadius: 5,
                    spreadRadius: .05,
                    offset: const Offset(2, 3)),
              ],
              color: const Color.fromARGB(255, 245, 231, 230),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  CupertinoIcons.profile_circled,
                  size: 90,
                ),

                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    firestore.sellerModel!.farmName.toUpperCase(),
                    style: poppinsStyle(FontWeight.w600, 16, black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Name : ${firestore.sellerModel!.name}',
                    style: poppinsStyle(FontWeight.w400, 14, darkgrey),
                  ),
                  Text(
                    "Address :${firestore.sellerModel!.address}",
                    style: poppinsStyle(FontWeight.w400, 14, darkgrey),
                  ),
                  Text(
                    "Pincode :${firestore.sellerModel!.pincode}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: poppinsStyle(FontWeight.w400, 14, darkgrey),
                  ),
                  // Text(
                  //   "gst number",
                  //   style: poppinsStyle(FontWeight.w400, 14, darkgrey),
                  // ),
                  const SizedBox(
                    height: 60,
                  )
                ]),

                const SizedBox(
                  width: 10,
                )
                // title: text,
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80, left: 40, right: 40),
          child: Column(
            children: [
              ListTile(
                onTap: (){
                   Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DailyUpdatePage()));
                },
                // minLeadingWidth: MediaQuery.of(context).size.width*.03,
                leading: const Icon(
                  Icons.update,
                  color: black,
                  size: 40,
                ),
                title: Text(
                  "Daily Update",
                  maxLines: 1,overflow: TextOverflow.ellipsis,
                  style: poppinsStyle(FontWeight.w700, 20, black),
                ),
              ),
              const Divider(
                color: black,
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SellerAboutUsPage()));
                },
                child: ListTile(
                  leading: const Icon(
                    Icons.menu_book,
                    color: black,
                    size: 40,
                  ),
                  title: Text(
                    "About us",
                    style: poppinsStyle(FontWeight.w700, 20, black),
                  ),
                ),
              ),
              const Divider(
                color: black,
              ),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
        customeButton(
          onpressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Log out"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "No",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseAuths().signOutFromMAil(context);
                        },
                        child: const Text(
                          "Yes",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  );
                });
          },
          context: context,
          textcolor: white,
          text: "Log out",
          bgColor: const MaterialStatePropertyAll(brown),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
