// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'package:flutter/material.dart';

import '../../Bloc/ShopCubit.dart';
import '../../Models/CategoryModel.dart';
import '../../Models/FavoriteModel.dart';
import '../../Models/HomeModel.dart';
import '../../Models/SearchDataModel.dart';
import '../../Models/UserLoginInfo.dart';
import '../../Modules/OnBoarding/OnBoardingScreen.dart';
import '../network/local/MySharedPreferences.dart';
import '../network/remote/DioHelper.dart';

///////////////////////////////////////////////////////////////variables
Widget homeApp = const OnBoardingScreen();
String AppLanguage = 'en';
const String AppModeSharedPrefKey = 'isDarkMode';
String NO_INTERNET_NOTIFICATION = 'No Internet Connection :(';
dynamic currentUserToken;
bool isTasksEmpty = false;
String onBoardingKey = 'is BoardingScreen Skip';
String loginTokenKey = 'User Login Token';
const String homeLabel = 'Home';
const String categoriesLabel = 'Categories';
const String favLabel = 'Favourite';
const String settingsLabel = 'Settings';
const IconData homeIcon = Icons.home;
const IconData categoriesIcon = Icons.apps;
const IconData favIcon = Icons.favorite;
const IconData settingsIcon = Icons.settings;
HomeModel? homeModel;
CategoryModel? categoryModel;
FavoriteModel? favoriteModel;
UserLoginInfo? userLoginInfo;
SearchModel? searchModel;
ShopCubit? cubit;
/////////////////////////////////////////////Lists
List<Map> newTasks = [];
List<Map> doneTasks = [];
List<Map> archivedTasks = [];
List<List<Map>> allTasksTypeList = [
  newTasks,
  doneTasks,
  archivedTasks,
];
List<dynamic> businessNews = [];
List<dynamic> sportsNews = [];
List<dynamic> sciencesNews = [];
List<dynamic> allFilteredNews = [];
//////////////////////////////////////////////Functions
Future<void> preInitRunApp() async {
  await MySharedPreferences.init();
  DioHelper.initShopApp(
      'en', currentUserToken = MySharedPreferences.retreiveData(loginTokenKey));
}
