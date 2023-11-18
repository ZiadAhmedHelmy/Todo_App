import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:taskapp/ViewModel/bloc/noteState.dart';
import 'package:taskapp/components/FormFeild.dart';
import 'package:taskapp/utils/Colors.dart';

import '../ViewModel/bloc/note_Cubit.dart';

class addNotePage extends StatelessWidget {
  addNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = NoteCubit.get(context);
    cubit.clearControllers();
    return Scaffold(
      backgroundColor: AppColor.light,
      appBar: AppBar(
        backgroundColor: AppColor.Orange,
        title: const Text("Add Task"),
        centerTitle: true,
        iconTheme: const IconThemeData(),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(children: [
          Expanded(
              child: ListView(
            children: [
              Form(
                key: NoteCubit.get(context).formKey,
                child: Column(
                  children: [
                    CustomTextField(
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
                      controller: NoteCubit.get(context).titleData,
                      hintText: 'Text',

                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: NoteCubit.get(context).contentData,
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
                        hintStyle: const TextStyle(color: Colors.grey),
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
                              controller: NoteCubit.get(context).timeDataStart,
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
                                hintStyle: const TextStyle(color: Colors.grey),
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
                                    NoteCubit.get(context).timeDataStart.text =
                                        DateFormat('yyyy-MM-dd').format(value);
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
                              controller: NoteCubit.get(context).timeDataEnd,
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
                                hintStyle: const TextStyle(color: Colors.grey),
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
                                    NoteCubit.get(context).timeDataEnd.text =
                                        DateFormat('yyyy-MM-dd').format(value);
                                  }
                                });
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<NoteCubit, noteStates>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return Row(
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
                              items: NoteCubit.get(context)
                                  .statusList
                                  .map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                NoteCubit.get(context).changingStatus(value!);
                              },
                              value: NoteCubit.get(context).currentStatus,
                              borderRadius: BorderRadius.circular(20),
                              dropdownColor: AppColor.backGround,
                            ),
                          ],
                        );
                      },
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
                          child: BlocConsumer<NoteCubit, noteStates>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              return Visibility(
                                visible: NoteCubit.get(context).image == null,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      size: 100,
                                    ),
                                    Text("Add Image",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                replacement: Image.file(
                                  File(NoteCubit.get(context).image?.path ??
                                      " "),
                                  fit: BoxFit.fill,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 70,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(AppColor.Pink),
                  ),
                  onPressed: () {
                    if (NoteCubit.get(context)
                        .formKey
                        .currentState!
                        .validate()) {
                      NoteCubit.get(context).addTask().then((value) {
                        NoteCubit.get(context).getAllTasks();
                        Navigator.pop(context);
                        MotionToast.success(
                          title:  const Text("Success"),
                          description:  const Text("Task Created Successfully"),
                        ).show(context);
                      });
                    }
                  },
                  child: const Text(
                    "Add Task",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
