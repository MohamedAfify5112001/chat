import 'dart:io';

import 'package:chat/layouts/layout_cubit/social_cubit.dart';
import 'package:chat/layouts/layout_cubit/social_states.dart';
import 'package:chat/models/messages_model.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/shared/components/constants.dart';
import 'package:chat/shared/styles/icon_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? model;
  var messagesController = TextEditingController();

  ChatDetailsScreen({required this.model});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getAllMessages(receiverId: model!.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {
            if (state is SuccessSendMessagesState) {
              messagesController.text = '';
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: buildAppBar(context),
              body: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message = SocialCubit.get(context)
                                  .listOfMessages[index];
                              if (message.senderId == uId) {
                                return _buildMyItemMessage(
                                    context,
                                    SocialCubit.get(context)
                                        .listOfMessages[index]);
                              }
                              return _buildReceiverItemMessage(
                                  context,
                                  SocialCubit.get(context)
                                      .listOfMessages[index]);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10.0,
                                ),
                            itemCount:
                                SocialCubit.get(context).listOfMessages.length),
                      ),
                      _buildMessageFieldItems(context)
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(IconBroken.Arrow___Left)),
      title: Row(
        children: [
          CircleAvatar(
            radius: 22.0,
            backgroundImage: NetworkImage("${model!.image}"),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text("${model!.username}",
              style: Theme.of(context).textTheme.bodyText1)
        ],
      ),
    );
  }

  Widget _buildReceiverItemMessage(BuildContext context, MessagesModel model) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          '${model.message}',
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(15.0),
            topEnd: Radius.circular(15.0),
            bottomEnd: Radius.circular(15.0),
          ),
        ),
      ),
    );
  }

  Widget _buildMyItemMessage(BuildContext context, MessagesModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          '${model.message}',
          style: const TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: mainColor.withOpacity(.7),
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(15.0),
            topEnd: Radius.circular(15.0),
            bottomStart: Radius.circular(15.0),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageFieldItems(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(color: Colors.grey, width: .5)),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      controller: messagesController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "write message here..."),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: mainColor.withOpacity(.7)),
                  child: MaterialButton(
                    minWidth: 1.0,
                    onPressed: () {
                      SocialCubit.get(context).sendMessages(
                          message: messagesController.text,
                          dateTime: DateTime.now().toString(),
                          receiverId: model!.uId as String);
                    },
                    child: const Icon(
                      IconBroken.Send,
                      color: Colors.white,
                      size: 28.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
      ],
    );
  }
}
