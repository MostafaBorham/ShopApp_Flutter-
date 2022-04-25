import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Models/BoardModel.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/MySharedPreferences.dart';
import '../../shared/styles/colors.dart';
import '../Login/LoginScreen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  List<BoardModel> boardModelList = [
    BoardModel('assets/images/shopAppBoardingImgShopping.jpg', 'Shopping',
        'explore various types of products with high quality and best price'),
    BoardModel('assets/images/shopAppBoardingImgCommerce.jpg', 'Commerce',
        'explore our shop service and all offers for easy and fun shopping'),
    BoardModel('assets/images/shopAppBoardingImgBanking.jpg', 'Banking',
        'we save more pay methods over prepaid card , visa , paypal or banking accounts'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submitSkip();
            },
            child: const Text('SKIP'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildBoardingItem(boardModelList[index]),
                itemCount: boardModelList.length,
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (index) {
                  if (index == boardModelList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SafeArea(
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boardModelList.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: appColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 20,
                      expansionFactor: 2,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submitSkip();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

///////////////////////////////////////////////////////////////////////////Helper Methods
  Widget buildBoardingItem(BoardModel model) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            width: 300,
            child: Image(
              image: AssetImage(model.img),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            model.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.body,
            style: const TextStyle(height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      );
  void submitSkip() {
    MySharedPreferences.saveData(onBoardingKey, true).then((value) {
      navigateNextScreenAndFinish(context, LoginScreen());
    });
  }
  /////////////////////////////////////////////////////////////////////////
}
