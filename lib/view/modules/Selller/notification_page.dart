import 'package:flutter/material.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';
import 'package:orgami/viewmodel/firestore.dart';
import 'package:provider/provider.dart';

class SellerNotificationPage extends StatelessWidget {
  const SellerNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("notificationfbbcbbcb===================");
    final provider = Provider.of<FirestoreDb>(context, listen: false);
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
            "Order",
            style: poppinsStyle(FontWeight.w700, 22, black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
          margin: const EdgeInsets.only(left: 10, right: 10),
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 215, 202, 200),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20, left: 25),
                padding: const EdgeInsets.only(
                  left: 6,
                  right: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(148, 133, 133, 133),
                ),
                child: Text(
                  "All",
                  style: poppinsStyle(FontWeight.w700, 19, black),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                      future: provider
                          .fetchnotificationforSellerAndBuyer("sellerId"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: brown,
                              valueColor: AlwaysStoppedAnimation(white),
                            ),
                          );
                        }
                        final data = provider.ordersList;
                        return data.isEmpty
                            ? const Center(
                                child: Text("No Notifications"),
                              )
                            : GridView.builder(
                                itemCount: data.length,
                                gridDelegate:
                                     SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: height*.0010,
                                        mainAxisSpacing: 10),
                                itemBuilder: (context, index) => Container(
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "ORDER 10${index + 1}",
                                              style: poppinsStyle(
                                                  FontWeight.w700, 15, black),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  color: Color.fromARGB(
                                                      255, 233, 248, 234)),
                                              child: Column(
                                                children: [
                                                  Text(
                                                      data[index].product,
                                                      style: poppinsStyle(
                                                          FontWeight.w600,
                                                          15,
                                                          black),
                                                    ),
                                                  ListTile(
                                                    // leading: Text(
                                                    //   data[index].product,
                                                    //   style: poppinsStyle(
                                                    //       FontWeight.w600,
                                                    //       15,
                                                    //       black),
                                                    // ),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Quantity:${data[index].quantity} ltr",
                                                          style: poppinsStyle(
                                                              FontWeight.w600,
                                                              14,
                                                              black),
                                                        ),
                                                        Text(
                                                          "Price:${data[index].rate}",
                                                          style: poppinsStyle(
                                                              FontWeight.w600,
                                                              14,
                                                              black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Expanded(child: SizedBox()),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      data[index].orderStatus,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: statsusColor(
                                                            data[index]
                                                                .orderStatus,
                                                          )),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                      }))
            ],
          ),
        ));
  }

  statsusColor(status) {
    switch (status) {
      case "PENDING":
        return Colors.amber;
      case "ACCEPTED":
        return Colors.green;
      case "REJECTED":
        return Colors.red;
    }
  }
}
