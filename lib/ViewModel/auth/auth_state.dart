part of 'auth_cubit.dart';


abstract class AuthState {}

class AuthInitial extends AuthState {}

// RegisterStates
class RegisterLoadingState extends AuthState{}
class RegisterSuccessState extends AuthState{}
class RegisterErrorState extends AuthState{}

// LoginStates
class LoginLoadingState extends AuthState{}
class LoginSuccessState extends AuthState{}
class LoginErrorState extends AuthState{}

// logoutStates
class LogOutLoadingState extends AuthState{}
class LogOutSuccessState extends AuthState{}
class LogOutErrorState extends AuthState{}


