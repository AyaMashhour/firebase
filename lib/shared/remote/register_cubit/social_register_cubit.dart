import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_firebase/model/social_user_model.dart';
import 'file:///E:/Programs/app/using_firebase/lib/shared/remote/register_cubit/social_register_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email,
        password: password
    )
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      userCreate(
          name: name,
          email: email,
          uid: value.user.uid,
          phone: phone
      );

    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate(
  {
    @required String name,
    @required String email,
    @required String uid,
    @required String phone,
    String image,
    String cover

})
  {
    UserModel model =UserModel(
      name: name,
      email: email,
      phone: phone,
      cover: 'https://image.freepik.com/free-photo/glad-woman-with-short-hair-styish-summer-outfit-drink-coffe-thr-modern-bridge_273443-4344.jpg',

      uid: uid,
      bio: 'write your bio.....',
      image: 'https://image.freepik.com/free-photo/glad-woman-with-short-hair-styish-summer-outfit-drink-coffe-thr-modern-bridge_273443-4344.jpg',

      isEmailVerified: false,
    );
    FirebaseFirestore.instance.
         collection('users')
         .doc(uid)
        .set(model.toMap())
        .then((value)
    {

      emit(SocialCreateUserSuccessState());
    })
        .catchError((error)
    {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }
}
