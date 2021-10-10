import 'package:chat/layouts/layout_cubit/social_cubit.dart';
import 'package:chat/layouts/layout_cubit/social_states.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/screens/chat_details/chat_details.dart';
import 'package:chat/shared/components/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: SocialCubit.get(context).getAllUser.isNotEmpty,
      fallback: (context) => const Center(child: CircularProgressIndicator()),
      builder: (context) => BlocConsumer<SocialCubit , SocialStates>(
        listener: (context , state){},
        builder: (context , state){
          var cubit = SocialCubit.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0 , vertical: 10.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context , index) => _buildUserChat(context , cubit.getAllUser[index]),
                    separatorBuilder: (context , index) => const SizedBox(height: 20.0,),
                    itemCount: cubit.getAllUser.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserChat(BuildContext context , UserModel model){
    return InkWell(
      onTap: (){
        navigateTo(context, ChatDetailsScreen(model: model,));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage("${model.image}"),
            ),
            const SizedBox(
              width: 7.0,
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    "${model.username}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
