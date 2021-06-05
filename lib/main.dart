import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:using_firebase/layout/home_page.dart';
import 'package:using_firebase/shared/constant.dart';
import 'package:using_firebase/shared/network/cache-helper.dart';
import 'package:using_firebase/shared/remote/bloc_observe.dart';
import 'package:using_firebase/shared/remote/social_app_cubit/social_app_cubit.dart';
import 'package:using_firebase/shared/remote/social_app_cubit/social_app_state.dart';
import 'package:using_firebase/shared/theme/dark_theme.dart';
import 'package:using_firebase/shared/theme/light_theme.dart';

import 'modules/login_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Future<void>firebaseMessageBackgroud(RemoteMessage message)async
  {
    print(message.data.toString());


  }
  var token=FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event)
  {
    print(event.data.toString());
    Fluttertoast.showToast(
        msg: "onMessage",
        // toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

  });

  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print(event.data.toString());
    Fluttertoast.showToast(
        msg: "onMessageOpenedApp",
        // toastLength: toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessageBackgroud);

  Bloc.observer = MyBlocObserver();
  Widget widget;
  await CacheHelper.init();
  uid = CacheHelper.getData(key: "uid");
  print(uid);

  if (uid != null) {
    widget = Homepage();
  } else {
    widget = SocialLoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}



class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialCubit()..getUserData()..getPost()..getAllUsers(),

      child: BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return  MaterialApp(

            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },


      ),
    );
  }

}
