import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';
import 'package:orgami/view/modules/Buyer/aboutus_page.dart';
import 'package:orgami/view/modules/Selller/aboutus_page.dart';
import 'package:orgami/view/modules/Selller/dailyupdate_page.dart';
import 'package:orgami/view/modules/Selller/notification_page.dart';
import 'package:orgami/view/widgets/custom_button.dart';
import 'package:orgami/viewmodel/firebase_auths.dart';
import 'package:orgami/viewmodel/firestore.dart';
import 'package:provider/provider.dart';

class BuyerProfilePage extends StatelessWidget {
  const BuyerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore =
        Provider.of<FirestoreDb>(context, listen: false).buyerModel;
    print("object");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height / 3,
          ),
          Text(
            firestore!.email,
            style: poppinsStyle(FontWeight.w700, 22, black),
          ),
          SizedBox(
            height: height * .09,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BuyerAboutUsPage()));
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
      ),
    );
  }
}
