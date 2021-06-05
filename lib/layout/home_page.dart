import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:using_firebase/modules/add_new_post.dart';
import 'package:using_firebase/shared/component.dart';

import 'package:using_firebase/shared/remote/social_app_cubit/social_app_cubit.dart';
import 'package:using_firebase/shared/remote/social_app_cubit/social_app_state.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialAddPostState)
        {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
              title: Text(
               cubit.titles[cubit.currentIndex],
                style: TextStyle(
                    fontFamily: 'Play',
                    fontSize: 20,

              ),
              ),
              actions: [
                IconButton(
                  iconSize: 28,
                  onPressed: () {},
                  icon: Icon(Icons.notifications_none_outlined),
                ),
                IconButton(
                  iconSize: 30,
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
              ]),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeNavigationBar(index);

              },
              items: [
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon:FaIcon(FontAwesomeIcons.commentDots), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.post_add), label: 'NewPost'),

                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),

              ]),
        );
      },
    );
  }
}

// ConditionalBuilder(
// condition: SocialCubit.get(context).model != null,
//
// fallback: (context) => Center(
// child: CircularProgressIndicator(),
// ),
// builder: (context)
// {
// var model = SocialCubit.get(context).model;
// return Column(
// children:
// [
// // if (!FirebaseAuth.instance.currentUser.emailVerified)
// Container(
// color: Colors.amber.withOpacity(0.9),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15.0),
// child: Row(
// children: [
// Icon(Icons.error_outline),
// SizedBox(
// width: 10.0,
// ),
// Expanded(child: Text('please verify your email')),
// defaultTextBottom(
// text: 'SEND',
// function: ()
// {
// FirebaseAuth.instance.currentUser
//     .sendEmailVerification()
//     .then((value) {
// Toast.show('Check Your Email',
// context,
// backgroundColor: Colors.indigoAccent,
// textColor: Colors.white,
// duration: Toast.LENGTH_SHORT,
// gravity: Toast.CENTER);
// }).catchError((error) {
// SocialErrorState(error.toString());
// });
// }),
// ],
// ),
// )),
// ]);
// },
//
//
// )
