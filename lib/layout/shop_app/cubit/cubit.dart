//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/change_favourites_model.dart';
import 'package:shop_app/models/shop_app/favorites_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/shop_app/categories/categories_screen.dart';
import 'package:shop_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:shop_app/modules/shop_app/products/products_screen.dart';
import 'package:shop_app/modules/shop_app/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.apps_outlined), label: 'Products'),
    BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined), label: 'Categories'),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border_outlined), label: 'Favourites'),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings_outlined), label: 'Settings'),
  ];
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopAppChangeBottomNavState());
  }

  HomeModel homeModel;
  ShopLoginModel loginModel;
  Map<int, bool> favorites = {};

  void getHomeData() {

    print(token);

    emit(ShopAppLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      // printFullText(homeModel.toString());
      emit(ShopAppSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopAppErrorHomeDataState());
      print('error');
      print(error.toString());
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopAppSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorCategoriesState());
    });
  }

  ChangeFavoritesModel changeFavouritesModel;

  void changeFavourites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopAppChangeFavouritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavouritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavouritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavourites();
      }
      emit(ShopAppSuccessChangeFavoritesState(changeFavouritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];

      emit(ShopAppErrorChangeFavouritesState());
      print(error.toString());
    });
  }

  FavoritesModel favoritesModel;

  void getFavourites() {
    emit(ShopAppLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopAppSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorGetFavoritesState());
    });
  }

  ShopLoginModel userModel;

  void getUserData() {
    emit(ShopAppLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
print(userModel.status);
print(userModel.message);
      emit(ShopAppSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorUserDataState());
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopAppLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);


      emit(ShopAppSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorUpdateUserState());
    });
  }
}
