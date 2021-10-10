import 'package:chat/layouts/chat_layout.dart';
import 'package:chat/screens/social-register/cubit-register/cubit_register.dart';
import 'package:chat/screens/social-register/cubit-register/states_register.dart';
import 'package:chat/shared/components/components.dart';
import 'package:chat/shared/components/constants.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final String register = "Register";
  final String communicate = "Register now to communicate with friends";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is SuccessCreateUserState) {
            showTopSnackBar(
              context,
              const CustomSnackBar.success(
                message: "Register operation Success",
                backgroundColor: Color.fromRGBO(10, 210, 10, 1.0),
                textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            );
            pushAndRemoveUntilPageTo(context, ChatLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          register.toUpperCase(),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          communicate,
                          style: Theme.of(context)
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
                            label: "Username ",
                            prefixIcon: Icons.person,
                            controller: nameController,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your name";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 25.0,
                        ),
                        buildTextFormField(
                            label: "Password",
                            prefixIcon: Icons.lock,
                            isSecure: RegisterCubit.get(context).isSecure,
                            controller: passwordController,
                            suffixIcon: RegisterCubit.get(context).icon,
                            onPressedSuffix: () {
                              RegisterCubit.get(context).changeSecure();
                            },
                            type: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your password";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 25.0,
                        ),
                        buildTextFormField(
                            label: "Phone",
                            prefixIcon: Icons.phone,
                            controller: phoneController,
                            type: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your phone";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 28.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoadingRegisterState,
                          fallback: (context) => const Center(
                            child: LinearProgressIndicator(
                              color: mainColor,
                            ),
                          ),
                          builder: (context) => buildMaterialButton(context,
                              label: register,
                              width: double.infinity,
                              color: Colors.white, onPressed: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).registerUser(
                                  email: emailController.text,
                                  username: nameController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text);
                            }
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
