import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';
import 'package:orgami/viewmodel/firestore.dart';
import 'package:provider/provider.dart';

class DailyUpdatePage extends StatelessWidget {
  // FirestoreDb firestore;
  DailyUpdatePage({
    super.key,
  });
  var milkQuantity = TextEditingController();
  var curdQuantity = TextEditingController();
  var butterQuantity = TextEditingController();
  var butterMilkQuantity = TextEditingController();

  var milkRate = TextEditingController();
  var curdRate = TextEditingController();
  var butterRate = TextEditingController();
  var butterMilkRate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Map<String, dynamic> controller = {
      "quantity": <TextEditingController>[
        milkQuantity,
        curdQuantity,
        butterQuantity,
        butterMilkQuantity
      ],
      "rate": [milkRate, curdRate, butterRate, butterMilkRate],
    };
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leadingWidth: 50,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: black,
                  size: 20,
                )),
          ),
          backgroundColor: white,
          elevation: 0,
          centerTitle: true,
          title: Center(
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.update,
                  color: black,
                  size: 40,
                ),
                Text(
                  "Daily Update",
                  style: poppinsStyle(FontWeight.w700, 20, black),
                ),
              ],
            ),
          ),
        ),
        body: Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            height: height * .85,
            width: width,
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            decoration: const BoxDecoration(
                color: Color.fromARGB(166, 190, 198, 206),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Consumer<FirestoreDb>(builder: (context, firestore, child) {
              return ListView.separated(
                  itemCount: firestore.allProductList.length,
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                  itemBuilder: (context, index) {
                    return Container(
                      height: height * .2,
                      width: width,
                      decoration: BoxDecoration(
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(5, 5),
                              color: Colors.black.withOpacity(.09),
                              spreadRadius: .02,
                              blurRadius: 1)
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            // "${values["head"][index]}".toUpperCase(),
                            firestore.allProductList[index].id.toUpperCase(),
                            style: poppinsStyle(FontWeight.w700, 20, black),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "${firestore.allProductList[index].id} Quantity",
                                    style: poppinsStyle(
                                        FontWeight.w400, 17, black),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 60,
                                    width: 130,
                                    child: TextFormField(
                                      showCursor: false,
                                      maxLength: 5,
                                      maxLines: 1,
                                      style: poppinsStyle(
                                          FontWeight.bold, 22, white),
                                      keyboardType: TextInputType.number,
                                      controller: controller["quantity"]
                                              [index] =
                                          TextEditingController(
                                              text: firestore
                                                  .allProductList[index]
                                                  .quantity
                                                  .toString()),
                                      onFieldSubmitted: (value) async {
                                        await firestore.updateProductData(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          firestore.allProductList[index].id,
                                          firestore.allProductList[index].rate,
                                          controller["quantity"][index].text,
                                        );
                                        firestore.notify();
                                      },
                                      decoration: InputDecoration(
                                          suffixText: "Ltr ",
                                          suffixStyle: poppinsStyle(
                                              FontWeight.bold, 22, white),
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              187, 166, 158, 158),
                                          enabledBorder:
                                              const OutlineInputBorder(),
                                          focusedBorder:
                                              const OutlineInputBorder()),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${firestore.allProductList[index].id} Rate",
                                    style: poppinsStyle(
                                        FontWeight.w400, 17, black),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 60,
                                    width: 100,
                                    child: TextFormField(
                                      showCursor: false,
                                      style: poppinsStyle(
                                          FontWeight.bold, 22, white),
                                      keyboardType: TextInputType.number,
                                      controller: controller["rate"][index] =
                                          TextEditingController(
                                              text: firestore
                                                  .allProductList[index].rate
                                                  .toString()),
                                      onFieldSubmitted: (value) async {
                                        await firestore.updateProductData(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          firestore.allProductList[index].id,
                                          controller["rate"][index].text,
                                          firestore
                                              .allProductList[index].quantity,
                                        );
                                      },
                                      maxLength: 3,
                                      decoration: InputDecoration(
                                          prefixText: "RS ",
                                          prefixStyle: poppinsStyle(
                                              FontWeight.bold, 22, white),
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              187, 166, 158, 158),
                                          enabledBorder:
                                              const OutlineInputBorder(),
                                          focusedBorder:
                                              const OutlineInputBorder()),
                                    ),
                                  ),
                                  // ElevatedButton(
                                  //     onPressed: () {}, child: Text("data"))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }

                 
                  );
            })));
  }
}
