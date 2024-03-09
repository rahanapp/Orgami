import 'package:flutter/material.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/view/modules/Admin/daily_updates.dart';
import 'package:orgami/view/modules/Admin/new_request.dart';
import 'package:orgami/view/modules/Admin/view_buyer.dart';
import 'package:orgami/view/modules/Admin/view_seller.dart';

class AdminHomePage extends StatelessWidget {
  AdminHomePage({super.key});

  List<Map<String, dynamic>> datas = [
    {
      "name": "New request",
      "image": "assets/newReq.png",
      "page": const NewRequestPageAdmin()
    },
    {
      "name": "Daily updates",
      "image": "assets/dailyUpdate.png",
      "page": const DailyUpdateAdmin()
    },
    {
      "name": "View sellers",
      "image": "assets/viewseller.png",
      "page": const ViewAllSellerAdmin()
    },
    {
      "name": "View buyers",
      "image": "assets/viewbuyer.png",
      "page": const ViewAllBuyersAdmin()
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(children: [
      SizedBox(
        height: height * .25,
      ),
      Expanded(
        child: GridView.builder(
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                    height: height * .15,
                    width: width * .35,
                    child: Image.asset(
                      datas[index]["image"],
                      // fit: BoxFit.fill,
                    )),
                SizedBox(
                  width: width * .4,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contetx) => datas[index]["page"]));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: brown,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(datas[index]["name"],                                                maxLines: 1,
),
                  ),
                )
              ],
            );
          },
        ),
      ),
    ]);
  }
}
