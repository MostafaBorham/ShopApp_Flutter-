// ignore_for_file: file_names
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static initShopApp(String language, token) {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'lang': language,
          'Content-Type': 'application/json',
          'Authorization': token
        }));
  }

  static Future<Response> getData({required String url, dynamic query}) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(String url, {dynamic data}) async {
    return await dio!.post(url, data: data);
  }

  static Future<Response> putData(String url, {dynamic data}) async {
    return await dio!.put(url, data: data);
  }
}
