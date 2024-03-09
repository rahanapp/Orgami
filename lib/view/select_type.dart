import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:orgami/utils/colors.dart';
import 'package:orgami/view/modules/Admin/loginpage.dart';
import 'package:orgami/view/modules/Buyer/loginpage.dart';
import 'package:orgami/view/modules/Selller/loginpage.dart';
import 'package:orgami/view/widgets/custom_button.dart';
import 'package:orgami/view/widgets/custome_text.dart';

class SelectUserPage extends StatelessWidget {
  SelectUserPage({super.key});
  List<String> slides = [
    "assets/tab1.png",
    "assets/tab2.png",
    "assets/tab3.png",
  ];
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * .1,
          ),
          SizedBox(
            height: 400,
            child: CarouselSlider.builder(
              enableAutoSlider: true,
              unlimitedMode: true,
              autoSliderTransitionTime: const Duration(seconds: 1),
              itemCount: 3,
              scrollPhysics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
              autoSliderTransitionCurve: Curves.easeInOutCubic,
              slideBuilder: (index) => Image.asset(slides[index]),
              slideTransform: CubeTransform(),
              slideIndicator: CircularSlideIndicator(
                currentIndicatorColor: Colors.orange,
                indicatorBackgroundColor: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: height * .15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customeButton(
                  onpressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BuyerLoginPage()));
                  },
                  text: "Buyer",
                  textcolor: white,
                  buttonwidth: .4,
                  context: context,
                  bgColor: const MaterialStatePropertyAll(brown)),
              customeButton(
                  onpressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SellerLoginPage()));
                  },
                  text: "Seller",
                  textcolor: white,
                  buttonwidth: .4,
                  context: context,
                  bgColor: const MaterialStatePropertyAll(brown))
            ],
          ),
          SizedBox(
            height: height * .05,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AdminLoginPage()));
            },
            child: customeText(text: "Admin", textcolor: brown),
          )
        ],
      ),
    );
  }
}
