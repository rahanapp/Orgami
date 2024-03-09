import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orgami/model/new_order_model.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';
import 'package:orgami/viewmodel/controller.dart';
import 'package:orgami/viewmodel/firestore.dart';
import 'package:provider/provider.dart';

class SelectedProductPage extends StatelessWidget {
  String selleruid;
  String farmName;
  SelectedProductPage(
      {super.key, required this.selleruid, required this.farmName});
  String time = DateFormat('h:mm a').format(DateTime.now());
  // String day = DateFormat('EEEE').format(DateTime.now());
  String date = DateFormat("dd/m/yyyy").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final instence = Provider.of<FirestoreDb>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
        title: Text(
          "Products",
          style: poppinsStyle(FontWeight.w700, 22, black),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(166, 218, 206, 206),
        height: height,
        width: width,
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
            future: instence.fetchproductpage(selleruid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation(brown),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    farmName,
                    style: poppinsStyle(FontWeight.w700, 20, black),
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: white,
                                  borderRadius: BorderRadius.circular(20)),
                              width: width * .4,
                              height: 120,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        instence.allProductList[index].id,
                                        style: poppinsStyle(
                                            FontWeight.w700, 18, black),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            width: width,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Color.fromARGB(
                                                    255, 233, 248, 234)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "PRICE: ${instence.allProductList[index].rate}",
                                                      style: poppinsStyle(
                                                          FontWeight.w600,
                                                          15,
                                                          black),
                                                    ),
                                                    Text(
                                                      "QUANTITY: ${instence.allProductList[index].quantity} L   ",
                                                      style: poppinsStyle(
                                                          FontWeight.w600,
                                                          15,
                                                          black),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  height: 30,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        buyMessage(
                                                          context,
                                                          instence
                                                              .allProductList[
                                                                  index]
                                                              .rate,
                                                          instence
                                                              .allProductList[
                                                                  index]
                                                              .quantity,
                                                          instence,
                                                          instence
                                                              .allProductList[
                                                                  index]
                                                              .id,
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      255,
                                                                      42,
                                                                      27)),
                                                      child: Text(
                                                        "BUY NOW",
                                                        style: poppinsStyle(
                                                            FontWeight.w400,
                                                            16,
                                                            white),
                                                      )),
                                                )
                                              ],
                                            )))
                                  ]),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 50,
                            ),
                        itemCount: instence.allProductList.length),
                  )
                ],
              );
            }),
      ),
    );
  }

  buyMessage(context, price, maxQuantity, FirestoreDb instence, productNmae) {
    int rate = int.parse(price);
    int qty = int.parse(maxQuantity);
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer<Controller>(builder: (context, controller, child) {
          return AlertDialog(
            title: Column(
              children: [
                Text("Rs. ${controller.totalprice}"),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 40),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.decrementCounter(rate);
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: controller.isRemoveIconPressed
                                  ? const Color(0xCCB7A6FC)
                                  : const Color.fromARGB(255, 142, 140, 140),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Icon(Icons.remove, size: 10),
                          ),
                        ),
                        // const SizedBox(width: 30),
                        Container(
                          alignment: Alignment.center,
                          color: Colors.white,
                          height: 20,
                          width: 30,
                          child: Text(
                            controller.quantity.toString(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                        // const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            controller.incrementCounter(qty, rate);
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: controller.isAddIconPressed
                                  ? const Color(0xCCB7A6FC)
                                  : const Color.fromARGB(255, 142, 140, 140),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Icon(Icons.add, size: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  controller.clearData();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (controller.quantity != 0) {
                    await instence
                        .buyANewProduct(NewOrderModel(
                            requestTime: time,
                            requestDate: date,
                            orderStatus: "PENDING",
                            ratePerQuantity: price,
                            buyerId: "${instence.buyerModel?.buyerId}",
                            buyerName: "${instence.buyerModel?.name}",
                            product: productNmae,
                            quantity: controller.quantity.toString(),
                            rate: controller.totalprice.toString(),
                            sellerId: selleruid))
                        .then((value) {
                      controller.clearData();
                      Navigator.of(context).pop();
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Required min.1 quantity for placing your order")));
                  }
                },
                child: const Text(
                  "Confirm",
                  style: TextStyle(color: Colors.green),
                ),
              )
            ],
          );
        });
      },
    );
  }
}
