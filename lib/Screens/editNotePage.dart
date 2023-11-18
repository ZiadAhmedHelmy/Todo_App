import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:taskapp/ViewModel/bloc/noteState.dart';
import 'package:taskapp/utils/Colors.dart';
import '../ViewModel/bloc/note_Cubit.dart';
import 'homePage.dart';

class editNotePage extends StatelessWidget {
  editNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = NoteCubit.get(context);
    return BlocConsumer<NoteCubit, noteStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.light,
          appBar: AppBar(
            backgroundColor: AppColor.Orange,
            title: const Text("Edit Task"),
            centerTitle: true,
            iconTheme: IconThemeData(),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
            child: Column(children: [
              Expanded(
                  child: ListView(
                children: [
                  Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            final regex = RegExp(r'^.{8,}$');
                            if (!regex.hasMatch(value)) {
                              return 'Invalid input. Must be at least 8 characters.';
                            }
                            return null; // Return null for valid input
                          },
                          controller: cubit.titleData,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColor.blue),
                            ),
                            label: const Text("Text"),
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: cubit.contentData,
                          style: const TextStyle(color: Colors.black),
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            label: const Text("details"),
                            hintStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                  readOnly: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Select a Date';
                                    }
                                    return null;
                                  },
                                  controller:
                                      cubit.timeDataStart,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.date_range,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    hintText: 'Start Date',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                  ),
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2023, 6, 15),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: (365 * 5))),
                                    ).then((value) {
                                      if (value != null) {
                                       cubit.timeDataStart.text = DateFormat('yyyy-MM-dd').format(value);
                                      }
                                    });
                                  }),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                  readOnly: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Select a Date';
                                    }
                                    return null;
                                  },
                                  controller:
                                      cubit.timeDataEnd,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.date_range,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    hintText: 'End Date',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                  ),
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2023, 6, 15),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: (365 * 5))),
                                    ).then((value) {
                                      if (value != null) {
                                       cubit.timeDataEnd.text = DateFormat('yyyy-MM-dd').format(value);
                                      }
                                    });
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Status :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            DropdownButton(
                              items: cubit.statusList
                                  .map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                NoteCubit.get(context).changingStatus(value!);
                              },
                              value: cubit.currentStatus,
                              borderRadius: BorderRadius.circular(20),
                              dropdownColor: AppColor.backGround,
                            ),
                          ],
                        ),
                        Material(
                          child: InkWell(
                            onTap: () {
                              NoteCubit.get(context).takePhotoFromUser();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: AppColor.light,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  )),
                              child: Visibility(
                                visible: cubit.image == null,
                                replacement:  Image.file(File(cubit.image?.path ?? " ")),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if((cubit.todoModel?.data?.tasks?[cubit.currentIndex].image ?? " ").isNotEmpty)
                                      Image.network(cubit.todoModel?.data?.tasks?[cubit.currentIndex].image ?? " ")
                                    else ...[
                                      const Icon(
                                        Icons.image_outlined,
                                        size: 100,
                                      ),
                                      const Text("Add Image",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                  ]

                                  ],
                                ),

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(AppColor.Pink),
                                ),
                                onPressed: () {
                                  if (NoteCubit.get(context)
                                      .formKey
                                      .currentState!
                                      .validate()) {
                                    NoteCubit.get(context)
                                        .editaTodo(
                                            taskId: NoteCubit.get(context)
                                                    .todoModel
                                                    ?.data
                                                    ?.tasks?[
                                                        NoteCubit.get(context)
                                                            .currentIndex]
                                                    .id ??
                                                0)
                                        .then((value) {
                                      Navigator.pop(context);
                                      NoteCubit.get(context).getAllTasks();
                                      MotionToast.info(
                                              title: const Text("Success"),
                                              description:
                                                  const Text("Task Updated"))
                                          .show(context);
                                    });
                                  }
                                },
                                child: const Text(
                                  "Edit Task",
                                  style: TextStyle(fontSize: 20),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        );
      },
    );
  }
}
