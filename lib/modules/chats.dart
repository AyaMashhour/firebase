import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_firebase/model/social_user_model.dart';
import 'package:using_firebase/shared/component.dart';
import 'package:using_firebase/shared/remote/social_app_cubit/social_app_cubit.dart';
import 'package:using_firebase/shared/remote/social_app_cubit/social_app_state.dart';

import 'chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  UserModel model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => BuildItemsOfChats(
                  SocialCubit.get(context).users[index], context),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 1,
                      color: Colors.grey[400],
                    ),
                  ),
              itemCount: SocialCubit.get(context).users.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget BuildItemsOfChats(UserModel model, context) => InkWell(
      onTap: () {
        navigateTo(context, ChatDetailsScreen(model: model));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('${model.image}'),
              radius: 25,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              "${model.name}",
              style: TextStyle(fontFamily: 'Play', fontSize: 20),
            )
          ],
        ),
      ),
    );
