// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Bloc/ShopCubit.dart';

import '../../Bloc/ShopStates.dart';
import '../../Layouts/HomeLayout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/MySharedPreferences.dart';
import '../../shared/network/remote/DioHelper.dart';
import '../Login/LoginScreen.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessRegisterState) {
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
            showToast(state.userInfo.message!, Colors.red);
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
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Sign up to ShopApp for explore our hot offers',
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
                        controller: nameController,
                        label: 'Name',
                        prefix: Icons.person,
                        inputType: TextInputType.name,
                        validatorFun: (input) {
                          if (input!.isEmpty) {
                            return 'name should be fill !';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    buildTextFormField(
                        controller: emailController,
                        label: 'Email',
                        prefix: Icons.email_outlined,
                        inputType: TextInputType.emailAddress,
                        validatorFun: (input) {
                          if (input!.isEmpty) {
                            return 'email should be fill !';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    buildTextFormField(
                        controller: phoneController,
                        label: 'Phone',
                        prefix: Icons.phone,
                        inputType: TextInputType.phone,
                        validatorFun: (input) {
                          if (input!.isEmpty) {
                            return 'phone should be fill !';
                          } else if (input.length < 11) {
                            return 'phone is too short !';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
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
                      builder: (context) => buildLoginBtn(
                          text: 'Sign Up',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.getInstance(context).userRegister(
                                  nameController.text,
                                  emailController.text,
                                  phoneController.text,
                                  passwordController.text);
                            }
                          }),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account ?'),
                        TextButton(
                            onPressed: () => navigateNextScreenAndFinish(
                                context, LoginScreen()),
                            child: const Text(
                              'Login Now',
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
