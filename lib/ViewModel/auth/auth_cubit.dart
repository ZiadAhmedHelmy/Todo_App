import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:taskapp/ViewModel/data/local/Shared_Prefreance.dart';
import 'package:taskapp/ViewModel/data/local/shredKeys.dart';
import 'package:taskapp/ViewModel/data/network/dioHelper.dart';
import 'package:taskapp/ViewModel/data/network/endPoints.dart';
import 'package:taskapp/utils/Colors.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  // Login Controllers
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  // Register Controllers
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Future<void> login() async {
    emit(LoginLoadingState());
    await DioHelper.post(
            endPoint: EndPoints.Login,
            body: {"email": loginEmail.text, "password": loginPassword.text})
        .then((value) {
      storeDataToLocal(value?.data);
      print(value?.data);
      emit(LoginSuccessState());
      Fluttertoast.showToast(msg: "Login Successfully");
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data);
        Fluttertoast.showToast(msg: "Invalid email or password" ,backgroundColor: AppColor.Orange );
      }
      MotionToast.error(description: error);
      emit(LoginErrorState());
      throw error;
    });
  }

  void storeDataToLocal(Map<String, dynamic> value) {
    LocalData.setData(key: SharedKey.token, value: value["data"]["token"]);
    LocalData.setData(
        key: SharedKey.userId, value: value["data"]["user"]["id"]);
    LocalData.setData(
        key: SharedKey.userName, value: value["data"]["user"]["name"]);
  }

  Future<void> register() async {
    emit(RegisterLoadingState());
    await DioHelper.post(endPoint: EndPoints.register, body: {
      "name": userName.text,
      "email": email.text,
      "password": password.text,
      "password_confirmation": confirmPassword.text,
    }).then((value) {
      print(value?.data);
      emit(RegisterSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data);
        Fluttertoast.showToast(msg: "Invalid email or password");
      }
      emit(RegisterErrorState());
      throw error;
    });
  }

  Future<void> logout() async {
    emit(LoginLoadingState());
    await DioHelper.post(
            endPoint: EndPoints.logout,
            token: LocalData.getData(key: SharedKey.token))
        .then((value) {
      emit(LogOutSuccessState());
      Fluttertoast.showToast(msg: "Logout Successfully");
      clearLoginControllerAndData();
      print(value?.data);
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data);
      }
      emit(LoginErrorState());
      throw error;
    });
  }

  void clearLoginControllerAndData() {
    loginEmail.clear();
    loginPassword.clear();
    LocalData.clearData();
  }
}
