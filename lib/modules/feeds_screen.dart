import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:using_firebase/model/post_model.dart';
import 'package:using_firebase/shared/constant.dart';
import 'package:using_firebase/shared/remote/social_app_cubit/social_app_cubit.dart';
import 'package:using_firebase/shared/remote/social_app_cubit/social_app_state.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).getPostModel.length > 0 &&
              SocialCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 5,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                        height: 200.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => BuildPostItems(
                        SocialCubit.get(context).getPostModel[index],context,
                        index),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10.0,
                        ),
                    itemCount: SocialCubit.get(context).getPostModel.length)
              ],
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget BuildPostItems(PostModel model, context, index) => Card(
    elevation: 5,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('${model.image}'),
                radius: 25,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${model.name}',
                        style: TextStyle(height: 1.5),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.blue,
                      )
                    ],
                  ),
                  Text(
                    '${model.dateTime}',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(height: 1.5),
                  )
                ],
              )),
              SizedBox(
                width: 15,
              ),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  size: 23.0,
                  color: Colors.black87,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 1.5,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Play',
                fontWeight: FontWeight.w500),

          ),



          if (model.imagePost != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 10.0),
              child: Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage('${model.imagePost}'),
                      fit: BoxFit.cover,
                    )),
              ),
            ),

          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      InkWell(
                        child: FaIcon(
                          FontAwesomeIcons.heart,
                          size: 20.0,
                          color: Colors.red,
                        ),
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 9.0,
                      ),
                      Text('${SocialCubit.get(context).memberOfLikes[index]}'),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: FaIcon(
                          FontAwesomeIcons.commentDots,
                          size: 20.0,
                          color: Colors.orange,
                        ),
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 9.0,
                      ),
                      Text(
                        '1 comments',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 1.5,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userModel.image}'),
                          radius: 18,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'write a comment..... ',
                          style: TextStyle(color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: FaIcon(
                    FontAwesomeIcons.heart,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  onTap: () {
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).postsId[index]);
                  },
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Like',
                  style: TextStyle(color: Colors.grey[900]),
                )
              ],
            ),
          )
        ],
      ),
    ));
