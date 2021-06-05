import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'file:///E:/Programs/app/using_firebase/lib/shared/remote/login_cubit/social_state.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());
  static SocialLoginCubit get(context)=>BlocProvider.of(context);


  void userLogin (
      {
       @required String email,
        @required   String password
      }
      )async
  {
    emit(SocialLoginLoadingState());

      FirebaseAuth.instance.
      signInWithEmailAndPassword(
          email: email,
          password: password).then((value)
      {
        print(value.user.email);
        print(value.user.uid);

        emit(SocialLoginSuccessState(value.user.uid));
      }).catchError((error)
      {
        emit(SocialLoginErrorState(error.toString()));
      });


    }

  }
