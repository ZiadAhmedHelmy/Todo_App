import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:taskapp/Screens/homePage.dart';
import 'package:taskapp/ViewModel/bloc/noteState.dart';
import 'package:taskapp/ViewModel/bloc/note_Cubit.dart';
import 'package:taskapp/components/dashBorad_Text.dart';

class dashboard extends StatelessWidget {
  const dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = NoteCubit.get(context);
    return BlocProvider.value(
      value: cubit..getAllTasks()..showStatistics(),
      child:
      BlocConsumer<NoteCubit, noteStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Dashboard Tasks",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  cubit.staticModel?.data != null
                      ? Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 150,
                        lineWidth: 10,
                        percent: (((cubit.staticModel?.data?.newTask) ?? 0)
                            .toDouble() /
                            (cubit.total).toDouble()),
                        circularStrokeCap: CircularStrokeCap.round,
                        animation: true,
                        animationDuration: 1000,
                        center: Text(
                          "${cubit.todoModel!.data!.meta!.total!} Tasks",
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        progressColor: Colors.purple,
                      ),
                      CircularPercentIndicator(
                        radius: 135,
                        lineWidth: 10,
                        circularStrokeCap: CircularStrokeCap.round,
                        animation: true,
                        percent: (((cubit.staticModel?.data?.doing) ?? 0)
                            .toDouble() /
                            (cubit.total).toDouble()),
                        progressColor: Colors.blue,
                      ),
                      CircularPercentIndicator(
                        radius: 120,
                        lineWidth: 10,
                        circularStrokeCap: CircularStrokeCap.round,
                        animation: true,
                        percent: (((cubit.staticModel?.data?.compeleted) ?? 0)
                            .toDouble() /
                            (cubit.total).toDouble()),
                        progressColor: Colors.green,
                      ),
                      CircularPercentIndicator(
                        radius: 105,
                        lineWidth: 10,
                        circularStrokeCap: CircularStrokeCap.round,
                        animation: true,
                        percent: (((cubit.staticModel?.data?.outdated) ?? 0)
                            .toDouble() /
                            (cubit.total).toDouble()),
                        progressColor: Colors.black12,
                      ),
                    ],
                  )
                      : CircularPercentIndicator(
                    radius: 150,
                    lineWidth: 10,
                    percent: 0,
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animationDuration: 1000,
                    center: const Text(
                      " 0 Tasks",
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    progressColor: Colors.purple,
                  ),
                  const tile(color: Colors.purple, text: "New Tasks"),
                  const tile(color: Colors.blue, text: "In Progress Tasks"),
                  const tile(color: Colors.green, text: "Completed Tasks"),
                  const tile(color: Colors.grey, text: "OutDated Tasks"),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors
                              .purple),
                          padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                        ),
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const homePage(),));
                        },
                        child: const Text(
                          "Go to Tasks",
                          style: TextStyle(fontSize: 20),
                        )),
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
