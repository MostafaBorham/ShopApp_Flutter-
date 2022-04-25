// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/BlocObserverTest.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/MySharedPreferences.dart';
import 'package:shop_app/shared/styles/styles.dart';

import 'Bloc/ShopCubit.dart';
import 'Bloc/ShopStates.dart';
import 'Layouts/HomeLayout.dart';
import 'Modules/Login/LoginScreen.dart';
import 'Modules/OnBoarding/OnBoardingScreen.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding
          .ensureInitialized(); //بتضمن ان الكود اللى بعدها يتنفذ اولا قبل تشغيل التطبيق
      await preInitRunApp();
      runApp(MyApp(MySharedPreferences.retreiveData(onBoardingKey) ?? false,
          currentUserToken ?? ''));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  bool isBoardingSkip;
  String? userToken;
  MyApp(this.isBoardingSkip, this.userToken, {Key? key}) : super(key: key) {
    homeApp = isBoardingSkip
        ? (userToken!.isEmpty ? LoginScreen() : const HomeLayout())
        : const OnBoardingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              home: homeApp,
              debugShowCheckedModeBanner: false,
              theme: appLightTheme,
            );
          }),
    ); //الماتريال اب هى اللى شايله كل سكرينات التطبيق بمعنى اصح هى تعتبر الاكتيفتيز ستاك وايضا من خلال نقدر نضع اعدادات وستايل للتطبيق كله
  }
}
