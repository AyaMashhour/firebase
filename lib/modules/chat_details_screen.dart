import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:using_firebase/model/massenger_user_model.dart';
import 'package:using_firebase/model/social_user_model.dart';
import 'package:using_firebase/shared/remote/social_app_cubit/social_app_cubit.dart';
import 'package:using_firebase/shared/remote/social_app_cubit/social_app_state.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel model;
  var sendMyMessage = TextEditingController();

  ChatDetailsScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Builder(
          builder: (BuildContext context) {
            SocialCubit.get(context).getMessage(recevireId: model.uid);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 5,
                title: Row(
                  children: [

                    CircleAvatar(
                      radius: 23.0,
                      backgroundImage: NetworkImage(model.image),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(model.name)
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length > 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context,index)
                            {
                              var massage=SocialCubit.get(context).messages[index];
                              if(SocialCubit.get(context).userModel.uid==massage.senderId)
                               {
                                 return buildMessage(massage);

                               }
                              return buildMyMessage(massage);

                            },
                            separatorBuilder: (context,state)=>SizedBox(
                              height: 15.0,
                            ),
                            itemCount:SocialCubit.get(context).messages.length ),
                      ),


                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: sendMyMessage,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '  Type your massage here....',
                                  hintStyle: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                maxLines: 1,
                              ),
                            ),
                            MaterialButton(
                              height: 40,
                              minWidth: 15,
                              elevation: 10,
                              color: Colors.blue,
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                    text: sendMyMessage.text,
                                    recevireId: model.uid,
                                    dateTime: DateTime.now().toString());
                              },
                              child: Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Widget buildMessage(MessengerModel model)=> Align(
  alignment: Alignment.topLeft,
  child: Container(
      padding: EdgeInsets.all(9.0),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomEnd: Radius.circular(10))),
      child: Text(model.text)),
);

Widget buildMyMessage(MessengerModel model)=>   Align(
  alignment: Alignment.topRight,
  child: Container(
      padding: EdgeInsets.all(9.0),
      decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomStart: Radius.circular(10))),
      child: Text(model.text)),
);