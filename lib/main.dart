// @dart=2.9
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


import 'layout/shop_app/cubit/cubit.dart';
import 'layout/shop_app/cubit/states.dart';
import 'layout/shop_app/shop_layout.dart';
import 'modules/shop_app/onboarding_screen/onboarding_screen.dart';
import 'modules/shop_app/shop_login/shop_login_screen.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/styles/themes.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else
    widget = OnBoardingScreen();

  runApp(
    MyApp(
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

          create: (BuildContext context) => ShopAppCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavourites()
            ..getUserData(),


      child: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            title: 'Flutter ',
            themeMode: ThemeMode.light,
            home: ShopLoginScreen(),
          );
        },
      ),
    );
  }
}
