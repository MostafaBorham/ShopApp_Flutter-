// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/CategoryModel.dart';
import '../Models/FavoriteModel.dart';
import '../Models/HomeModel.dart';
import '../Models/SearchDataModel.dart';
import '../Models/UserLoginInfo.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/network/remote/DioHelper.dart';
import '../shared/network/remote/EndPoints.dart';
import 'ShopStates.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit getInstance(context) => BlocProvider.of(context);

  //////////////////////////////////////////////////////////////
  static IconData favoriteIcon = Icons.favorite_border;
  static bool is_Password_Secure = true;
  static IconData suffixIcon = Icons.visibility;
  static int bottomNavCurrentIndex = 0;
  /////////////////////////////////////////////////////////////
  void togglePassword() {
    is_Password_Secure = !is_Password_Secure;
    suffixIcon = is_Password_Secure ? Icons.visibility : Icons.visibility_off;
    emit(ShopTogglePasswordState());
  }

  void userLogin(String userEmail, String userPassword) {
    emit(ShopLoadingState());
    DioHelper.postData(LOGIN, data: {
      'email': userEmail,
      'password': userPassword,
    }).then((value) {
      emit(ShopSuccessLoginState(UserLoginInfo.fromJson(value.data)));
    }).catchError((onError) {
      emit(ShopFailLoginState());
    });
  }

  void userRegister(String userName, String userEmail, String userPhone,
      String userPassword) {
    emit(ShopLoadingState());
    DioHelper.postData(REGISTER, data: {
      'name': userName,
      'email': userEmail,
      'phone': userPhone,
      'password': userPassword,
    }).then((value) {
      emit(ShopSuccessRegisterState(UserLoginInfo.fromJson(value.data)));
    }).catchError((onError) {
      emit(ShopFailRegisterState());
    });
  }

  void changeBottomNavIndex(int index) {
    bottomNavCurrentIndex = index;
    emit(ShopChangeBottomNavIndexState());
  }

  void getProductData() {
    DioHelper.getData(url: HOME).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(ShopSuccessGetHomeDataState());
    }).catchError((onError) {});
  }

  void getCategoryData() {
    DioHelper.getData(url: CATEGORIES).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(ShopSuccessGetCategoriesDataState());
    }).catchError((onError) {});
  }

  void getFavouriteData() {
    DioHelper.getData(url: FAVORITES).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(ShopSuccessGetFavouritesDataState());
    }).catchError((onError) {
      favoriteModel =
          null; //لازم نفضى favorite Model لانها بتتملى فى حالة انه جاب داتا فى حالة نجاح عملية جلب المفضلات ولكن بعد ذلك يحدث استثناء فيطلعه من بلوك نجاح العملية الى بلوك هندلة الاستثناء
      emit(ShopFailGetFavouritesDataState());
    });
  }

  void getUserData() {
    DioHelper.getData(url: PROFILE).then((value) {
      userLoginInfo = UserLoginInfo.fromJson(value.data);
      emit(ShopSuccessGetUserDataState());
    }).catchError((onError) {});
  }

  void changeFavoriteIcon(ProductModel model) {
    DioHelper.postData(FAVORITES, data: {'product_id': model.id}).then((value) {
      model.inFavorites = !model.inFavorites;
      showToast(value.data['message'], Colors.green);
      favoriteModel = null;
      emit(ShopChangeFavoriteIconState());
    }).catchError((onError) {
      showToast('Error appear,please check internet connection', Colors.red);
    });
  }

  void removeFavoriteItem(FavoriteProductModel model) {
    DioHelper.postData(FAVORITES, data: {'product_id': model.product!.id})
        .then((value) {
      favoriteModel!.data!.data.remove(model);
      for (var element in homeModel!.data!.products) {
        if (element.id == model.product!.id) {
          element.inFavorites = false;
        }
      }
      showToast(value.data['message'], Colors.green);
      if (favoriteModel!.data!.data.isEmpty) {
        favoriteModel = null;
        emit(ShopEmptyFavoriteModelState());
      } else {
        emit(ShopRemoveFavoriteItemState());
      }
    }).catchError((onError) {
      showToast('Error appear,please check internet connection', Colors.red);
    });
  }

  void updateUser(String userName, String userEmail, String userPhone) {
    emit(ShopLoadingState());
    DioHelper.putData(UPDATE_PROFILE, data: {
      'name': userName,
      'email': userEmail,
      'phone': userPhone,
    }).then((value) {
      userLoginInfo = UserLoginInfo.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userLoginInfo!));
    }).catchError((onError) {
      emit(ShopFailUpdateUserState());
    });
  }

  void searchInProducts(String keyword) {
    emit(ShopLoadingState());
    DioHelper.postData(PRODUCTS_SEARCH, data: {'text': keyword}).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSuccessGetSearchDataState());
    }).catchError((onError) {
      emit(ShopFailGetSearchDataState());
    });
  }
}
