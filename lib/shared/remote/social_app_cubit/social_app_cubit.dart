import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_firebase/model/massenger_user_model.dart';
import 'package:using_firebase/model/post_model.dart';
import 'package:using_firebase/model/social_user_model.dart';
import 'package:using_firebase/modules/add_new_post.dart';
import 'package:using_firebase/modules/chats.dart';
import 'package:using_firebase/modules/feeds_screen.dart';
import 'package:using_firebase/modules/settings_screen.dart';

import 'package:using_firebase/shared/remote/social_app_cubit/social_app_state.dart';
import 'package:image_picker/image_picker.dart';
import '../../constant.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel userModel;

  void getUserData() {
    emit(SocialLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      userModel = UserModel.fromJson(value.data());

      emit(SocialSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),

    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',

    'Settings',
  ];

  void changeNavigationBar(int index) {
    if (index == 1) getUserData();
    if (index == 2)
      emit(SocialAddPostState());
    else {
      currentIndex = index;
      emit(SocialChangeNavigationBarState());
    }
  }

  File profileImage;

  final picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(profileImage.path);

      emit(SocialChangeProfilePhotoSuccessState());
    } else {
      print('No image selected.');
      emit(SocialChangeProfilePhotoErrorState());
    }
  }

  void upLoadProfileImage({
    @required String name,
    @required String bio,
    @required String phone,
  }) {
    emit(SocialUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage.path)
        .pathSegments
        .last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        emit(SocialUploadProfilePhotoSuccessState());
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          image: value,
        );
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfilePhotoErrorState());
    });
  }

  File coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(coverImage.path);
      emit(SocialChangeCoverImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialChangeCoverImageErrorState());
    }
  }

  void upLoadCoverImage({
    @required String name,
    @required String bio,
    @required String phone,
  }) {
    emit(SocialUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage.path)
        .pathSegments
        .last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        emit(SocialUploadCoverImageSuccessState());
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }


  void updateUser({
    @required String name,
    @required String bio,
    @required String phone,
    String cover,
    String image,
  }) {
    UserModel upLoadModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      cover: cover ?? userModel.cover,
      image: image ?? userModel.image,
      email: userModel.email,
      uid: userModel.uid,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(upLoadModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUploadUserErrorState());
    });
  }

  File PostImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      PostImage = File(pickedFile.path);
      print(PostImage.path);
      emit(SocialPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImageErrorState());
    }
  }

  void removePostImage() {
    PostImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    String name,
    String uId,
    String imagePost,
    @required String text,
    @required String dateTime,
  }) {
    emit(SocialCreatePostImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(PostImage.path)
        .pathSegments
        .last}')
        .putFile(PostImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          imagePost: value,
          text: text,
          dateTime: dateTime,
        );
        print(value);
        emit(SocialSuccessState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    String imagePost,
    @required String text,
    @required String dateTime,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel postModel = PostModel(
        name: userModel.name,
        image: userModel.image,
        uid: userModel.uid,
        dateTime: dateTime,
        text: text,
        imagePost: imagePost ?? '');
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> getPostModel = [];

  List<String> postsId = [];
  List<int> memberOfLikes = [];
  List<int> comments = [];

  void getPost() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('posts').get().then((value) {
          postsId.add(element.id);
          memberOfLikes.add(value.docs.length);
          getPostModel.add(PostModel.fromJson(element.data()));
        }).catchError(() {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModel.uid)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void commentPost(String commentId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(commentId)
        .collection('comment')
        .doc(userModel.uid)
        .set({'comment': 0}).then((value) {
      emit(SocialCommentsPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentsPostErrorState(error.toString()));
    });
  }

  List<UserModel> users;

  void getAllUsers() {
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != userModel.uid)
          users.add(UserModel.fromJson(element.data()));
      });
      emit(SocialAllUserSuccessState());
    }).catchError((error) {
      emit(SocialAllUserErrorState(error.toString()));
    });
  }

  void sendMessage({
    @required String recevireId,
    @required String senderId,
    @required String dateTime,
    @required String text,
  }) {
    MessengerModel messengerModel = MessengerModel(
      text: text,
      dateTime: dateTime,
      recevireId: recevireId,
      senderId: senderId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chats')
        .doc(recevireId)
        .collection('messages')
        .add(messengerModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error) {
      print(error);
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(recevireId)
        .collection('chats')
        .doc(userModel.uid)
        .collection('messages')
        .add(messengerModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error) {
      print(error);
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessengerModel>messages = [];

  void getMessage({ @required String recevireId,}) {
    FirebaseFirestore.instance.collection('users')
        .doc(userModel.uid)
        .collection('chats')
        .doc(recevireId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots().listen((event)
    {
      messages=[];

      event.docs.forEach((element)
      {
       messages.add(MessengerModel.fromJson(element.data()));
      });
    });
    emit(SocialGetMessageSuccessState());
  }


}
