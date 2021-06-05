import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:using_firebase/shared/component.dart';
import 'package:using_firebase/shared/remote/social_app_cubit/social_app_cubit.dart';
import 'package:using_firebase/shared/remote/social_app_cubit/social_app_state.dart';

class NewPostScreen extends StatelessWidget {
  var textPostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(context: context, title: 'Add Post', actions: [
            defaultTextBottom(
                text: 'Post',
                function: () {
                  var now = DateTime.now();
                  if (SocialCubit.get(context).PostImage == null) {
                    SocialCubit.get(context).createPost(
                        text: textPostController.text,
                        dateTime: now.toString());
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                        text: textPostController.text,
                        dateTime: now.toString());
                  }
                })
          ]),
          body: Padding(

            padding: EdgeInsets.all(8.0),

              child: Column(
                children: [
                  if (state is SocialCreatePostLoadingState)
                    LinearProgressIndicator(),
                  if (state is SocialCreatePostLoadingState)
                    SizedBox(
                      height: 15,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://image.freepik.com/free-photo/young-woman-with-afro-haircut-wearing-white-t-shirt_273609-21299.jpg'),
                        radius: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text('AyA Mashhour'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textPostController,
                      decoration: InputDecoration(
                          hintText: 'Whats on Your Mind.....',
                          hintStyle: TextStyle(fontSize: 18.0),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  if(SocialCubit.get(context).PostImage!=null)
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0),
                                ),
                                image: DecorationImage(
                                  image: FileImage(SocialCubit.get(context).PostImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                end: 8.0, top: 8.0),
                            child: CircleAvatar(
                              radius: 20.0,
                              child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: ( )
                                {
                                  SocialCubit.get(context).removePostImage();
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextButton(onPressed: ()
                        {
                          SocialCubit.get(context).getPostImage();
                        }, child: Row(
                          children: [
                            FaIcon(FontAwesomeIcons.cameraRetro),
                            SizedBox(width: 9.0,),
                            Text('Add Photo')
                          ],
                        )),

                      ),

                      SizedBox(width: 20.0,),
                      TextButton(onPressed: ()
                      {}
                          , child: Row(
                            children: [
                              Text('#'),

                              Text('Add Photo')
                            ],
                          ))
                    ],
                  )

                ],
              ),
            ),


        );
       
      },
    );
  }
}
