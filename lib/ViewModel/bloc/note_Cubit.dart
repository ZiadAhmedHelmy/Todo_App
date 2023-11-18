import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskapp/ViewModel/bloc/noteState.dart';
import 'package:taskapp/ViewModel/data/local/Shared_Prefreance.dart';
import 'package:taskapp/ViewModel/data/local/shredKeys.dart';
import 'package:taskapp/ViewModel/data/network/dioHelper.dart';
import 'package:taskapp/ViewModel/data/network/endPoints.dart';
import 'package:taskapp/model/statModel.dart';
import 'package:taskapp/model/todoModel.dart';

class NoteCubit extends Cubit<noteStates> {
  NoteCubit() : super(intiNoteState());

  static NoteCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  final formKey = GlobalKey<FormState>();

  // task Controllers
  TextEditingController titleData = TextEditingController();
  TextEditingController contentData = TextEditingController();
  TextEditingController timeDataStart = TextEditingController();
  TextEditingController timeDataEnd = TextEditingController();

  // status List
  List<String> statusList = ["compeleted", "new", "doing", "outdated"];
  String currentStatus = "compeleted";
  num total = 0;

  Future<void> addTask() async {
    emit(AddTaskLoadingState());
    await DioHelper.post(
            endPoint: EndPoints.tasks,
            formData: FormData.fromMap({
              "title": titleData.text,
              "description": contentData.text,
              if (image != null)
                "image": await MultipartFile.fromFile(image!.path),
              "start_date": timeDataStart.text,
              "end_date": timeDataEnd.text,
              "status": currentStatus,
            }),
            token: LocalData.getData(key: SharedKey.token))
        .then((value) {
      emit(AddTaskSuccessState());
      print(value?.data);
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data);
      }
      emit(AddTaskErrorState());
      throw error;
    });
  }

  void changeIndex(int index) {
    currentIndex = index;
    dataFromControllerToFeild();
    emit(ChangeIndexState());
  }

  Future<void> dataFromControllerToFeild() async {
    titleData.text = todoModel?.data?.tasks?[currentIndex].title ?? "empty";
    contentData.text =
        todoModel?.data?.tasks?[currentIndex].description ?? "empty";
    timeDataStart.text =
        todoModel?.data?.tasks?[currentIndex].startDate ?? "empty";
    timeDataEnd.text = todoModel?.data?.tasks?[currentIndex].endDate ?? "empty";
    currentStatus = todoModel?.data?.tasks?[currentIndex].status ?? "empty";
  }

  TodoModel? todoModel;
  Future<void> getAllTasks() async {
    emit(GetTasksLoadingState());
    await DioHelper.get(
            endPoint: EndPoints.tasks,
            token: LocalData.getData(key: SharedKey.token))
        .then((value) {
      print(value?.data);
      todoModel = TodoModel.fromJson(value?.data);
      if ((todoModel?.data?.meta?.lastPage ?? 0) ==
          (todoModel?.data?.meta?.currentPage ?? 0)) {
        hasMoreTasks = false;
      }
      emit(GetTasksSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data);
      }
      emit(GetTasksErrorState());
      throw error;
    });
  }

  Future<void> editaTodo({required int taskId}) async {
    emit(UpDateTaskLoadingState());
    await DioHelper.post(
            endPoint: "${EndPoints.tasks}/${taskId}",
            formData: FormData.fromMap({
              "_method": "PUT",
              "title": titleData.text,
              "description": contentData.text,
              if (image != null)
                "image": await MultipartFile.fromFile(image!.path),
              "start_date": timeDataStart.text,
              "end_date": timeDataEnd.text,
              "status": currentStatus,
            }),
            token: LocalData.getData(key: SharedKey.token))
        .then((value) {
      emit(UpDateTaskSuccessState());

      print(value?.data);
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data);
      }
      emit(UpDateTaskErrorState());
      throw error;
    });
    clearControllers();
    currentIndex = 0;
  }

  Future<void> deleteNote({required taskId}) async {
    emit(DeleteTaskLoadingState());
    await DioHelper.delete(
            endPoint: "${EndPoints.tasks}/${taskId}",
            token: LocalData.getData(key: SharedKey.token))
        .then((value) {
      emit(DeleteTaskSuccessState());
      getAllTasks();
      print(value?.data);
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data);
      }
      emit(DeleteTaskErrorState());
      throw error;
    });
  }

  XFile? image;
  Future<void> takePhotoFromUser() async {
    emit(UpLoadImageLoadingState());
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      emit(UpLoadImageErrorState());
      Fluttertoast.showToast(msg: "Choose an image");
    }
    emit(UpDateTaskSuccessState());
  }

  statModel? staticModel;
  Future<void> showStatistics() async {
    emit(StatisticsLoadingState());
    await DioHelper.get(
            endPoint: EndPoints.status,
            token: LocalData.getData(key: SharedKey.token))
        .then((value) {
      print(value?.data);
      staticModel = statModel.fromJson(value?.data);
      total = (staticModel?.data?.doing ?? 0) +
          (staticModel?.data?.newTask ?? 0) +
          (staticModel?.data?.compeleted ?? 0) +
          (staticModel?.data?.outdated ?? 0);
      emit(StatisticsSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data);
      } else {
        Fluttertoast.showToast(msg: error);
      }
      emit(StatisticsErrorState());
      throw error;
    });
  }

  void changingStatus(String value) {
    currentStatus = value;
    emit(ChangingStatusState());
  }

  void clearControllers() {
    timeDataStart.clear();
    timeDataEnd.clear();
    titleData.clear();
    contentData.clear();
    currentStatus = "compeleted";
    image = null;
  }

  ScrollController? controller = ScrollController();

  void initController() {
    controller = ScrollController();
  }

  void disposeController() {
    controller?.dispose();
  }

  bool isLoading = false;
  bool hasMoreTasks = true;

  void scrollListener() {
    controller?.addListener(() {
      if (controller!.position.atEdge && controller!.position.pixels != 0 && !isLoading && hasMoreTasks) {
        print("You are at bottom");
      }
      fetchNewTasks();
    });
  }

  Future<void> fetchNewTasks() async {
    isLoading = true;
    emit(FetchTasksLoadingState());
    await DioHelper.get(
            endPoint: EndPoints.tasks,
            params: {
              "page": (todoModel?.data?.meta?.currentPage ?? 0) + 1,
            },
            token: LocalData.getData(key: SharedKey.token))
        .then((value) {
      print(value?.data);
      isLoading = false;
      TodoModel newTodoModel = TodoModel.fromJson(value?.data);
      todoModel?.data?.meta = newTodoModel?.data?.meta;
      todoModel?.data?.tasks?.addAll(newTodoModel?.data?.tasks ?? []);
      if ((todoModel?.data?.meta?.lastPage ?? 0) ==
          (todoModel?.data?.meta?.currentPage ?? 0)) {
        hasMoreTasks = false;
      }
      emit(FetchTasksSuccessState());
    }).catchError((error) {
      isLoading = false;
      if (error is DioException) {
        print(error.response?.data);
      }
      emit(FetchTasksErrorState());
      throw error;
    });
  }
}
