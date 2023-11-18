import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskapp/ViewModel/auth/auth_cubit.dart';
import 'package:taskapp/components/FormFeild.dart';
import 'package:taskapp/utils/Colors.dart';

class registerScreen extends StatelessWidget {
  const registerScreen({super.key});

  @override
  Widget build(BuildContext context) {


           return Scaffold(
             resizeToAvoidBottomInset: false,
             appBar: AppBar(
               backgroundColor: Colors.transparent,
               elevation: 0,
               iconTheme: const IconThemeData(
                   color: Colors.black
               ),
             ),

            backgroundColor: AppColor.backGround,
             body: Padding(
               padding: const EdgeInsets.all(10.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Form(
                     key: AuthCubit.get(context).key,
                     autovalidateMode:AutovalidateMode.onUserInteraction ,
                     child: Column(
                       children: [
                          Text(
                           "Register",
                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30 , color: AppColor.Orange),
                         ),
                         CustomTextField(
                           hintText: "Username",
                           icon: const Icon(Icons.person),
                           controller: AuthCubit.get(context).userName,
                           validator: (value) {
                             RegExp regex = RegExp(r'^.{,8}$');
                             if (value!.isEmpty) {
                               return "empty filed";
                             }
                             if (regex.hasMatch(value!)) {
                               return "At least input 8 Characters";
                             }
                            return null;
                             },
                         ),
                         CustomTextField(
                           hintText: "Email",
                           icon: const Icon(Icons.email_outlined),
                           controller: AuthCubit.get(context).email,
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
                         CustomTextField(
                           hintText: "password",
                           icon: const Icon(Icons.password),
                           controller: AuthCubit.get(context).password,
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter your password';
                             }
                             if (value.length < 8) {
                               return 'Password must have at least 8 characters';
                             }

                           },
                         ),
                         CustomTextField(
                             hintText: "confirm password",
                             icon:const  Icon(Icons.password),
                             controller: AuthCubit.get(context).confirmPassword,
                             validator: (value) {
                               if (value!.isEmpty) {
                                 return "empty filed";
                               }
                                if(value!=AuthCubit.get(context).password){
                                 return "password doesn't match";
                               }
                               return null;
                             }),

                         Container(
                           width: double.infinity,
                           height: 50,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               color: AppColor.Orange
                           ),
                           child: TextButton(

                               onPressed: () {
                                 if (AuthCubit.get(context).key.currentState!.validate()) {
                                   AuthCubit.get(context).register().then((value){
                                     Navigator.pop(context);
                                   } );

                                 }
                               },
                               child: const Text("Sign up" , style: TextStyle(fontWeight: FontWeight.bold , fontSize:20 , color: Colors.white),)),
                         ),
                       ],
                     ),
                   ),



                 ],
               ),
             ),
           );



  }
}
