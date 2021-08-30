//@dart=2.9

import 'package:shop_app/models/shop_app/change_favourites_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';

abstract class ShopAppStates {}

class ShopAppInitialState extends ShopAppStates {}

class ShopAppChangeBottomNavState extends ShopAppStates {}

class ShopAppLoadingHomeDataState extends ShopAppStates {}

class ShopAppSuccessHomeDataState extends ShopAppStates {}

class ShopAppErrorHomeDataState extends ShopAppStates {}

class ShopAppSuccessCategoriesState extends ShopAppStates {}

class ShopAppErrorCategoriesState extends ShopAppStates {}

class ShopAppSuccessChangeFavoritesState extends ShopAppStates {
   ChangeFavoritesModel model;

  ShopAppSuccessChangeFavoritesState(this.model);
}

class ShopAppErrorChangeFavouritesState extends ShopAppStates {}

class ShopAppChangeFavouritesState extends ShopAppStates {}

class ShopAppLoadingGetFavoritesState extends ShopAppStates {}

class ShopAppSuccessGetFavoritesState extends ShopAppStates {}

class ShopAppErrorGetFavoritesState extends ShopAppStates {}

class ShopAppLoadingUserDataState extends ShopAppStates {}

class ShopAppSuccessUserDataState extends ShopAppStates {
   ShopLoginModel loginModel;

  ShopAppSuccessUserDataState(this.loginModel);
}

class ShopAppErrorUserDataState extends ShopAppStates {}

class ShopAppLoadingUpdateUserState extends ShopAppStates {}

class ShopAppSuccessUpdateUserState extends ShopAppStates {
   ShopLoginModel loginModel;

  ShopAppSuccessUpdateUserState(this.loginModel);
}

class ShopAppErrorUpdateUserState extends ShopAppStates {}
