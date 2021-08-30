//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/search_screen.dart';
import 'package:shop_app/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';


class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            titleSpacing: 10.0,
            title: Text(
              'Salla',
              style: TextStyle(
                color: defaultColor,
                fontSize: 34.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w800,
                fontFamily: 'Aladin',
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  navigateTo(
                    context,
                    SearchScreen(),
                  );
                },
              ),
              SizedBox(
                width: 0.0,
              ),
              TextButton(
                child: Text(
                  'logout',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.black45),
                ),
                onPressed: () {
                  navigateTo(
                    context,
                    ShopLoginScreen(),
                  );
                },
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
