import '../Models/base_model.dart';
import '../Remote_Data/Network/Dio_Exception_Handling/custom_error.dart';

abstract class BaseInterface{
  BaseModel baseModel = BaseModel();
  CustomError? errorMsg;
  bool isError = false;
}