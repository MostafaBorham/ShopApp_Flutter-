import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/ShopCubit.dart';
import '../../Bloc/ShopStates.dart';
import '../../Models/UserLoginInfo.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/MySharedPreferences.dart';
import '../Login/LoginScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var formKey = GlobalKey<FormState>();
  UserLoginInfo? userInfo;
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ShopCubit.getInstance(context).getUserData();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessUpdateUserState) {
          if (state.userInfo.status!) {
            showToast(state.userInfo.message!, Colors.green);
          } else {
            showToast(state.userInfo.message!, Colors.red);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: userLoginInfo != null,
          builder: (context) {
            if (userLoginInfo!.data != null) {
              emailController.text = userLoginInfo!.data!.email!;
              nameController.text = userLoginInfo!.data!.name!;
              phoneController.text = userLoginInfo!.data!.phone!;
            }
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    buildTextFormField(
                        controller: nameController,
                        label: 'Name',
                        prefix: Icons.account_box_rounded,
                        inputType: TextInputType.name,
                        validatorFun: (value) {
                          if (value!.isEmpty) {
                            return 'Name is wrong';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextFormField(
                        controller: emailController,
                        label: 'Email',
                        prefix: Icons.email_outlined,
                        inputType: TextInputType.emailAddress,
                        validatorFun: (value) {
                          if (value!.isEmpty) {
                            return 'Email is wrong';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextFormField(
                        controller: phoneController,
                        label: 'Phone',
                        prefix: Icons.phone,
                        inputType: TextInputType.phone,
                        validatorFun: (value) {
                          if (value!.isEmpty) {
                            return 'Phone is too short';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    if (state is ShopLoadingState)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: LinearProgressIndicator(),
                      ),
                    buildLoginBtn(
                        text: 'Update',
                        function: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.getInstance(context).updateUser(
                                nameController.text,
                                emailController.text,
                                phoneController.text);
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    buildLoginBtn(
                        text: 'Logout',
                        function: () {
                          showMyDialog(context, () {
                            Navigator.of(context).pop();
                            MySharedPreferences.clearData(loginTokenKey)
                                .then((value) {
                              navigateNextScreenAndFinish(
                                  context, LoginScreen());
                            });
                          }).then((value) {});
                        }),
                  ],
                ),
              ),
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
