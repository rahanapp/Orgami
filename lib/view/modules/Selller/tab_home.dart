import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/img.dart';
import 'package:orgami/viewmodel/firestore.dart';
import 'package:provider/provider.dart';

class SellerHomePage extends StatelessWidget {
  const SellerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: height * .1,
      ),
      Container(
        margin: const EdgeInsets.all(10),
        width: width,
        height: height * .35,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage(imgsellerHomeCow))),
      ),
      Consumer<FirestoreDb>(builder: (context, firestore, child) {
        // firestore.allProductList.forEach(
        //   (element) => print(element.),
        // );
// List<ProductModel> firestore.allProductList.map((e){
//           return ProductModel.fromJson(e as Map<String ,dynamic>);
//         }).toList();
        return Card(
          // height: 200,
          color: white,
          elevation: 2,
          margin: EdgeInsets.only(left: 10, right: width / 3.5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Text(
                "Todays Rate",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, fontSize: 21),
              ),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: firestore.allProductList.length,
                itemBuilder: (context, index) => Text(
                  "${firestore.allProductList[index].id}: ${firestore.allProductList[index].rate} rs",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 21),
                ),
              ),
            ]),
          ),
        );
      }),
      SizedBox(height: 20,),
      // Padding(
      //   padding: const EdgeInsets.only(top: 10, left: 8),
      //   child: ElevatedButton(
      //       onPressed: () {},
      //       style: ElevatedButton.styleFrom(backgroundColor: grey),
      //       child: Text(
      //         "View Orders",
      //         style: GoogleFonts.poppins(
      //             color: black, fontWeight: FontWeight.w700, fontSize: 21),
      //       )),
      // ),
      Expanded(
        child: Center(child: Image.asset(imgFarmerAndCow)),
      )
    ]);
  }
}
