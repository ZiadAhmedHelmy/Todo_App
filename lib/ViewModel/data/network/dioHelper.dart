
import 'package:dio/dio.dart';
import 'package:taskapp/ViewModel/data/network/endPoints.dart';

class DioHelper {
  static Dio? dio;


  // INIT
  static Future<void> init() async {
    dio = Dio(BaseOptions(
        baseUrl: EndPoints.BaseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          "Accept" : "application/json",
          "Content-Type": "application/json"
        }
    ));
  }

  // GET
  static Future<Response?> get(
      {required String endPoint ,
        String? token,
        Map<String, dynamic>? body,
        Map<String, dynamic>? params}) async {
    try {
      dio?.options.headers = {
        "Authorization": "Bearer $token",
      };
      Response? response =
      await dio?.get(endPoint, data: body, queryParameters: params);
      return response;
    } catch (e) {
      rethrow;
    }

  }


  // POST
  static Future<Response?> post(
      {required String endPoint,
        String? token,
        FormData? formData,
        Map<String, dynamic>? body,
        Map<String, dynamic>? params}) async {
    try {
      dio?.options.headers = {
        "Authorization": "Bearer $token",
      };
      Response? response =
      await dio?.post(endPoint, data: body?? formData, queryParameters: params ,);
      return response;
    } catch (e) {
      rethrow;
    }

  }

// Delete
  static Future<Response?> delete(
      {required String endPoint,
        String? token,
        Map<String, dynamic>? body,
        Map<String, dynamic>? params}) async {
    try {
      dio?.options.headers = {
        "Authorization": "Bearer $token",
      };
      Response? response =
      await dio?.delete(endPoint, data: body, queryParameters: params);
      return response;
    } catch (e) {
      rethrow;
    }

  }







}