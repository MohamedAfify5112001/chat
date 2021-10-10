import 'package:chat/layouts/layout_cubit/social_cubit.dart';
import 'package:chat/layouts/layout_cubit/social_states.dart';
import 'package:chat/screens/post/create_post.dart';
import 'package:chat/shared/components/components.dart';
import 'package:chat/shared/styles/icon_fonts.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatLayout extends StatelessWidget {
  bool verify = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is CreatePostBottomNavigationBar){
          navigateTo(context, SocialCreatePostScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Search),
                iconSize: 25.0,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Notification),
                iconSize: 25.0,
              ),
            ],
            title: Text(
                SocialCubit.get(context)
                    .titles[SocialCubit.get(context).currentIndex],
                style: Theme.of(context).textTheme.headline2),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).userModel != null,
            builder: (context) => SocialCubit.get(context)
                .screens[SocialCubit.get(context).currentIndex],
            fallback: (context) => Center(
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const LinearProgressIndicator())),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: SocialCubit.get(context).currentIndex,
            onTap: (index) {
              SocialCubit.get(context).changeBetweenScreens(index);
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                    size: 30.0,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Message,
                    size: 30.0,
                  ),
                  label: "Chats"),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Paper_Upload,
                    size: 30.0,
                  ),
                  label: "Post"),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.User,
                    size: 30.0,
                  ),
                  label: "Users"),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Setting,
                    size: 30.0,
                  ),
                  label: "Settings"),
            ],
          ),
        );
      },
    );
  }
}
