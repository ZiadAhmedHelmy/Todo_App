import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/Screens/registerScreen.dart';
import 'package:taskapp/ViewModel/auth/auth_cubit.dart';
import 'package:taskapp/ViewModel/bloc/note_Cubit.dart';
import 'package:taskapp/ViewModel/data/local/Shared_Prefreance.dart';
import 'package:taskapp/ViewModel/data/network/dioHelper.dart';
import 'package:taskapp/splash/splashScreen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
     DioHelper.init();
     LocalData.init();
   //LocalData.clearData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NoteCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child:   const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: slashScreen(),
      ),
    );
  }
}
