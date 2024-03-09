import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/view/modules/Buyer/notification_page.dart';
import 'package:orgami/view/modules/Buyer/tab_home.dart';
import 'package:orgami/view/modules/Buyer/tab_profile.dart';
import 'package:orgami/viewmodel/firestore.dart';
import 'package:provider/provider.dart';

class NavigationBuyer extends StatelessWidget {
  NavigationBuyer({super.key});
  List<Widget> body = [const BuyerHomePage(), const BuyerProfilePage()];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Consumer<FirestoreDb>(builder: (context, firestore, child) {
          return Builder(builder: (context) {
            return FutureBuilder(
              future: firestore.fetchCurrentUser(
                  "Buyer",
                  FirebaseAuth.instance.currentUser!.uid,
                  context,
                  NavigationBuyer(),
                  false),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: brown,
                    ),
                  );
                }
                return TabBarView(children: body);
              },
            );
          });
        }),
        backgroundColor: white,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(
              color: brown,
              borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(3000, 250),
                  topLeft: Radius.elliptical(3000, 300))),
          width: width,
          height: height * .1,
          child: TabBar(onTap: (value) {}, tabs: [
            SizedBox(
                width: width / 2,
                child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.home_filled,
                      size: 40,
                    ))),
            SizedBox(
                width: width / 2,
                child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      CupertinoIcons.person_solid,
                      size: 40,
                    )))
          ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: white,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const BuyerNotificationPage()));
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 50,
              width: 50,
              decoration:
                  const BoxDecoration(color: brown, shape: BoxShape.circle),
              child: const Icon(
                CupertinoIcons.bell_fill,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
