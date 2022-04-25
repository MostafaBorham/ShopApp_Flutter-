// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/ShopCubit.dart';
import '../../Bloc/ShopStates.dart';
import '../../Layouts/HomeLayout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/MySharedPreferences.dart';
import '../../shared/network/remote/DioHelper.dart';
import '../Register/RegisterScreen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessLoginState) {
          if (state.userInfo.status!) {
            MySharedPreferences.saveData(
                    loginTokenKey, state.userInfo.data!.token)
                .then((value) {
              DioHelper.initShopApp('en', state.userInfo.data!.token);
              ShopCubit.bottomNavCurrentIndex = 0;
              showToast(state.userInfo.message!, Colors.green);
              navigateNextScreenAndFinish(context, const HomeLayout());
            });
          } else {
            showToast(
              state.userInfo.message!,
              Colors.red,
            );
          }
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Login to ShopApp for explore our hot offers',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    buildTextFormField(
                        controller: emailController,
                        label: 'Email',
                        prefix: Icons.email_outlined,
                        inputType: TextInputType.emailAddress,
                        validatorFun: (input) {
                          if (input!.isEmpty) {
                            return 'email should be fill !';
                          } else if (input.length < 13) {
                            return 'email is too short !';
                          } else if (!input.endsWith('@gmail.com')) {
                            return 'email format is false !';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    buildTextFormField(
                        controller: passwordController,
                        label: 'Password',
                        prefix: Icons.lock_outline,
                        inputType: TextInputType.visiblePassword,
                        obscureText: ShopCubit.is_Password_Secure,
                        suffix: ShopCubit.suffixIcon,
                        suffixFun: () {
                          ShopCubit.getInstance(context).togglePassword();
                        },
                        validatorFun: (input) {
                          if (input!.isEmpty) {
                            return 'password should be fill !';
                          } else if (input.length < 6) {
                            return 'password is too short !';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 50,
                    ),
                    ConditionalBuilder(
                      condition: state is! ShopLoadingState,
                      builder: (context) => buildLoginBtn(function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.getInstance(context).userLogin(
                              emailController.text, passwordController.text);
                        }
                      }),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account ?'),
                        TextButton(
                            onPressed: () => navigateNextScreenAndFinish(
                                context, RegisterScreen()),
                            child: const Text(
                              'Register Now',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
