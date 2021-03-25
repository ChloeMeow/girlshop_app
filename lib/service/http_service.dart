import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'dart:async';
import 'package:dio/src/response.dart';
import '../config/index.dart';

Future request(url, {formData}) async {
  try {
    Response response;
    DioForNative dio = new DioForNative();
    // Dio dio = new Dio();
    dio.options.contentType = ("application/x-www-form-urlencoded");
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("后端接口异常，请检查测试代码和服务器运行情况……");
    }
  } catch (e) {
    // throw Exception("后端接口异常，请检查测试代码和服务器运行情况……");
    return print('error:::${e}');
  }
}
