import 'package:chat/models/user_model.dart';
import 'package:chat/screens/social-register/cubit-register/states_register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void registerUser(
      {required String email,
      required String username,
      required String password,
      required String phone}) {
    emit(LoadingRegisterState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      UserModel model = UserModel(
          email: email,
          username: username,
          phone: phone ,
          uId: value.user!.uid ,
          image: "https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg",
          cover: "https://image.freepik.com/free-photo/top-view-background-beautiful-white-grey-brown-cream-blue-background_140725-72219.jpg",
          bio: "write your bio..."
      );
      createUser(model.toMap());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorRegisterState());
    });
  }

  void createUser(Map <String , dynamic> fromDatabase){
    FirebaseFirestore.instance.collection("users").doc(fromDatabase['uId']).set(
        fromDatabase,
    ).then(
        (value){

          emit(SuccessCreateUserState());
        }
    ).catchError((onError){
      print(onError.toString());
      emit(ErrorCreateUserState());
    });
  }
  bool isSecure = true;
  IconData icon =  Icons.visibility;
  void changeSecure(){
    isSecure  = !isSecure;
    icon =  (isSecure) ? Icons.visibility : Icons.visibility_off_rounded;
    emit(ChangeSecurePassword());
  }
}
