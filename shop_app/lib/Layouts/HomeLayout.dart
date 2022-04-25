import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../Bloc/ShopCubit.dart';
import '../Bloc/ShopStates.dart';
import '../Modules/Categories/CategoriesScreen.dart';
import '../Modules/Favourite/FavouriteScreen.dart';
import '../Modules/Home/HomeScreen.dart';
import '../Modules/Login/LoginScreen.dart';
import '../Modules/Search/SearchScreen.dart';
import '../Modules/Settings/SettingsScreen.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/network/local/MySharedPreferences.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  ///////////////////////////////////////////////////////////////////////////////////////
  List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(icon: Icon(homeIcon), label: homeLabel),
    const BottomNavigationBarItem(
        icon: Icon(categoriesIcon), label: categoriesLabel),
    const BottomNavigationBarItem(icon: Icon(favIcon), label: favLabel),
    const BottomNavigationBarItem(
        icon: Icon(settingsIcon), label: settingsLabel),
  ];
  List<Widget> homeLayoutScreens = [
    HomeScreen(),
    const CategoriesScreen(),
    FavouriteScreen(),
    const SettingsScreen()
  ];
  List<String> appBarTitles = [
    homeLabel,
    categoriesLabel,
    favLabel,
    settingsLabel,
  ];
  List<IconData> appBarIcons = [
    homeIcon,
    categoriesIcon,
    favIcon,
    settingsIcon,
  ];
  ////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    cubit = ShopCubit.getInstance(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: Icon(appBarIcons[ShopCubit.bottomNavCurrentIndex]),
          title: Text(appBarTitles[ShopCubit.bottomNavCurrentIndex]),
          titleSpacing: 0,
          actions: [
            IconButton(
                onPressed: () {
                  navigateNextScreen(context, SearchScreen());
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () async {
                  bool result = await InternetConnectionChecker().hasConnection;
                  if (result == true) {
                    showMyDialog(context, () {
                      Navigator.of(context).pop();
                      MySharedPreferences.clearData(loginTokenKey)
                          .then((value) {
                        navigateNextScreenAndFinish(context, LoginScreen());
                      });
                    });
                  } else {
                    showToast(NO_INTERNET_NOTIFICATION, Colors.red);
                  }
                },
                icon: const Icon(Icons.logout)),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavItems,
          onTap: (index) {
            cubit!.changeBottomNavIndex(index);
          },
          currentIndex: ShopCubit.bottomNavCurrentIndex,
        ),
        body: homeLayoutScreens[ShopCubit.bottomNavCurrentIndex],
      ),
    );
  }
}
