import 'package:chat/layouts/layout_cubit/social_cubit.dart';
import 'package:chat/layouts/layout_cubit/social_states.dart';
import 'package:chat/shared/components/components.dart';
import 'package:chat/shared/components/constants.dart';
import 'package:chat/shared/styles/icon_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SocialUpdateUserDataScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      if (state is SuccessPickedProfileImageSuccess) {
        SocialCubit.get(context).uploadProfileImage(
            username: nameController.text,
            bio: bioController.text,
            phone: phoneController.text);
      }
      if (state is SuccessPickedCoverImageSuccess) {
        SocialCubit.get(context).uploadCoverImage(
            username: nameController.text,
            bio: bioController.text,
            phone: phoneController.text);
      }
    }, builder: (context, state) {
      var cubit = SocialCubit.get(context).userModel;
      var profileImage = SocialCubit.get(context).profileImage;
      var coverImage = SocialCubit.get(context).coverImage;

      nameController.text = "${cubit!.username}";
      bioController.text = "${cubit.bio}";
      phoneController.text = "${cubit.phone}";
      return Scaffold(
        appBar: buildDefaultAppBar(
          context: context,
          title: "Edit Profile",
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconBroken.Arrow___Left_2)),
        ), //AppBar
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildProfileCoverAndImage(
                  context, cubit, profileImage, coverImage),
              const SizedBox(
                height: 70.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildTextFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      label: "Username",
                      prefixIcon: IconBroken.User,
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    buildTextFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      label: "Write your bio",
                      prefixIcon: IconBroken.Info_Square,
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    buildTextFormField(
                      controller: phoneController,
                      type: TextInputType.text,
                      label: "Phone",
                      prefixIcon: IconBroken.Call,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        SocialCubit.get(context).updateUserData(
                            username: nameController.text,
                            bio: bioController.text,
                            phone: phoneController.text
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                         vertical: 15.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            const Icon(
                              IconBroken.Edit,
                              size: 30.0,
                            ),
                            const SizedBox(width: 15.0,),
                            Text(
                              "Update Changes",
                              style: Theme.of(context).textTheme.headline3!.copyWith(
                                color: mainColor,
                                fontSize: 22.0
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildProfileCoverAndImage(
      BuildContext context, cubit, profileImage, coverImage) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 230.0,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: (coverImage == null)
                ? NetworkImage("${cubit!.cover}")
                : FileImage(coverImage) as ImageProvider,
          )),
        ),
        Transform.translate(
          offset: const Offset(0.0, 120.0),
          child: Center(
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  radius: 82.0,
                  child: CircleAvatar(
                    radius: 77.0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    backgroundImage: (profileImage == null)
                        ? NetworkImage("${cubit.image}")
                        : FileImage(profileImage) as ImageProvider,
                  ),
                ),
                CircleAvatar(
                  radius: 23.0,
                  backgroundColor: Colors.grey[100],
                  child: IconButton(
                      onPressed: () {
                        SocialCubit.get(context).getProfileImage();
                      },
                      icon: const Icon(
                        IconBroken.Camera,
                        size: 30.0,
                      )),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 8.0,
          right: 8.0,
          child: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.white.withOpacity(.4),
            child: IconButton(
              onPressed: () {
                SocialCubit.get(context).getCoverImage();
              },
              icon: const Icon(
                IconBroken.Camera,
                size: 32.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
