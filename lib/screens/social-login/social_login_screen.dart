import 'package:chat/layouts/chat_layout.dart';
import 'package:chat/network/cache_helper.dart';
import 'package:chat/screens/social-login/cubit-login/cubit_login.dart';
import 'package:chat/screens/social-login/cubit-login/states_login.dart';
import 'package:chat/screens/social-register/social_register.dart';
import 'package:chat/shared/components/components.dart';
import 'package:chat/shared/components/constants.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final String login = "Login";
  final String welcome = "Login now to communicate with friends";
  final String haveAccount = "Don\'t have an account?";
  final String register = "Register";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is SuccessLoginState) {
              showTopSnackBar(
                context,
                const CustomSnackBar.success(
                  message: "Login operation Success",
                  backgroundColor: Color.fromRGBO(10, 210, 10, 1.0),
                  textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              );
              CacheHelper.putData(key: 'uId', value: state.uId).then((value) {
                pushAndRemoveUntilPageTo(context, ChatLayout());
              });
            }
            if (state is ErrorLoginState) {
              showTopSnackBar(
                context,
                const CustomSnackBar.error(
                  message: "This Credential does\'t exist",
                  backgroundColor: Color.fromRGBO(200, 10, 10, 1.0),
                  textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          login.toUpperCase(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline1,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          welcome,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        buildTextFormField(
                            label: "Email",
                            prefixIcon: Icons.email,
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your email";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 25.0,
                        ),
                        buildTextFormField(
                            label: "Password",
                            isSecure: LoginCubit
                                .get(context)
                                .isSecure,
                            prefixIcon: Icons.lock,
                            controller: passwordController,
                            suffixIcon: LoginCubit
                                .get(context)
                                .icon,
                            onPressedSuffix: () {
                              LoginCubit.get(context).changeSecure();
                            },
                            type: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your password";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 28.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoadingLoginState,
                          fallback: (context) =>
                          const LinearProgressIndicator(
                            color: mainColor,
                          ),
                          builder: (context) =>
                              buildMaterialButton(context,
                                  label: login,
                                  width: double.infinity,
                                  color: Colors.white, onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userSignIn(
                                          email: emailController.text,
                                          password: passwordController.text
                                      );
                                    }
                                  }),
                        ),
                        const SizedBox(
                          height: 28.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              haveAccount,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.grey),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            TextButton(
                                onPressed: () {
                                  pushAndRemoveUntilPageTo(
                                      context, SocialRegisterScreen());
                                },
                                child: Text(register.toUpperCase()))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
