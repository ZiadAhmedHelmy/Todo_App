import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/Screens/DashBoard.dart';
import 'package:taskapp/Screens/LoginScreen.dart';
import 'package:taskapp/Screens/addNotePage.dart';
import 'package:taskapp/Screens/editNotePage.dart';
import 'package:taskapp/ViewModel/auth/auth_cubit.dart';
import 'package:taskapp/ViewModel/bloc/noteState.dart';
import 'package:taskapp/ViewModel/bloc/note_Cubit.dart';
import 'package:taskapp/ViewModel/data/local/Shared_Prefreance.dart';
import 'package:taskapp/ViewModel/data/local/shredKeys.dart';
import 'package:taskapp/components/noteWidget.dart';
import 'package:taskapp/model/todoModel.dart';
import 'package:taskapp/utils/AppImages.dart';
import 'package:taskapp/utils/Colors.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: NoteCubit.get(context)..getAllTasks()..initController()..scrollListener(),
      child: Scaffold(
        backgroundColor: AppColor.backGround,
        appBar: AppBar(
          backgroundColor: AppColor.backGround,
          elevation: 0,
          title: const Text(
            "Your Task",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: (){
              AuthCubit.get(context).logout();
              Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginScreen(),));
            },
            icon: Icon(Icons.logout , color: AppColor.Orange,),

          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const dashboard(),), (route) => false);
              },
              icon: CircleAvatar(
                backgroundColor: AppColor.Orange,
                child: const Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: Center(
            child: Text(LocalData.getData(key: SharedKey.userName).toString()),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // BlocConsumer - Generate ListView.Builder
              Expanded(
                child: BlocConsumer<NoteCubit, noteStates>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Expanded(
                          child: Visibility(
                            visible: NoteCubit.get(context)
                                    .todoModel
                                    ?.data
                                    ?.tasks
                                    ?.isNotEmpty ??
                                true,
                            replacement: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppImages.emptyList,
                                    width: 50,
                                  ),
                                  const Text("No Task Added Yet!"),
                                ],
                              ),
                            ),
                            child:  NoteCubit.get(context).todoModel?.data?.tasks != null?   ListView.separated(
                              controller: NoteCubit.get(context).controller,
                              physics:const  BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return taskWidget(
                                      note: NoteCubit.get(context)
                                              .todoModel
                                              ?.data
                                              ?.tasks?[index] ??
                                          Tasks(),
                                      onTap: () {
                                        NoteCubit.get(context).changeIndex(index);
                                        Navigator.push(context,  MaterialPageRoute(builder: (context) {
                                          return editNotePage();
                                        },));
                                      }


                                      );
                                },
                                separatorBuilder: (context, index) => const SizedBox(
                                      height: 20,
                                    ),
                                itemCount: NoteCubit.get(context)
                                        .todoModel
                                        ?.data
                                        ?.tasks
                                        ?.length ??
                                    0) :const  Center(child:  RefreshProgressIndicator())
                          ),
                        ),
                        if(NoteCubit.get(context).isLoading)
                         CircularProgressIndicator(color: AppColor.Orange,),

                      ],
                    );

                  },
                  listener: (context, state) {},
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.black,
          elevation: 10,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => addNotePage()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
