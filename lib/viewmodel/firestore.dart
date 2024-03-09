

import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orgami/model/buyer_model.dart';
import 'package:orgami/model/new_order_model.dart';
import 'package:orgami/model/product_model.dart';
import 'package:orgami/model/seller_model.dart';
import 'package:orgami/utils/variables.dart';

import 'package:orgami/viewmodel/check_login_preference.dart';
import 'package:orgami/viewmodel/firebase_auths.dart';

class FirestoreDb with ChangeNotifier {
  FirebaseAuths firebaseAuth = FirebaseAuths();
  final db = FirebaseFirestore.instance;



  
//---------------------------create---------------------------------
 


   Future _signSeller(email, password, context, SellerModel sellerModel,sellerTempDocId) async {
    await firebaseAuth.sign(email, password, context).then((uID) async {
      await db.collection("Seller").doc(uID).set(sellerModel.tojson(uID));
      final collectionRef =
          db.collection("Seller").doc(uID).collection("Products");
      sellerModel.product.forEach((element) {
        print(element);
        print("===>>>>>>>=====");
        ProductModel productModel =
            ProductModel(id: element, quantity: "0", rate: "0");
        collectionRef.doc(element).set(productModel.toJson());
      });
      return uID;
    }).then((value){
print(value);
print(sellerTempDocId);
         db
        .collection("Seller")
        .doc(value)
        .update({"status": "ACTIVATED"}).then((value){
            deleteADocument('Seller', sellerTempDocId);
        });
    });
  }

  registerSeller(SellerModel sellerModel) async {
    final doc = db.collection("Seller").doc();
    await doc.set(sellerModel.tojson(doc.id));
  }

  buyANewProduct(NewOrderModel newOrderModel) async {
    final doc = db.collection("new request").doc();
    await doc.set(newOrderModel.toJson(doc.id));
  }

//---------------------------update---------------------------------

  updateProductData(currentUid, id, price, qnty) async {
    await db
        .collection("Seller")
        .doc(currentUid)
        .collection("Products")
        .doc(id)
        .update({"quantity": qnty, "rate": price});
    fetchproductpage(FirebaseAuth.instance.currentUser!.uid).then((value) {
      notifyListeners();
    });
  }

  notify() {
    notifyListeners();
  }

  updateOrderStatus(orderId, newStatus) {
    db.collection("new request").doc(orderId).update(
        {"orderStatus": newStatus, "requestTime": time, "requestDate": date});
    notifyListeners();
  }

  updateSellerRegister(
      docId, status, email, password, context, sellerModel,) async {
        if(status!="ACTIVATED"){
          await db
        .collection("Seller")
        .doc(docId)
        .update({"status": status}).then((value){
           
        });

        }
    notifyListeners();
    if (status == "ACTIVATED") {
      await _signSeller(email, password, context, sellerModel,docId);
    }
  }

//---------------------------delete---------------------------------
  deleteADocument(collection, docID)async {
  await  db.collection(collection).doc(docID).delete();
    notifyListeners();
  }
//---------------------------read---------------------------------

  void loginUser(email, password, context, toPage, collection) async {
    await firebaseAuth.login(email, password, context).then((uid) {
      print(uid);
      print("=====================================");
      fetchCurrentUser(collection, uid, context, toPage, true);
      notifyListeners();

      // .then((email) {

      print("--------------------------email");
      // });
    });
  }

  List<SellerModel> allSellerList = [];
  Future<List<SellerModel>> fetchAllSeller() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("Seller").get();
    allSellerList = snapshot.docs.map((e) {
      return SellerModel.fromJson(e.data());
    }).toList();
    print(allBuyerList.length);
    return allSellerList;
  }
List<SellerModel> allSellerListinUserPinCode = [];
  Future<List<SellerModel>> fetchAllSellerinUserPincode(userPinCode) async {
    print("===============${userPinCode}");
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("Seller").where("pincode",isEqualTo:userPinCode ).get();
    allSellerListinUserPinCode = snapshot.docs.map((e) {
      return SellerModel.fromJson(e.data());
    }).toList();
    print(allBuyerList.length);
    return allSellerList;
  }
  List<BuyerModel> allBuyerList = [];
  Future<List<BuyerModel>> fetchAllBuyer() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("Buyer").get();
    allBuyerList = snapshot.docs.map((e) {
      return BuyerModel.fromJson(e.data());
    }).toList();
    return allBuyerList;
  }

  BuyerModel? buyerModel;
  SellerModel? sellerModel;
  fetchCurrentUser(collection, uid, context, toPage, bool isfetch) async {
    DocumentReference<Map<String, dynamic>> docRef =
        db.collection(collection).doc(uid);
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      if (collection == "Buyer") {
        buyerModel = BuyerModel.fromJson(snapshot.data()!);
       print(buyerModel!.pincode);
        await fetchAllSellerinUserPincode(buyerModel!.pincode);
        print("==========================");

        if (isfetch) {
          print("in");
          notifyListeners();
          setLoginPrefertrue(collection);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => toPage),
              (route) => false);
        }
      } else if (collection == "Seller") {
        sellerModel = SellerModel.fromJson(snapshot.data()!);
        await fetchproductpage(uid);
        // print(snapshot.data());
        // print("hgfhghh");
        if (isfetch) {
          print("in");
          notifyListeners();
          setLoginPrefertrue(collection);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => toPage),
              (route) => false);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("User not exist this email address..!")));
    }
  }

  List<ProductModel> allProductList = [];
  Future<List<ProductModel>> fetchproductpage(uid) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("Seller").doc(uid).collection("Products").get();
    allProductList = snapshot.docs.map((e) {
      return ProductModel.fromJson(e.data());
    }).toList();

    print("All  product fetched ");
    return allProductList;
  }

 
  List<NewOrderModel> ordersList = [];
  fetchnotificationforSellerAndBuyer(id) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("new request")
        .where(id, isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    ordersList = snapshot.docs.map((e) {
      return NewOrderModel.fromJson(e.data());
    }).toList();
  }

  fetchnotificationAdmin() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("new request").get();

    ordersList = snapshot.docs.map((e) {
      return NewOrderModel.fromJson(e.data());
    }).toList();
  }

  List<SellerModel> registerList = [];
  fetchRegisterdSeller() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("Seller").get();

    registerList = snapshot.docs.map((e) {
      return SellerModel.fromJson(e.data());
    }).toList();
  }
}
