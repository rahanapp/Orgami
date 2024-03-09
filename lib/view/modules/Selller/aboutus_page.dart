import 'package:flutter/material.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/utils/text_style.dart';

class SellerAboutUsPage extends StatelessWidget {
  const SellerAboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("about====================");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
        // centerTitle: true,
        title: Text(
          "About Us",
          style: poppinsStyle(FontWeight.w700, 20, black),
        ),
      ),
      body: Container(
        width: width,
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(5, 5),
                  color: Colors.black.withOpacity(.09),
                  spreadRadius: .02,
                  blurRadius: 1)
            ],
            color: const Color.fromARGB(166, 190, 198, 206),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: SingleChildScrollView(
          child: Text(
            "\nThe newest addition to this on-demand segment is a milk delivery mobile app that enables the users to get milk and other dairy products right at their doorstep. Milk being the most important commodity of our life, can you even begin to imagine the scope of this idea\n\nMeeting your everyday morning needs like milk, eggs, butter, etc. effortlessly is the first thing that every individual looks forward to. And for those who are generally running late or are pressed for time, an on-demand milk delivery app can be the greatest blessing. With these apps, you can register yourself, set your location and daily requirements, and receive assured delivery at the chosen time every day. Isn’t it just so convenient? No more hassles of visiting your local vendor every day to buy fresh milk and milk products     rt about having your own milk delivery mobile app? Well, there is no need to worry about your target audience as every single person using the online platform is a potential customer.\n\n\n\n",
            style: poppinsStyle(FontWeight.w200, 16, black),
          ),
        ),
      ),
      backgroundColor: white,
    );
  }
}
