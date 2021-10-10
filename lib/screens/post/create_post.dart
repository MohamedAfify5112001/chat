import 'dart:io';
import 'package:chat/layouts/layout_cubit/social_cubit.dart';
import 'package:chat/layouts/layout_cubit/social_states.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/shared/components/components.dart';
import 'package:chat/shared/components/constants.dart';
import 'package:chat/shared/styles/icon_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SocialCreatePostScreen extends StatelessWidget {
  var postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SuccessCreatePost) {
          showTopSnackBar(
            context,
            const CustomSnackBar.success(
              message: "Post is Shared",
              backgroundColor: Color.fromRGBO(10, 210, 10, 1.0),
              textStyle: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
          );
          Navigator.pop(context);
          SocialCubit.get(context).removePostImage();
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: buildDefaultAppBar(
              context: context,
              title: "Create Post",
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(IconBroken.Arrow___Left_2)),
              actions: [
                TextButton(
                    onPressed: () {
                      var datetime = DateTime.now();
                      if (SocialCubit.get(context).postImage != null) {
                        SocialCubit.get(context).uploadPostWithImage(
                            text: postController.text,
                            datetime: datetime.toString());
                      } else {
                        SocialCubit.get(context).createPost(
                            text: postController.text,
                            datetime: datetime.toString());
                      }
                    },
                    child: Text(
                      "Post",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: mainColor, fontSize: 18.0),
                    )),
                const SizedBox(
                  width: 10.0,
                ),
              ]), //AppBar
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
            child: Column(
              children: [
                _buildAuthorCard(context, cubit!),
                const SizedBox(
                  height: 7.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: const InputDecoration(
                        hintText: "What is on your mind....",
                        border: InputBorder.none),
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 230.0,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6.0)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(SocialCubit.get(context)
                                    .postImage as File))),
                      ),
                      Positioned(
                        right: 10.0,
                        top: 5.0,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(.4),
                          child: IconButton(
                              onPressed: () {
                                SocialCubit.get(context).removePostImage();
                              },
                              icon: Icon(
                                Icons.close,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              )),
                        ),
                      )
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        SocialCubit.get(context).getPostImage();
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.photo,
                            size: 26.0,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Add Photo",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: mainColor, fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "# Tags",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: mainColor, fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAuthorCard(BuildContext context, UserModel cubit) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage('${cubit.image}'),
        ),
        const SizedBox(
          width: 7.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "${cubit.username}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
