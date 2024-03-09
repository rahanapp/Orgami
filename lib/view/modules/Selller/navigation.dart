import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/variables.dart';
import 'package:orgami/view/modules/Selller/notification_page.dart';
import 'package:orgami/view/modules/Selller/tab_home.dart';
import 'package:orgami/view/modules/Selller/tab_profile.dart';
import 'package:orgami/viewmodel/firestore.dart';
import 'package:provider/provider.dart';

class NavigationSeller extends StatelessWidget {
  NavigationSeller({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    print("homeee");
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer<FirestoreDb>(builder: (context, firestore, child) {
          List<Widget> body = [
            const SellerHomePage(),
            SellerProfilePage(
              firestore: firestore,
            )
          ];
          print(body.length);
          return FutureBuilder(
            future: firestore.fetchCurrentUser(
                "Seller",
                FirebaseAuth.instance.currentUser!.uid,
                context,
                NavigationSeller(),
                false),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("Home page bilder");
                return const Center(
                  child: CircularProgressIndicator(
                    color: brown,
                  ),
                );
              }
              print("homeeee");
              return TabBarView(children: body);
            },
          );
        }),

        // body: TabBarView(children: body),
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
                builder: (context) => const SellerNotificationPage()));
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
