import 'package:flutter/material.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';
import 'package:orgami/view/modules/Buyer/aboutus_page.dart';
import 'package:orgami/view/widgets/custom_button.dart';
import 'package:orgami/viewmodel/firebase_auths.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height / 3,
          ),
          Text(
            "Admin",
            style: poppinsStyle(FontWeight.w700, 22, black),
          ),
          Text(
            "admin@gmail.com",
            style: poppinsStyle(FontWeight.w700, 16, black),
          ),
          SizedBox(
            height: height * .09,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BuyerAboutUsPage()));
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
