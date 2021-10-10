import 'package:chat/layouts/layout_cubit/social_cubit.dart';
import 'package:chat/layouts/layout_cubit/social_states.dart';
import 'package:chat/screens/update/update_screen.dart';
import 'package:chat/shared/components/components.dart';
import 'package:chat/shared/styles/icon_fonts.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialSettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit , SocialStates>(
      listener:  (context , state){},
      builder: (context , state){
        var cubit = SocialCubit.get(context).userModel;
        return ConditionalBuilder(
          condition: cubit!.cover != null && cubit.image != null,
          builder: (context) => Column(
            children:
            [
              _buildProfileCoverAndImage(context , cubit),
              const SizedBox(height: 55.0,),
              _buildProfileDetails(context , cubit),
              const SizedBox(height: 10.0,),
              _buildCommunicationsSocialMedia(context),
              const SizedBox(height: 15,),
              _buildCountingReactionsWithProfile(context , cubit),
              const SizedBox(height:22.0,),
              _buildMoreOptions(context),
            ],
          ),
          fallback:(context) => const Center(child: CircularProgressIndicator()),
        );
      }
    );
  }
  Widget _buildProfileCoverAndImage(BuildContext context , cubit){
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          height: 230.0,
          decoration:  BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${cubit!.cover}")
              )
          ),
        ),
        Transform.translate(
          offset: const Offset(0.0 , 53.0),
          child: Center(
            child: CircleAvatar(
              backgroundColor:Theme.of(context).scaffoldBackgroundColor,
              radius: 82.0,
              child: CircleAvatar(
                radius: 77.0,
                backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                backgroundImage: NetworkImage("${cubit.image}"),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildProfileDetails(BuildContext context , cubit){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:
      [
        Text(
          "${cubit!.username}",
          style: Theme.of(context).textTheme.headline3!.copyWith(
              fontSize: 20.0
          ),
        ),
        const SizedBox(height: 4.0,),
        Text(
          "${cubit.bio}",
          style: Theme.of(context).textTheme.headline3!.copyWith(
              fontSize: 10.0,
              color: Colors.grey
          ),
        ),
      ],
    );
  }
  Widget _buildCommunicationsSocialMedia(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      [
        CircleAvatar(
          backgroundColor: Colors.grey[100],
          radius: 25.0,
          child: const Image(
            image: AssetImage("assets/images/facebook-social-logo.png"),
            fit: BoxFit.cover,
            width: 32.0,
          ),
        ),
        const SizedBox(width: 7.0,),
        CircleAvatar(
          backgroundColor: Colors.grey[100],
          radius: 25.0,
          child: const Image(
            image: AssetImage("assets/images/linkedin.png"),
            fit: BoxFit.cover,
            width: 32.0,
          ),
        ),
        const SizedBox(width: 7.0,),
        CircleAvatar(
          backgroundColor: Colors.grey[100],
          radius: 25.0,
          child: const Image(
            image: AssetImage("assets/images/whatsapp.png"),
            fit: BoxFit.cover,
            width: 32.0,
          ),
        ),
        const SizedBox(width: 7.0,),
        CircleAvatar(
          backgroundColor: Colors.grey[100],
          radius: 25.0,
          child: const Image(
            image: AssetImage("assets/images/instagram.png"),
            fit: BoxFit.cover,
            width: 32.0,
          ),
        ),
      ],
    );
  }
  Widget _buildCountingReactionsWithProfile(BuildContext context , cubit){
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 14.0),
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children:
          [
            Expanded(
              child: InkWell(
                onTap: (){},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                  [
                    Text(
                      "Post",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 18.0
                      ),
                    ),
                    const SizedBox(height: 5.0,),
                    Text(
                      "120K",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 14.0,
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (){},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                  [
                    Text(
                      "Followers",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 18.0
                      ),
                    ),
                    const SizedBox(height: 5.0,),
                    Text(
                      "10K",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 14.0,
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (){},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                  [
                    Text(
                      "Friends",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 18.0
                      ),
                    ),
                    const SizedBox(height: 5.0,),
                    Text(
                      "1K",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 14.0,
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: (){},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                  [
                    Text(
                      "Loves",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 18.0
                      ),
                    ),
                    const SizedBox(height: 5.0,),
                    Text(
                      "2K",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 14.0,
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildMoreOptions(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Row(
        children:
        [
          Expanded(
            child: OutlinedButton(
              onPressed: (){},
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    const Icon(
                      IconBroken.Plus,
                    ),
                    const SizedBox(width: 7.0,),
                    Text(
                      "Add Photos",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 18.0,
                          color: Colors.grey[700]
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 5.0,),
          OutlinedButton(
              onPressed: (){
                navigateTo(context, SocialUpdateUserDataScreen());
              },
              child: const Padding(
                padding: EdgeInsets.all(11.0),
                child: Icon(IconBroken.Edit , size: 25.0,),
              )
          )
        ],
      ),
    );
  }

}
