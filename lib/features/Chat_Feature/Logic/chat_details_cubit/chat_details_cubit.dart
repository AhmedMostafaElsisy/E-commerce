import 'dart:developer';
import 'dart:io';

import 'package:captien_omda_customer/core/Extensions/format_date_time_to_time_only.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/Constants/Enums/chat/massage_type.dart';
import '../../../../core/Constants/Enums/exception_enums.dart';
import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../Data/chat_models/chat_model.dart';
import '../../Domain/interfaces/send_massage_interface.dart';
import 'chat_details_states.dart';

class ChatDetailsCubit extends Cubit<ChatDetailsStates> {
  ChatDetailsCubit(this._sendChatMassageInterface) : super(ChatInitialStates());

  static ChatDetailsCubit get(context) => BlocProvider.of(context);
  final SendChatMassageInterface _sendChatMassageInterface;
  bool showAttachment = false;
  bool voiceRecord = false;
  List<ChatMassageModel> chatMassageModel = [];
  late ScrollController scrollController;

  ///location object

  set _imageFile(XFile? value) {
    imageXFile = value;
  }

  XFile? imageXFile;
  TextEditingController controller = TextEditingController();

  ///toggle to show and hide attachment
  setAttachmentValue({required bool value}) {
    showAttachment = value;
    emit(ChatAttachmentToggleStates());
  }

  ///toggle to show and hide voice toggle
  setVoiceRecord({required bool value}) {
    voiceRecord = value;
    emit(ChatAttachmentToggleStates());
  }

  ///get massage data
  getMassageData({required int receiverId}) async {
    try {
      emit(ChatMassageLoadingStates());
      var result = await _sendChatMassageInterface.fetchMassageList(
        receiverId: receiverId,
      );
      if (_sendChatMassageInterface.isError) {
        emit(ChatMassageFailedStates(_sendChatMassageInterface.errorMsg!));
      } else {
        chatMassageModel = chatMassageListFromJson(result.data);
        emit(ChatMassageSuccessStates());
      }
    } catch (e) {
      emit(ChatMassageFailedStates(CustomError(
          errorMassage: e.toString(),
          type: CustomStatusCodeErrorType.unExcepted)));
    }
  }

  getBackOfUserMassageData({required int receiverId}) async {
    try {
      emit(ChatMassageBackGroundLoadingStates());
      var result = await _sendChatMassageInterface.fetchMassageList(
        receiverId: receiverId,
      );
      if (_sendChatMassageInterface.isError) {
        emit(ChatMassageBackGroundFailedStates(
            _sendChatMassageInterface.errorMsg!));
      } else {
        if (chatMassageModel.isEmpty) {
          chatMassageModel = chatMassageListFromJson(result.data);
        } else {
          bool firstMessageOfChatListFoundInTempList = false;
          int indexOfFirstMessageFound;
          List<ChatMassageModel> tempChatMassageModel =
              chatMassageListFromJson(result.data);
          debugPrint(
              "here is founded list after search on tempChatMassageModel ->${tempChatMassageModel.toString()}");
          indexOfFirstMessageFound = tempChatMassageModel.indexWhere(
              (element) =>
                  element.massageContent == chatMassageModel[0].massageContent);
          if (indexOfFirstMessageFound == -1) {
            chatMassageModel.addAll(tempChatMassageModel);
          } else {
            debugPrint(
                "here is founded index of indexOfFirstMessageFound ->${indexOfFirstMessageFound.toString()}");
            List<ChatMassageModel> rangeOfFoundedList = tempChatMassageModel
                .getRange(0, indexOfFirstMessageFound)
                .toList();
            int lengthOfChatMessages = chatMassageModel.length;
            debugPrint(
                "here is founded list after search on tempChatMassageModel ->${rangeOfFoundedList.toString()}");
            debugPrint(
                "here is founded list after search on chatMassageModel ->${chatMassageModel.toString()}");
            chatMassageModel.insertAll(0, rangeOfFoundedList);
          }
        }

        emit(ChatMassageBackGroundSuccessStates());
      }
    } catch (e) {
      emit(ChatMassageBackGroundFailedStates(CustomError(
          errorMassage: e.toString(),
          type: CustomStatusCodeErrorType.unExcepted)));
    }
  }

  ///send text massage
  sendTextMassage({required int receiverId}) async {
    if (controller.text.isNotEmpty) {
      log("this my token ${SharedText.userToken}");
      log("this receiver iD  $receiverId");
      _sendMassageRemote(
          massageContent: controller.text,
          massageType: MassageType.text,
          receiverId: receiverId);
    }
  }

  ///  Pick File and send it
  pickFile({required int receiverId}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png'],
      );
      if (result != null) {
        File file = File(result.files.single.path!);
        _imageFile = XFile(file.path);
        _sendMassageRemote(
            massageFile: file.path,
            massageType: MassageType.application,
            receiverId: receiverId);
      }
    } catch (e) {
      debugPrint('Error Fetching Image: $e');
    }
  }

  /// pick image and send it
  pickGalleryImage(imageSource, int receiverId) async {
    try {
      final ImagePicker _picker = ImagePicker();

      final pickedFile = await _picker.pickImage(source: imageSource);
      if (pickedFile != null) {
        _imageFile = pickedFile;
        _sendMassageRemote(
            massageFile: imageXFile!.path,
            massageType: MassageType.image,
            receiverId: receiverId);
      }
    } catch (e) {
      debugPrint('Error Fetching Image: $e');
    }
  }

  /// pick video and send it
  pickVideoImage({required int receiverId}) async {
    try {
      final ImagePicker _picker = ImagePicker();

      final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        _imageFile = pickedFile;
        _sendMassageRemote(
            massageFile: imageXFile!.path,
            massageType: MassageType.video,
            receiverId: receiverId);
      }
    } catch (e) {
      debugPrint('Error Fetching Image: $e');
    }
  }

  ///send voice massage
  sendVoiceMassage({required int receiverId, required String voiceFile}) {
    _sendMassageRemote(
        receiverId: receiverId,
        massageType: MassageType.audio,
        massageFile: voiceFile);
  }

  _sendMassageRemote(
      {required int receiverId,
      String? massageContent,
      String? massageFile,
      required massageType}) async {
    try {
      emit(SendChatMassageLoadingStates());
      await _sendChatMassageInterface.sendChatMassage(
          receiverId: receiverId,
          massageType: massageType,
          massageFile: massageFile,
          massageText: massageContent);
      if (_sendChatMassageInterface.isError) {
        emit(SendChatMassageFailedStates(_sendChatMassageInterface.errorMsg!));
      } else {
        _setMassageLocal(
          receiverId: receiverId,
          massageType: massageType,
          massageContent: massageContent ?? massageFile,
        );
      }
    } catch (e) {
      emit(SendChatMassageFailedStates(CustomError(
          errorMassage: e.toString(),
          type: CustomStatusCodeErrorType.unExcepted)));
    }
  }

  _setMassageLocal(
      {required int receiverId,
      required massageContent,
      required massageType}) {
    chatMassageModel.insert(
      0,
      ChatMassageModel(
        isLocal: true,
        receiverId: receiverId,
        massageContent: massageContent,
        dateOfCreation: DateTime.now().formatDateTimeToChat(),
        massageType: massageType,
      ),
    );
    controller.clear();
    _scrollDown();
    emit(SendChatMassageSuccessStates());
  }

  ///scroll down with list
  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void updateView() {
    emit(ChatInitialStates());
  }
}
