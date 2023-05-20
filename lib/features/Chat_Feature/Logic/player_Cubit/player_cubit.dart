import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:captien_omda_customer/features/Chat_Feature/Logic/player_Cubit/player_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Helpers/shared.dart';
import '../../Data/chat_models/chat_model.dart';

class PlayerCubit extends Cubit<PlayerStates> {
  AudioPlayer? audioPlayer;

  bool isFinishRecording = false;

  StreamSubscription? recorderSubscription;
  ChatMassageModel selectedModel = ChatMassageModel(massageId: 0);

  StreamSubscription? mPlayerSubscription;
  String timerText = '00:00:00';
  int maxDurationOfRecord = 100;

  int currentPosInMilliseconds = 0;

  PlayerCubit() : super(PlayerStatesInit());

  static PlayerCubit get(context) => BlocProvider.of(context);

  initPlayer() async {
    audioPlayer = AudioPlayer();
    currentPosInMilliseconds = 0;
    timerText = '00:00:00';
    emit(PlayerStatesInit());
  }

  Future<void> setSubscriptionDuration(
      double d) async // v is between 0.0 and 2000 (milliseconds)
  {
    emit(PlayerStatesInit());

    await audioPlayer!.seek(
      Duration(milliseconds: d.floor()),
    );
  }

  Future<void> play(
    String path,
  ) async {
    if (audioPlayer != null) {
      if (audioPlayer!.state == PlayerState.playing) {
        audioPlayer!.stop();
      }

      audioPlayer!
          .play(UrlSource(path))
          .whenComplete(() => emit(StartPlayerFinish()));
    }

    trackAudioPosition();
  }

  trackAudioPosition() async {
    mPlayerSubscription = audioPlayer!.onDurationChanged.listen((e) {
      debugPrint(
          "here is maxDurationOfRecord length from cubit before call maxDuration ${e.toString()}");
      maxDurationOfRecord = e.inMilliseconds;
      debugPrint(
          "here is maxDurationOfRecord length from cubit  ${maxDurationOfRecord.toDouble()}");

      emit(AudioPlayed());
    });
    recorderSubscription = audioPlayer!.onPositionChanged.listen(
      (e) {
        currentPosInMilliseconds =
            e.inMilliseconds; //get the current position of playing audio
        debugPrint(
            "here is currentPosInMilliseconds length from cubit ${currentPosInMilliseconds.toDouble()}");
        timerText = convertToTimeLabelFromMilliseconds(
          currentPosInMilliseconds: currentPosInMilliseconds,
        );

        emit(AudioPlayed());
      },
    );
  }

  void stopPlayer() {
    recorderSubscription!.cancel();
    mPlayerSubscription!.cancel();

    if (audioPlayer!.state == PlayerState.playing) {
      audioPlayer!.stop().then((value) {
        emit(StartPlayerFinish());
      });
    }
  }

  selectModel({required ChatMassageModel massagingModel}) {
    selectedModel = massagingModel;
    emit(PlayerStatesInit());
  }
}
