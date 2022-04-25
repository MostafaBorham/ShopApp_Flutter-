import '../Models/UserLoginInfo.dart';

abstract class ShopStates {}

//////////////////////////////////////////////////////////////////////////////
class ShopInitialState extends ShopStates {}

class ShopTogglePasswordState extends ShopStates {}

class ShopLoadingState extends ShopStates {}

class ShopSuccessLoginState extends ShopStates {
  UserLoginInfo userInfo;
  ShopSuccessLoginState(this.userInfo);
}

class ShopSuccessRegisterState extends ShopStates {
  UserLoginInfo userInfo;
  ShopSuccessRegisterState(this.userInfo);
}

class ShopSuccessUpdateUserState extends ShopStates {
  UserLoginInfo userInfo;
  ShopSuccessUpdateUserState(this.userInfo);
}

class ShopSuccessGetHomeDataState extends ShopStates {}

class ShopSuccessGetSearchDataState extends ShopStates {}

class ShopFailGetSearchDataState extends ShopStates {}

class ShopSuccessGetCategoriesDataState extends ShopStates {}

class ShopSuccessGetFavouritesDataState extends ShopStates {}

class ShopFailGetFavouritesDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {}

class ShopFailLoginState extends ShopStates {}

class ShopFailRegisterState extends ShopStates {}

class ShopFailUpdateUserState extends ShopStates {}

class ShopChangeBottomNavIndexState extends ShopStates {}

class ShopChangeFavoriteIconState extends ShopStates {}

class ShopRemoveFavoriteItemState extends ShopStates {}

class ShopEmptyFavoriteModelState extends ShopStates {}
//////////////////////////////////////////////////////////////////
