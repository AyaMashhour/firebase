import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_firebase/shared/component.dart';
import 'package:using_firebase/layout/home_page.dart';
import 'file:///E:/Programs/app/using_firebase/lib/shared/remote/register_cubit/social_register_cubit.dart';
import 'file:///E:/Programs/app/using_firebase/lib/shared/remote/register_cubit/social_register_state.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(context, Homepage());
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Register now to connect with your friends !',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFromField(
                          controller: nameController,
                          type: TextInputType.name,
                          validator: (String value) {
                            if (value.isEmpty) {
                              Text('Please Enter your Password');
                            }
                          },
                          labelText: 'User Name',
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFromField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (String value) {
                            if (value.isEmpty) {
                              Text('Please Enter your Password');
                            }
                          },
                          labelText: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFromField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validator: (String value) {
                            if (value.isEmpty) {
                              Text('password is too short');
                            }
                          },
                          labelText: 'Password',
                          prefixIcon: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFromField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validator: (String value) {
                            if (value.isEmpty) {
                              Text('please enter your phone number');
                            }
                          },
                          labelText: 'Phone',
                          prefixIcon: Icons.phone,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => defaultBottom(
                            function: () {
                              if (formKey.currentState.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
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
