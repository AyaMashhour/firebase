import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_firebase/layout/home_page.dart';
import 'package:using_firebase/modules/register_screen.dart';
import 'package:using_firebase/shared/component.dart';
import 'package:using_firebase/shared/network/cache-helper.dart';
import 'file:///E:/Programs/app/using_firebase/lib/shared/remote/login_cubit/social_login_cubit.dart';
import 'file:///E:/Programs/app/using_firebase/lib/shared/remote/login_cubit/social_state.dart';
import 'package:toast/toast.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailLoginController = TextEditingController();
  var passwordLoginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state)
        {
          if(state is SocialLoginErrorState)
          {
           Toast.show( '${state.error}',
               context,duration: Toast.LENGTH_SHORT,gravity:  Toast.CENTER);

          }
          if(state is SocialLoginSuccessState)
          {
            CacheHelper.saveData(
              key: 'uid',
              value:state.uid
            ).then((value)
            {
            navigateAndFinish(context, Homepage());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Login now to connect with your friends',
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        defaultTextFromField(
                          controller: emailLoginController,
                          validator: (String value){
                            if(value.isEmpty){
                              Text('Please Enter Your Email' );
                            }
                          },

                          prefixIcon: Icons.email,
                          labelText: 'Enter Your Email',
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFromField(
                            controller: passwordLoginController,
                            validator: (String value){
                              if(value.isEmpty){
                                Text('Please Enter your Password' );
                              }
                            },

                            prefixIcon: Icons.lock,
                            labelText: 'Enter your Password',
                            type: TextInputType.visiblePassword,
                            suffixIcon: Icons.remove_red_eye_outlined),
                        SizedBox(
                          height: 25.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultBottom(
                              function: () {
                                if (formKey.currentState.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                      email: emailLoginController.text,
                                      password:passwordLoginController.text
                                  );

                                }
                              },
                              text: 'login'),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account ?',
                                style: TextStyle(color: Colors.black)),
                            defaultTextBottom(
                                text: 'register',
                                function: () {
                                  navigateTo(context, RegisterScreen());
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
