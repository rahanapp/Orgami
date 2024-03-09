import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';
import 'package:orgami/viewmodel/firestore.dart';
import 'package:provider/provider.dart';

class BuyerNotificationPage extends StatelessWidget {
  const BuyerNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            "Notification",
            style: poppinsStyle(FontWeight.w700, 22, black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recent",
                style: poppinsStyle(FontWeight.w700, 22, black),
              ),
              Expanded(
                child: FutureBuilder(
                    future:
                        provider.fetchnotificationforSellerAndBuyer("buyerId"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: brown,
                            valueColor: AlwaysStoppedAnimation(white),
                          ),
                        );
                      }
                      final data = provider.ordersList;
                      return ListView.separated(
                      
                          itemBuilder: (context, index) => Container(
                            
                                decoration: BoxDecoration(
                                    color: grey.withOpacity(.7),
                                    borderRadius: BorderRadius.circular(5)),
                                width: width,
                                // height: height * .1,
                                child: ListTile(
                                  minLeadingWidth: width*.07,
                                  leading: notificationBadge(
                                      child: const Icon(
                                        CupertinoIcons.bell_fill,
                                        color: white,
                                        size: 30,
                                      ),
                                      bgcolor: notificationIconColor(
                                          data[index].orderStatus)),
                                  title: Text(
                                    notificationStatus(data[index].orderStatus),
                                    style: poppinsStyle(
                                        FontWeight.w700, 18, black),
                                  ),
                                  subtitle: Text(
                                    notificationMessage(
                                        data[index].orderStatus),
                                    style: poppinsStyle(FontWeight.w700, 14,
                                        Colors.black.withOpacity(.2)),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        data[index].requestDate,
                                        style: poppinsStyle(
                                            FontWeight.w200, 10, black),
                                      ),
                                      Text(
                                        data[index].requestTime,
                                        style: poppinsStyle(
                                            FontWeight.w200, 10, black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 20,
                              ),
                          itemCount: data.length);
                    }),
              )
            ],
          ),
        ));
  }

  notificationStatus(status) {
    switch (status) {
      case "PENDING":
        return "Preparing your order";
      case "ACCEPTED":
        return "Successfully orderd..!";
      case "REJECTED":
        return "Sorry,this order not possible to deliver";
    }
  }

  notificationMessage(status) {
    switch (status) {
      case "PENDING":
        return "Wait for the confirmation";
      case "ACCEPTED":
        return "Will be placed soon";
      case "REJECTED":
        return "Try your next order";
    }
  }

  notificationIconColor(status) {
    switch (status) {
      case "PENDING":
        return Colors.white;
      case "ACCEPTED":
        return const Color.fromARGB(255, 220, 255, 222);
      case "REJECTED":
        return const Color(0xFFFBB2AC);
    }
  }

  Widget notificationBadge({
    child,
    bgcolor,
  }) {
    return badges.Badge(
        position: badges.BadgePosition.topStart(top: -5, start: 25),
        badgeAnimation: const badges.BadgeAnimation.slide(
            // disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
            // curve: Curves.easeInCubic,
            ),
        showBadge: true,
        badgeStyle: badges.BadgeStyle(
          badgeColor: bgcolor,
        ),
        // badgeContent: Text(
        //   content,
        //   style: const TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
        child: child);
  }
}
