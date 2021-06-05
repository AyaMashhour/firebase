import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_firebase/shared/component.dart';

import 'package:using_firebase/shared/remote/social_app_cubit/social_app_cubit.dart';
import 'package:using_firebase/shared/remote/social_app_cubit/social_app_state.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileImage = SocialCubit
            .get(context)
            .profileImage;
        var coverImage = SocialCubit
            .get(context)
            .coverImage;
        var cubit = SocialCubit.get(context);
        var userModel = SocialCubit
            .get(context)
            .userModel;
        nameController.text = userModel.name;
        phoneController.text = userModel.phone;
        bioController.text = userModel.bio;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextBottom(
                  function: () {
                    cubit.updateUser(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text,
                    );
                  },
                  text: 'Update'),
              SizedBox(
                width: 15.0,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // if (state is SocialUploadLoadingState)
                  //   LinearProgressIndicator(),
                  // if (state is SocialUploadLoadingState)
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 195,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Stack(
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
                                    image: coverImage == null
                                        ? NetworkImage(
                                      '${userModel.cover}',
                                    )
                                        : FileImage(profileImage),
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
                                  icon: Icon(Icons.camera_alt_rounded),
                                  onPressed: () {
                                    cubit.getCoverImage();
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                              Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              child: CircleAvatar(
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage),
                                radius: 60,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  end: 8.0, top: 8.0),
                              child: CircleAvatar(
                                radius: 20.0,
                                child: IconButton(
                                  icon: Icon(Icons.camera_alt_rounded),
                                  onPressed: () {
                                    cubit.getProfileImage();
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  if (coverImage != null || profileImage != null)
                    Row(
                      children: [
                        if (profileImage != null)
                          Expanded(
                            child: Column(children: [
                              defaultBottom(
                                  function: ()
                                  {
                                    cubit.upLoadProfileImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                    );
                                  },
                                  text: 'Upload photo'),
                              if (state is SocialUploadLoadingState)
                              SizedBox(
                                height: 5.0,
                              ),
                              if (state is SocialUploadLoadingState)
                              LinearProgressIndicator()
                            ]),
                          )
                            else if(state is SocialUploadCoverImageSuccessState)
                               SizedBox(
                          width: 10.0,
                        ),
                        if (coverImage != null)
                          Expanded(
                            child: Column(children: [
                              defaultBottom(
                                  function: ()
                                  {
                                    cubit.upLoadCoverImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,

                                    );
                                  },
                                  text: 'Upload Cover'),
                              if (state is SocialUploadLoadingState)
                              SizedBox(
                                height: 5.0,
                              ),
                              if (state is SocialUploadLoadingState)
                              LinearProgressIndicator()
                            ]),
                          )
                        else if(state is SocialUploadCoverImageSuccessState)
                          SizedBox(
                            width: 10.0,
                          ),
                      ],
                    ),

                  SizedBox(
                    height: 20.0,
                  ),
                  defaultTextFromField(
                      labelText: 'Name',
                      type: TextInputType.name,
                      validator: (String value) {
                        if (value.isEmpty) {
                          Text('name must not be Empty');
                        }
                        return null;
                      },
                      prefixIcon: Icons.person,
                      controller: nameController,
                      style: TextStyle(
                        fontSize: 19.0,
                        fontFamily: '',
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFromField(
                    style: TextStyle(
                      fontSize: 19.0,
                      fontFamily: '',
                    ),
                    labelText: 'Bio',
                    type: TextInputType.text,
                    validator: (String value) {
                      if (value.isEmpty) {
                        Text('Bio must not be Empty');
                      }
                      return null;
                    },
                    prefixIcon: Icons.info_outline_rounded,
                    controller: bioController,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFromField(
                      labelText: 'Phone',
                      type: TextInputType.phone,
                      validator: (String value) {
                        if (value.isEmpty) {
                          Text('phone must not be Empty');
                        }
                        return null;
                      },
                      prefixIcon: Icons.phone,
                      controller: phoneController,
                      style: TextStyle(
                        fontSize: 19.0,
                        fontFamily: '',
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
