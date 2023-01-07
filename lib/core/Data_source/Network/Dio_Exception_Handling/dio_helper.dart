import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/Constants/Enums/exception_enums.dart';
import '../../../../core/Constants/base_urls.dart';
import '../../../../core/Error_Handling/custom_exception.dart';
import '../../../../core/Error_Handling/dio_exception.dart';

class DioHelper {
  static late Dio dio;

  /// Initializing dio baseUrl
  static init() {
    try {
      dio = Dio(
        BaseOptions(
          baseUrl: BaseUrls.domainUrl,
          headers: {'Accept': 'application/json'},
          receiveDataWhenStatusError: true,
        ),
      );
    } on DioError catch (exception) {
      /// Get custom massage for the exception
      final errorType = DioExceptions.fromDioError(exception).errorType;

      /// throw custom exception
      throw CustomException(
        error: CustomError(
          type: errorType,
        ),
      );
    } catch (error) {
      throw CustomException(
        error: CustomError(
            type: CustomStatusCodeErrorType.unExcepted,
            errorMassage: error.toString()),
      );
    }
  }

  ///use this method to get data from api
  static Future<Response> getDate({required String url}) async {
    try {
      return await dio.get(url);
    } on DioError catch (exception) {
      /// Get custom massage for the exception
      debugPrint(
          "here is the error from dio get data ${exception.response!.data["message"]} ");
      final errorType = DioExceptions.fromDioError(exception).errorType;
      final errorMessage = DioExceptions.fromDioError(exception).errorMassage;

      /// throw custom exception
      throw CustomException(
        error: CustomError(type: errorType, errorMassage: errorMessage),
      );
    } catch (error) {
      throw CustomException(
        error: CustomError(
            type: CustomStatusCodeErrorType.unExcepted,
            errorMassage: error.toString()),
      );
    }
  }

  ///use this method to send data to api
  static Future<Response> postData(
      {required String url, required FormData data}) async {
    try {
      final response = await dio.post(url, data: data);

      debugPrint(response.statusCode.toString());
      debugPrint(response.statusMessage);

      return response;
    } on DioError catch (exception) {
      debugPrint(
          "here is the error from dio post data ${exception.response!.data["message"]} ");

      /// G1et custom massage for the exception
      final errorType = DioExceptions.fromDioError(exception).errorType;

      final errorMessage = DioExceptions.fromDioError(exception).errorMassage;

      /// throw custom exception
      /// throw custom exception
      throw CustomException(
        error: CustomError(type: errorType, errorMassage: errorMessage),
      );
    } catch (error) {
      debugPrint("this is error from CustomException exception$error");
      debugPrint(
          "this is error from CustomException exception${error.runtimeType}");

      throw CustomException(
        error: CustomError(
            type: CustomStatusCodeErrorType.unExcepted,
            errorMassage: error.toString()),
      );
    }
  }

  ///use this method to update data in api
  static Future<Response> putData(
      {required String url, required FormData data}) async {
    try {
      final response = await dio.put(url, data: data);
      debugPrint(response.statusCode.toString());
      debugPrint(response.statusMessage);

      return response;
    } on DioError catch (exception) {
      debugPrint(
          "here is the error from dio put data ${exception.response!.data["message"]} ");

      /// G1et custom massage for the exception
      final errorType = DioExceptions.fromDioError(exception).errorType;

      final errorMessage = DioExceptions.fromDioError(exception).errorMassage;

      /// throw custom exception
      throw CustomException(
        error: CustomError(type: errorType, errorMassage: errorMessage),
      );
    } catch (error) {
      debugPrint("this is error from CustomException exception$error");
      debugPrint(
          "this is error from CustomException exception${error.runtimeType}");

      throw CustomException(
        error: CustomError(
            type: CustomStatusCodeErrorType.unExcepted,
            errorMassage: error.toString()),
      );
    }
  }

  ///use this method to delete data in api
  static Future<Response> deleteData({required String url}) async {
    try {
      final response = await dio.delete(url);
      debugPrint(response.statusCode.toString());
      debugPrint(response.statusMessage);

      return response;
    } on DioError catch (exception) {
      debugPrint(
          "here is the error from dio put data ${exception.response!.data["message"]} ");

      /// G1et custom massage for the exception
      final errorType = DioExceptions.fromDioError(exception).errorType;

      final errorMessage = DioExceptions.fromDioError(exception).errorMassage;
      if (DioExceptions.fromDioError(exception).errorType !=
          CustomStatusCodeErrorType.unVerified) {}

      /// throw custom exception
      throw CustomException(
        error: CustomError(
          type: errorType,
          errorMassage: errorMessage,
        ),
      );
    } catch (error) {
      debugPrint("this is error from CustomException exception$error");
      debugPrint(
          "this is error from CustomException exception${error.runtimeType}");

      throw CustomException(
        error: CustomError(
            type: CustomStatusCodeErrorType.unExcepted,
            errorMassage: error.toString()),
      );
    }
  }
}
