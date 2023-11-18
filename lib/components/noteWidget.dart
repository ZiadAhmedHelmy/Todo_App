import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:taskapp/ViewModel/bloc/note_Cubit.dart';
import 'package:taskapp/model/notemodel.dart';
import 'package:taskapp/model/todoModel.dart';
import 'package:taskapp/utils/AppImages.dart';
import 'package:taskapp/utils/Colors.dart';

class taskWidget extends StatelessWidget {
  final Tasks note;
  void Function()? onTap;

  void Function()? deleteTap ;
  taskWidget({super.key, required this.onTap, required this.note});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.light,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Image.asset(AppImages.logoNote),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: const Text("Are you Sure ?"),
                  backgroundColor:AppColor.light ,
                  actions: [
                    TextButton(
                        onPressed: () {
                          NoteCubit.get(context).deleteNote(
                              taskId: NoteCubit.get(context)
                                  .todoModel
                                  ?.data
                                  ?.tasks?[NoteCubit.get(context).currentIndex]
                                  .id).then((value){
                            Navigator.pop(context);
                            MotionToast.delete(
                                title: const  Text("Deleted"),
                                description:  const Text("Task Deleted Successfully")
                            ).show(context);
                          });

                        },
                        child:  Text("Yes" ,  style: TextStyle(color: AppColor.green)) ),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: const  Text("No", style: TextStyle(color: Colors.red))),
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.delete,
              color: AppColor.black,
            ),
          ),
          title: Text(
            note.title!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.description!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis),
              Text(
                note.startDate!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
