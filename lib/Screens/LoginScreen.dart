import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/Screens/DashBoard.dart';
import 'package:taskapp/Screens/registerScreen.dart';
import 'package:taskapp/ViewModel/auth/auth_cubit.dart';
import 'package:taskapp/ViewModel/bloc/note_Cubit.dart';
import 'package:taskapp/components/FormFeild.dart';
import 'package:taskapp/utils/Colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubitAuth = NoteCubit.get(context);
    cubitAuth.dataFromControllerToFeild();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backGround,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: AuthCubit.get(context).loginKey,
              child: Column(
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: AppColor.Orange),
                  ),
                  CustomTextField(
                    hintText: "Email",
                    icon: Icon(Icons.email , color: AppColor.Orange,),
                    controller: AuthCubit.get(context).loginEmail,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      String emailPattern =
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                      RegExp regex = RegExp(emailPattern);
                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),
                  CustomTextField(
                    hintText: "password",

                    controller: AuthCubit.get(context).loginPassword,
                    icon:  Icon(Icons.password , color: AppColor.Orange,),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 8) {
                        return 'Password must have at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          color: AppColor.Orange
                        ),
                        child: TextButton(
                            onPressed: () {
                              if (AuthCubit.get(context)
                                  .loginKey
                                  .currentState!
                                  .validate()) {
                                AuthCubit.get(context).login().then((value) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {

                                          return const dashboard();

                                        } ,
                                      ),
                                      (route) => false);
                                });
                              }
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20 , color: Colors.white),
                            )),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an Account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const registerScreen(),
                          ));
                    },
                    child: const Text("Register"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
