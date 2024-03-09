import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';
import 'package:orgami/viewmodel/firestore.dart';
import 'package:provider/provider.dart';

class ViewAllBuyersAdmin extends StatelessWidget {
  const ViewAllBuyersAdmin({super.key});

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
          "Buyers",
          style: poppinsStyle(FontWeight.w700, 20, black),
        ),
      ),
      body: Consumer<FirestoreDb>(builder: (context, firestore, child) {
        return FutureBuilder(
            future: firestore.fetchAllBuyer(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = snapshot.data;
              return Container(
                  height: height,
                  width: width,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: grey,
                  ),
                  child: data!.isEmpty || data == null
                      ? const Center(
                          child: Text("Buyers not found"),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return Dismissible(
                              confirmDismiss: (direction) {
                                return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                          "Are you Sure about delete this user"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text(
                                              "No",
                                              style: TextStyle(
                                                  color: Colors.green),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              firestore.deleteADocument(
                                                  "Buyer", data[index].buyerId);
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text("Yes",
                                                style: TextStyle(
                                                    color: Colors.red)))
                                      ],
                                    );
                                  },
                                );

                                // if(direction.name)
                              },
                              background: ColoredBox(
                                  color: Colors.red,
                                  child: SizedBox(
                                    width: width,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Delete",
                                          style: poppinsStyle(
                                              FontWeight.w700, 20, black),
                                        )),
                                  )),
                              secondaryBackground: ColoredBox(
                                  color: Colors.red,
                                  child: SizedBox(
                                    width: width,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Delete",
                                          style: poppinsStyle(
                                              FontWeight.w700, 20, black),
                                        )),
                                  )),
                              key: Key(index.toString()),
                              child: Container(
                                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: black.withOpacity(.2),
                                            offset: const Offset(0, 2))
                                      ],
                                      color: white,
                                      borderRadius: BorderRadius.circular(15)),
                                  width: width,
                                  height: height * .15,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        CupertinoIcons.person_alt_circle,
                                        color: black,
                                        size: 70,
                                      ),
                                      SizedBox(
                                        width: width * .4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index].name.toUpperCase(),
                                              style: poppinsStyle(
                                                  FontWeight.w500, 16, black),
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                data[index].address,
                                                style: poppinsStyle(
                                                    FontWeight.w400, 14, black),
                                              ),
                                            ),
                                            Text(
                                              "PH:${data[index].mobileNumber}",
                                              style: poppinsStyle(
                                                  FontWeight.w400, 14, black),
                                            ),
                                            Text(
                                              "Pincode: ${data[index].pincode}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: poppinsStyle(
                                                  FontWeight.w400, 14, black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Column(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceEvenly,
                                      //   children: [
                                      //     SizedBox(
                                      //       height: 30,
                                      //       width: 80,
                                      //       child: ElevatedButton(
                                      //           style: ElevatedButton.styleFrom(
                                      //               backgroundColor:
                                      //                   Colors.orange,
                                      //               shape:
                                      //                   RoundedRectangleBorder(
                                      //                       borderRadius:
                                      //                           BorderRadius
                                      //                               .circular(
                                      //                                   20))),
                                      //           onPressed: () {},
                                      //           child: Text(
                                      //             "Block",
                                      //             style: poppinsStyle(
                                      //                 FontWeight.w600,
                                      //                 14,
                                      //                 white),
                                      //           )),
                                      //     ),
                                      //   ],
                                      // )
                                    ],
                                  )),
                            );
                          },
                          itemCount: data.length));
            });
      }),
    );
  }
}
