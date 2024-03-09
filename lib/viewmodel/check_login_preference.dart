import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orgami/utils/variables.dart';
import 'package:orgami/view/modules/Admin/navigation.dart';
import 'package:orgami/view/modules/Buyer/navigation.dart';
import 'package:orgami/view/modules/Selller/navigation.dart';
import 'package:orgami/view/select_type.dart';
import 'package:orgami/viewmodel/firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

checkLoginStatus(context) async {
  bool isLoggedIn = await getLoggedPrefer();
  String collection = await getLoggedCollection();
  if (isLoggedIn == true) {
    //  final firestore= Provider.of<FirestoreDb>(context,listen: false);
    if (collection == "Seller") {
    
      print("----Seller-----");
      firestoreDb.fetchCurrentUser(
          collection, currentUid, context, NavigationSeller(),true);
    } else if (collection == "Buyer") {
      print("----Buyer-----");
      firestoreDb.fetchCurrentUser(
          collection, currentUid, context, NavigationBuyer(),true);
    } else if (collection == "Admin") {
      print("----Admin-----");

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => NavigationAdmin()),
          (route) => false);
    }
  } else {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SelectUserPage()));
  }
}

Future<bool> getLoggedPrefer() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

Future<String> getLoggedCollection() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('USERTYPE') ?? "";
}

void setLoginPrefertrue(collection) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setString("USERTYPE", collection);
  getLoggedPrefer();
}

void setLoginPreferfalse() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);
  await prefs.setString("USERTYPE", "");
  getLoggedPrefer();
}
