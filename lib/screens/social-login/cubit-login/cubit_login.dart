import 'package:chat/screens/social-login/cubit-login/states_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isSecure = true;
  IconData icon = Icons.visibility;

  void changeSecure() {
    isSecure = !isSecure;
    icon = (isSecure) ? Icons.visibility : Icons.visibility_off_rounded;
    emit(ChangeSecurePassword());
  }

  void userSignIn({required String email, required String password}) {
    emit(LoadingLoginState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      print(value.user!.uid);
      print(value.user!.email);
      emit(SuccessLoginState(uId: value.user!.uid));
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorLoginState(message: onError.toString()));
    });
  }
}
