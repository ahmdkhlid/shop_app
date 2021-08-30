//@dart=2.9
import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
   final String image;
   final String title;
   final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final boardController = PageController();

  final List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboarding_1.jpg',
      title: 'OnBoarding 1 Title',
      body: 'OnBoarding 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboarding_1.jpg',
      title: 'OnBoarding 2 Title',
      body: 'OnBoarding 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboarding_1.jpg',
      title: 'OnBoarding 3 Title',
      body: 'OnBoarding 3 Body',
    ),
  ];
  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: () {
                submit();
              },
              text: 'skip',style: Theme.of(context).textTheme.headline6.copyWith(color:defaultColor,),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    expansionFactor: 4,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      );
}
