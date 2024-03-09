import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';
import 'package:orgami/viewmodel/firestore.dart';
import 'package:provider/provider.dart';

class DailyUpdateAdmin extends StatelessWidget {
  const DailyUpdateAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.keyboard_arrow_left_outlined,
              color: black,
              size: 40,
            )),
        title: Text(
          "Daily Updates",
          style: poppinsStyle(FontWeight.w700, 20, black),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromARGB(166, 190, 198, 206),
        ),
        child: Column(children: [
          Container(
              width: width / 2.5,
              height: 30,
              decoration: BoxDecoration(
                color: grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "ORDERS",
                  style: poppinsStyle(FontWeight.w700, 16, black),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Consumer<FirestoreDb>(builder: (context, firestore, child) {
            return FutureBuilder(
                future: firestore.fetchnotificationAdmin(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  final data = firestore.ordersList;
                  return Expanded(
                      child: data.isEmpty
                          ? const Center(
                              child: Text("no updates"),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                return Container(
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    width: width,
                                    height: height * .15,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                const Icon(
                                                  CupertinoIcons
                                                      .person_alt_circle,
                                                  color: black,
                                                  size: 70,
                                                ),
                                                Text(
                                                  data[index].buyerName,
                                                  style: poppinsStyle(
                                                      FontWeight.w700,
                                                      12,
                                                      black),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      "${data[index].product} quantity",
                                                      style: poppinsStyle(
                                                          FontWeight.w700,
                                                          14,
                                                          black),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      width: 70,
                                                      decoration: BoxDecoration(
                                                          color: brown,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3)),
                                                      child: Center(
                                                        child: Text(
                                                          "${data[index].quantity} ltr",
                                                          style: poppinsStyle(
                                                              FontWeight.w700,
                                                              14,
                                                              white),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "${data[index].product} rate",
                                                  style: poppinsStyle(
                                                      FontWeight.w700,
                                                      14,
                                                      black),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: brown,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                  child: Center(
                                                    child: Text(
                                                      "RS ${data[index].ratePerQuantity} - 1 ltr",
                                                      style: poppinsStyle(
                                                          FontWeight.w700,
                                                          14,
                                                          white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              // width: 80,
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          acceptButtonColor(
                                                              data[index]
                                                                  .orderStatus),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20))),
                                                  onPressed: () {
                                                    if (data[index]
                                                            .orderStatus ==
                                                        "PENDING") {
                                                      firestore
                                                          .updateOrderStatus(
                                                              data[index]
                                                                  .orderId,
                                                              "ACCEPTED");
                                                    }
                                                  },
                                                  child: Text(
                                                    acceptButtonText(data[index]
                                                        .orderStatus),
                                                    style: poppinsStyle(
                                                        FontWeight.w600,
                                                        14,
                                                        white),
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              // width: 80,
                                              child: ElevatedButton(
                                                  onPressed: () async {
                                                    if (data[index]
                                                            .orderStatus ==
                                                        "PENDING") {
                                                      await firestore
                                                          .updateOrderStatus(
                                                              data[index]
                                                                  .orderId,
                                                              "REJECTED");
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          rejectButtonColor(
                                                              data[index]
                                                                  .orderStatus),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20))),
                                                  child: Text(
                                                    rejectButtonText(data[index]
                                                        .orderStatus),
                                                    style: poppinsStyle(
                                                        FontWeight.w600,
                                                        14,
                                                        white),
                                                  )),
                                            )
                                          ],
                                        )
                                      ],
                                    ));
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                              itemCount: data.length));
                });
          })
        ]),
      ),
    );
  }

  acceptButtonColor(status) {
    switch (status) {
      case "PENDING":
        return Colors.amber;
      case "ACCEPTED":
        return Colors.green;
      case "REJECTED":
        return grey;
    }
  }

  acceptButtonText(status) {
    switch (status) {
      case "PENDING":
        return "Accept";
      case "ACCEPTED":
        return "Accepted";
      case "REJECTED":
        return "Accept";
    }
  }

  rejectButtonText(status) {
    switch (status) {
      case "PENDING":
        return "Reject";
      case "ACCEPTED":
        return "Reject";
      case "REJECTED":
        return "Rejected";
    }
  }

  rejectButtonColor(status) {
    switch (status) {
      case "PENDING":
        return Colors.red;
      case "ACCEPTED":
        return grey;
      case "REJECTED":
        return grey;
    }
  }
}
