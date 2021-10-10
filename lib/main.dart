import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat/layouts/chat_layout.dart';
import 'package:chat/layouts/layout_cubit/social_cubit.dart';
import 'package:chat/models/setup_theme.dart';
import 'package:chat/network/cache_helper.dart';
import 'package:chat/screens/social-login/social_login_screen.dart';
import 'package:chat/shared/bloc_observer.dart';
import 'package:chat/shared/components/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("On Back");
  print(message.data.toString());
  Fluttertoast.showToast(
      msg: "On background message",
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      fontSize: 30.0
  );
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print("On App");
    print(event.data.toString());
    Fluttertoast.showToast(
        msg: "On message",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print("On open App");
    print(event.data.toString());
    Fluttertoast.showToast(
        msg: "On open app",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await CacheHelper.initSharedPreferences();
  Bloc.observer = SimpleBlocObserver();
  Widget? widget;
  uId = CacheHelper.get(key: 'uId');
  if (uId == null) {
    widget = SocialLoginScreen();
  } else {
    widget = ChatLayout();
  }
  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  MyApp({required this.widget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUsers()
              ..getAllPosts()
              ..getAllUsers())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: SetupThemes.lightTheme(),
        home: widget,
      ),
    );
  }
}
