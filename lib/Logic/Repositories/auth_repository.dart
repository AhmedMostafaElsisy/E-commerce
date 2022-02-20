import 'package:default_repo_app/Data/Dio_Exception_Handling/custom_error.dart';
import 'package:default_repo_app/Data/Dio_Exception_Handling/custom_exception.dart';
import 'package:default_repo_app/Data/Dio_Exception_Handling/dio_helper.dart';
import 'package:default_repo_app/Logic/Models/base_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  BaseModel baseModel = BaseModel();
  CustomError? errorMsg;
  bool isError = false;

  /// singUp user to app
  Future<BaseModel> userSingUp(
      {required String phoneNumber,
      required String password,
      required String name,
      required String email}) async {
    isError = false;
    FormData staticData = FormData();

    try {
      staticData.fields.clear();
      String _pathUrl = '/register';
      staticData.fields.add(MapEntry('phone', phoneNumber));
      staticData.fields.add(MapEntry('password', password));
      staticData.fields.add(MapEntry('email', email));
      staticData.fields.add(MapEntry('name', name));

      debugPrint(
          "here is the data form of user sing up ${staticData.fields.toString()} ");

      Response response =
          await DioHelper.postData(url: _pathUrl, data: staticData);
      if (response.statusCode == 200) {
        /// parsing response to user model
        baseModel = BaseModel.fromJson(response.data);
        debugPrint(baseModel.data);
        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath);
      return baseModel;
    } catch (error) {
      isError = true;
      return baseModel;
    }
  }

  /// login user to app
  Future<BaseModel> loginUser({
    required String phoneNumber,
    required String password,
    // required deviceToken,
  }) async {
    isError = false;
    FormData staticData = FormData();

    try {
      staticData.fields.clear();
      String loginUrl = '/login';
      staticData.fields.add(MapEntry('phone', phoneNumber));
      staticData.fields.add(MapEntry('password', password));

      Response response =
          await DioHelper.postData(url: loginUrl, data: staticData);
      if (response.statusCode == 200) {
        /// parsing response to user model
        baseModel = BaseModel.fromJson(response.data);
        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath);
      return baseModel;
    } catch (error) {
      isError = true;
      return baseModel;
    }
  }

  Future<BaseModel> resetPassword({
    required String phoneNumber,
    required String password,
    required String newPassword,
  }) async {
    isError = false;
    FormData staticData = FormData();

    try {
      staticData.fields.clear();
      String _pathUrl = '/reset/password';
      staticData.fields.add(MapEntry('phone', phoneNumber));
      staticData.fields.add(MapEntry('password', password));
      staticData.fields.add(MapEntry('password_confirmation', newPassword));

      Response response =
          await DioHelper.postData(url: _pathUrl, data: staticData);
      if (response.statusCode == 200) {
        /// parsing response to user model
        baseModel = BaseModel.fromJson(response.data);
        return baseModel;
      } else {
        return baseModel;
      }
    } on CustomException catch (ex) {
      isError = true;
      errorMsg = CustomError(
          type: ex.type, errorMassage: ex.errorMassage, imgPath: ex.imgPath);
      return baseModel;
    }
  }

  // /// Sign In Google
  // Future<String?> signInwithGoogle({context}) async {
  //   try {
  //     GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
  //     GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount!.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     final _user = (await _auth.signInWithCredential(credential)).user;
  //     Navigator.pushNamed(context, RouteNames.registerWithPhoneScreen,
  //         arguments: RouteArgument(
  //             email: _user!.email,
  //             name: _user.displayName,
  //             provider: "google"));
  //     await _auth.signInWithCredential(credential);
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //     throw e;
  //   }
  // }
  //
  // Future<void> signOutFromGoogle() async {
  //   await _googleSignIn.signOut();
  //   await FacebookAuth.instance.logOut();
  //   await _auth.signOut();
  // }
  //
  // /// Sign In Facebook
  // Future<void> signInwithFacebook({context, provider}) async {
  //   final LoginResult result = await FacebookAuth.instance.login(
  //     permissions: ['public_profile', 'email'],
  //   );
  //
  //   if (result.status == LoginStatus.success) {
  //     // you are logged
  //     final OAuthCredential credential =
  //         FacebookAuthProvider.credential(result.accessToken!.token);
  //     final _user =
  //         (await FirebaseAuth.instance.signInWithCredential(credential)).user;
  //     Navigator.pushNamed(context, RouteNames.registerWithPhoneScreen,
  //         arguments: RouteArgument(
  //             email: _user!.email,
  //             name: _user.displayName,
  //             provider: "facebook"));
  //   } else {
  //     debugPrint(result.status);
  //     debugPrint(result.message);
  //   }
  // }
}
