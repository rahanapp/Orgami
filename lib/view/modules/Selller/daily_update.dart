// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_carousel_slider/carousel_slider.dart';
// import 'package:orgami/model/product_model.dart';
// import 'package:orgami/utils/colors.dart';
// import 'package:orgami/utils/text_style.dart';
// import 'package:orgami/utils/variables.dart';
// import 'package:orgami/view/widgets/custom_button.dart';
// import 'package:orgami/viewmodel/firestore.dart';
// import 'package:provider/provider.dart';

// class DailyUpdatePage2 extends StatelessWidget {
//   DailyUpdatePage2({super.key});
//   var milkQuantity = TextEditingController(text: "200");
//   var curdQuantity = TextEditingController(text: "200");
//   var butterQuantity = TextEditingController(text: "200");
//   var butterMilkQuantity = TextEditingController(text: "200");

//   var milkRate = TextEditingController(text: "20");
//   var curdRate = TextEditingController(text: "30");
//   var butterRate = TextEditingController(text: "40");
//   var butterMilkRate = TextEditingController(text: "50");
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;

//     final data =
//         firestoreDb.fetchproductpage(FirebaseAuth.instance.currentUser!.uid);
//     Map<String, dynamic> values = {
//       "quantity": [
//         milkQuantity,
//         curdQuantity,
//         butterQuantity,
//         butterMilkQuantity
//       ],
//       "rate": [milkRate, curdRate, butterRate, butterMilkRate],
//     };
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         leadingWidth: 50,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: IconButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               icon: const Icon(
//                 Icons.arrow_back_ios_new_outlined,
//                 color: black,
//                 size: 20,
//               )),
//         ),
//         backgroundColor: white,
//         elevation: 0,
//         centerTitle: true,
//         title: Center(
//           child: Row(
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(
//                 Icons.update,
//                 color: black,
//                 size: 40,
//               ),
//               Text(
//                 "Daily Update",
//                 style: poppinsStyle(FontWeight.w700, 20, black),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: data == null
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : Container(
//               padding: const EdgeInsets.only(
//                   left: 20, right: 20, top: 20, bottom: 20),
//               height: height * .85,
//               width: width,
//               margin: const EdgeInsets.only(
//                 left: 10,
//                 right: 10,
//                 top: 10,
//               ),
//               decoration: const BoxDecoration(
//                   color: Color.fromARGB(166, 190, 198, 206),
//                   borderRadius: BorderRadius.all(Radius.circular(20))),
//               child: ListView(
//                 children: [
//                   firestoreDb.allProductList.length == 0
//                       ? Container(
//                           height: height * .2,
//                           width: width,
//                           decoration: BoxDecoration(
//                             color: white,
//                             boxShadow: [
//                               BoxShadow(
//                                   offset: const Offset(5, 5),
//                                   color: Colors.black.withOpacity(.09),
//                                   spreadRadius: .02,
//                                   blurRadius: 1)
//                             ],
//                           ),
//                           child: Column(
//                             children: [
//                               Text(
//                                 // "${values["head"][index]}".toUpperCase(),
//                                 firestoreDb.allProductList[0].id.toUpperCase(),
//                                 style: poppinsStyle(FontWeight.w700, 20, black),
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Text(
//                                         "${firestoreDb.allProductList[0].id} Quantity",
//                                         style: poppinsStyle(
//                                             FontWeight.w400, 17, black),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         height: 60,
//                                         width: 130,
//                                         child: TextField(
//                                           showCursor: false,
//                                           maxLength: 5,
//                                           maxLines: 1,
//                                           style: poppinsStyle(
//                                               FontWeight.bold, 22, white),
//                                           keyboardType: TextInputType.number,
//                                           controller: values["quantity"][0],
//                                           decoration: InputDecoration(
//                                               suffixText: "Ltr ",
//                                               suffixStyle: poppinsStyle(
//                                                   FontWeight.bold, 22, white),
//                                               filled: true,
//                                               fillColor: const Color.fromARGB(
//                                                   187, 166, 158, 158),
//                                               enabledBorder:
//                                                   const OutlineInputBorder(),
//                                               focusedBorder:
//                                                   const OutlineInputBorder()),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       Text(
//                                         "${firestoreDb.allProductList[0].id} Rate",
//                                         style: poppinsStyle(
//                                             FontWeight.w400, 17, black),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         height: 60,
//                                         width: 100,
//                                         child: TextField(
//                                           showCursor: false,
//                                           style: poppinsStyle(
//                                               FontWeight.bold, 22, white),
//                                           keyboardType: TextInputType.number,
//                                           controller: values["rate"][0],
//                                           maxLength: 3,
//                                           decoration: InputDecoration(
//                                               prefixText: "RS ",
//                                               prefixStyle: poppinsStyle(
//                                                   FontWeight.bold, 22, white),
//                                               filled: true,
//                                               fillColor: const Color.fromARGB(
//                                                   187, 166, 158, 158),
//                                               enabledBorder:
//                                                   const OutlineInputBorder(),
//                                               focusedBorder:
//                                                   const OutlineInputBorder()),
//                                         ),
//                                       ),
//                                       // ElevatedButton(
//                                       //     onPressed: () {}, child: Text("data"))
//                                     ],
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       : SizedBox(),
//                   firestoreDb.allProductList.length == 1
//                       ? Container(
//                           height: height * .2,
//                           width: width,
//                           decoration: BoxDecoration(
//                             color: white,
//                             boxShadow: [
//                               BoxShadow(
//                                   offset: const Offset(5, 5),
//                                   color: Colors.black.withOpacity(.09),
//                                   spreadRadius: .02,
//                                   blurRadius: 1)
//                             ],
//                           ),
//                           child: Column(
//                             children: [
//                               Text(
//                                 // "${values["head"][index]}".toUpperCase(),
//                                 firestoreDb.allProductList[1].id.toUpperCase(),
//                                 style: poppinsStyle(FontWeight.w700, 20, black),
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Text(
//                                         "${firestoreDb.allProductList[1].id} Quantity",
//                                         style: poppinsStyle(
//                                             FontWeight.w400, 17, black),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         height: 60,
//                                         width: 130,
//                                         child: TextField(
//                                           showCursor: false,
//                                           maxLength: 5,
//                                           maxLines: 1,
//                                           style: poppinsStyle(
//                                               FontWeight.bold, 22, white),
//                                           keyboardType: TextInputType.number,
//                                           controller: values["quantity"][1],
//                                           decoration: InputDecoration(
//                                               suffixText: "Ltr ",
//                                               suffixStyle: poppinsStyle(
//                                                   FontWeight.bold, 22, white),
//                                               filled: true,
//                                               fillColor: const Color.fromARGB(
//                                                   187, 166, 158, 158),
//                                               enabledBorder:
//                                                   const OutlineInputBorder(),
//                                               focusedBorder:
//                                                   const OutlineInputBorder()),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       Text(
//                                         "${firestoreDb.allProductList[1].id} Rate",
//                                         style: poppinsStyle(
//                                             FontWeight.w400, 17, black),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         height: 60,
//                                         width: 100,
//                                         child: TextField(
//                                           showCursor: false,
//                                           style: poppinsStyle(
//                                               FontWeight.bold, 22, white),
//                                           keyboardType: TextInputType.number,
//                                           controller: values["rate"][1],
//                                           maxLength: 3,
//                                           decoration: InputDecoration(
//                                               prefixText: "RS ",
//                                               prefixStyle: poppinsStyle(
//                                                   FontWeight.bold, 22, white),
//                                               filled: true,
//                                               fillColor: const Color.fromARGB(
//                                                   187, 166, 158, 158),
//                                               enabledBorder:
//                                                   const OutlineInputBorder(),
//                                               focusedBorder:
//                                                   const OutlineInputBorder()),
//                                         ),
//                                       ),
//                                       // ElevatedButton(
//                                       //     onPressed: () {}, child: Text("data"))
//                                     ],
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       : SizedBox(),
//                   firestoreDb.allProductList.length == 2
//                       ? Container(
//                           height: height * .2,
//                           width: width,
//                           decoration: BoxDecoration(
//                             color: white,
//                             boxShadow: [
//                               BoxShadow(
//                                   offset: const Offset(5, 5),
//                                   color: Colors.black.withOpacity(.09),
//                                   spreadRadius: .02,
//                                   blurRadius: 1)
//                             ],
//                           ),
//                           child: Column(
//                             children: [
//                               Text(
//                                 // "${values["head"][index]}".toUpperCase(),
//                                 firestoreDb.allProductList[2].id.toUpperCase(),
//                                 style: poppinsStyle(FontWeight.w700, 20, black),
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Text(
//                                         "${firestoreDb.allProductList[2].id} Quantity",
//                                         style: poppinsStyle(
//                                             FontWeight.w400, 17, black),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         height: 60,
//                                         width: 130,
//                                         child: TextField(
//                                           showCursor: false,
//                                           maxLength: 5,
//                                           maxLines: 1,
//                                           style: poppinsStyle(
//                                               FontWeight.bold, 22, white),
//                                           keyboardType: TextInputType.number,
//                                           controller: values["quantity"][2],
//                                           decoration: InputDecoration(
//                                               suffixText: "Ltr ",
//                                               suffixStyle: poppinsStyle(
//                                                   FontWeight.bold, 22, white),
//                                               filled: true,
//                                               fillColor: const Color.fromARGB(
//                                                   187, 166, 158, 158),
//                                               enabledBorder:
//                                                   const OutlineInputBorder(),
//                                               focusedBorder:
//                                                   const OutlineInputBorder()),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       Text(
//                                         "${firestoreDb.allProductList[2].id} Rate",
//                                         style: poppinsStyle(
//                                             FontWeight.w400, 17, black),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         height: 60,
//                                         width: 100,
//                                         child: TextField(
//                                           showCursor: false,
//                                           style: poppinsStyle(
//                                               FontWeight.bold, 22, white),
//                                           keyboardType: TextInputType.number,
//                                           controller: values["rate"][2],
//                                           maxLength: 3,
//                                           decoration: InputDecoration(
//                                               prefixText: "RS ",
//                                               prefixStyle: poppinsStyle(
//                                                   FontWeight.bold, 22, white),
//                                               filled: true,
//                                               fillColor: const Color.fromARGB(
//                                                   187, 166, 158, 158),
//                                               enabledBorder:
//                                                   const OutlineInputBorder(),
//                                               focusedBorder:
//                                                   const OutlineInputBorder()),
//                                         ),
//                                       ),
//                                       // ElevatedButton(
//                                       //     onPressed: () {}, child: Text("data"))
//                                     ],
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       : SizedBox(),
//                   firestoreDb.allProductList.length == 3
//                       ? Container(
//                           height: height * .2,
//                           width: width,
//                           decoration: BoxDecoration(
//                             color: white,
//                             boxShadow: [
//                               BoxShadow(
//                                   offset: const Offset(5, 5),
//                                   color: Colors.black.withOpacity(.09),
//                                   spreadRadius: .02,
//                                   blurRadius: 1)
//                             ],
//                           ),
//                           child: Column(
//                             children: [
//                               Text(
//                                 // "${values["head"][index]}".toUpperCase(),
//                                 firestoreDb.allProductList[0].id.toUpperCase(),
//                                 style: poppinsStyle(FontWeight.w700, 20, black),
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Text(
//                                         "${firestoreDb.allProductList[3].id} Quantity",
//                                         style: poppinsStyle(
//                                             FontWeight.w400, 17, black),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         height: 60,
//                                         width: 130,
//                                         child: TextField(
//                                           showCursor: false,
//                                           maxLength: 5,
//                                           maxLines: 1,
//                                           style: poppinsStyle(
//                                               FontWeight.bold, 22, white),
//                                           keyboardType: TextInputType.number,
//                                           controller: values["quantity"][3],
//                                           decoration: InputDecoration(
//                                               suffixText: "Ltr ",
//                                               suffixStyle: poppinsStyle(
//                                                   FontWeight.bold, 22, white),
//                                               filled: true,
//                                               fillColor: const Color.fromARGB(
//                                                   187, 166, 158, 158),
//                                               enabledBorder:
//                                                   const OutlineInputBorder(),
//                                               focusedBorder:
//                                                   const OutlineInputBorder()),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       Text(
//                                         "${firestoreDb.allProductList[3].id} Rate",
//                                         style: poppinsStyle(
//                                             FontWeight.w400, 17, black),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         height: 60,
//                                         width: 100,
//                                         child: TextField(
//                                           showCursor: false,
//                                           style: poppinsStyle(
//                                               FontWeight.bold, 22, white),
//                                           keyboardType: TextInputType.number,
//                                           controller: values["rate"][3],
//                                           maxLength: 3,
//                                           decoration: InputDecoration(
//                                               prefixText: "RS ",
//                                               prefixStyle: poppinsStyle(
//                                                   FontWeight.bold, 22, white),
//                                               filled: true,
//                                               fillColor: const Color.fromARGB(
//                                                   187, 166, 158, 158),
//                                               enabledBorder:
//                                                   const OutlineInputBorder(),
//                                               focusedBorder:
//                                                   const OutlineInputBorder()),
//                                         ),
//                                       ),
//                                       // ElevatedButton(
//                                       //     onPressed: () {}, child: Text("data"))
//                                     ],
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       : SizedBox()
//                 ],
//               ),
//             ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: SizedBox(
//         width: width,
//         height: 130,
//         child: Center(
//           child: customeButton(
//               onpressed: () {
//                 showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                           elevation: 0,
//                           backgroundColor: Colors.transparent,
//                           title: Column(
//                             children: [
//                               const Icon(
//                                 CupertinoIcons.check_mark_circled,
//                                 size: 200,
//                                 color: Color.fromARGB(255, 111, 91, 84),
//                               ),
//                               Text(
//                                 "Update Succesfull!",
//                                 style: poppinsStyle(FontWeight.w700, 20, white),
//                               )
//                             ],
//                           ),
//                         ));
//               },
//               buttonwidth: .6,
//               buttonHight: .05,
//               context: context,
//               text: "Update",
//               textcolor: white,
//               bgColor: const MaterialStatePropertyAll(brown)),
//         ),
//       ),
//     );
//   }
// }
