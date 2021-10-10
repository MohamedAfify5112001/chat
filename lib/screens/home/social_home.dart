import 'package:chat/layouts/layout_cubit/social_cubit.dart';
import 'package:chat/layouts/layout_cubit/social_states.dart';
import 'package:chat/models/post_model.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/network/cache_helper.dart';
import 'package:chat/shared/components/constants.dart';
import 'package:chat/shared/styles/icon_fonts.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.builder(
                  itemBuilder: (context, index) => _buildCardOfPosts(
                      context, SocialCubit.get(context).posts[index], index),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: SocialCubit.get(context).posts.length,
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardOfPosts(BuildContext context, PostModel model, index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      elevation: 5.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //author card
              _buildAuthorCard(context, model),
              //divider
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                width: double.infinity,
                height: 0.4,
                color: Colors.black54,
              ),
              //Texts and #
              _buildPostTexts(context, model),

              const SizedBox(
                height: 10.0,
              ),
              //image
              if (model.postImage != '') _buildMyImage(context, model),

              const SizedBox(
                height: 10.0,
              ),
              //count loves and comments
              _buildCountLikesAndCommentsItem(context, index),
              //divider
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                width: double.infinity,
                height: 0.4,
                color: Colors.black54,
              ),
              //make comments , share , love
              _buildMakingCommentsSharedLoves(context, model, index),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthorCard(BuildContext context, PostModel model) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage('${model.image}'),
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
                    "${model.username}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    width: 2.0,
                  ),
                  const Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                    size: 16.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                "${model.dateTime}",
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.grey[500]),
              ),
            ],
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(IconBroken.More_Circle))
      ],
    );
  }

  Widget _buildPostTexts(BuildContext context, PostModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '''${model.text}''',
          style: Theme.of(context).textTheme.headline3!.copyWith(
              fontSize: 18.0,
              color: Colors.grey[700],
              fontWeight: FontWeight.w300),
        ),
        /*const SizedBox(
          height: 8.0,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Text(
              "#Mobile_Application_Developer",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.lightBlue, fontSize: 13.0),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              "#Html",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.lightBlue, fontSize: 13.0),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              "#Css",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.lightBlue, fontSize: 13.0),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              "#Java",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.lightBlue, fontSize: 13.0),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              "#Dart",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.lightBlue, fontSize: 13.0),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              "#Flutter",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.lightBlue, fontSize: 13.0),
            ),
          ],
        ),*/
      ],
    );
  }

  Widget _buildMyImage(BuildContext context, PostModel model) {
    return Container(
      width: double.infinity,
      height: 230.0,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage("${model.postImage}"),
          )),
    );
  }

  Widget _buildCountLikesAndCommentsItem(BuildContext context, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          //love and count love
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    IconBroken.Heart,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 3.0,
                  ),
                  Text(
                    "${SocialCubit.get(context).countLikes[index]}",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 13.0,
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          ),
          //# of comments
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    IconBroken.More_Circle,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 3.0,
                  ),
                  Text(
                    "0",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 13.0,
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(
                    width: 3.0,
                  ),
                  Text(
                    "comments",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMakingCommentsSharedLoves(
      BuildContext context, PostModel model, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage("${model.image}"),
              ),
              const SizedBox(
                width: 8.0,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "write comment...",
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                ),
              ),
            ],
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      IconBroken.Heart,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      "Like",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 13.0,
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
                onTap: () {
                  SocialCubit.get(context)
                      .likePosts(SocialCubit.get(context).postId[index]);
                },
              ),
              const SizedBox(
                width: 25.0,
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      IconBroken.Upload,
                      color: Colors.amber,
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      "Share",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 13.0,
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
