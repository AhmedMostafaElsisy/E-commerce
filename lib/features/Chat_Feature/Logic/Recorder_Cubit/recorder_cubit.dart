import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:captien_omda_customer/features/Chat_Feature/Logic/Recorder_Cubit/recorder_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

import '../../../../core/Helpers/shared.dart';

const Codec _codec = Codec.aacADTS;

class RecorderCubit extends Cubit<RecorderStates> {
  audio.AudioPlayer? audioPlayer;

  FlutterSoundRecorder? audioRecorder = FlutterSoundRecorder();
  String? path = getRecordFileRandomName();
  bool _recorderInstanceIsReady = false;
  bool canPlayRecordedAudio = false;
  bool isFinishRecording = false;
  String timeOfAudioRecorderText = "00:00";
  Timer? timeToCalculateTimeOfRecord;
  int recordTimeLength = 0;
  String timerOfAudioPlayerText = '00:00:00';
  int maxDurationOfRecord = 100;
  int currentPosInMilliseconds = 0;

  RecorderCubit() : super(RecordStateToInit());

  StreamSubscription? _recorderSubscription;

  static RecorderCubit get(context) => BlocProvider.of(context);

  initRecorder() {
    audioPlayer ??= audio.AudioPlayer();

    openTheRecorder();
    emit(RecordStatesInit());
  }

  Future<void> openTheRecorder() async {
    await audioRecorder!.openRecorder();

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _recorderInstanceIsReady = true;
  }

  Future<void> record() async {
    recordTimeLength = 0;
    path = getRecordFileRandomName();

    await audioRecorder!
        .startRecorder(
      toFile: path,
      codec: _codec,
      audioSource: AudioSource.microphone,
    )
        .whenComplete(() {
      emit(RecordStartLoading());
    });

    const oneDecimal = Duration(milliseconds: 100);
    timeToCalculateTimeOfRecord = Timer.periodic(oneDecimal, (Timer timer) {
      recordTimeLength += oneDecimal.inMilliseconds;
      timeOfAudioRecorderText = convertToTimeLabelFromMilliseconds(
              currentPosInMilliseconds: recordTimeLength)
          .toString();
      debugPrint("here is your $recordTimeLength");
      emit(RecordStartLoading());
    });
  }

  void startOrStopRecording() async {
    bool canRecord = await checkPermissionOfMicroPhone();
    debugPrint("user can record : ${_recorderInstanceIsReady && canRecord} ");
    if (_recorderInstanceIsReady && canRecord) {
      if (state is RecordStartLoading) {
        await stopRecorder();
      } else {
        record();
      }
    } else {
      checkPermissionOfMicroPhone();
    }
  }

  stopRecorder() async {
    await audioRecorder!.stopRecorder().then((value) {
      debugPrint("here is you  record path $value");
      canPlayRecordedAudio = true;
      isFinishRecording = true;

      path = value;
      timeOfAudioRecorderText = "00:00";

      emit(StopRecordSuccess(filePath: value!));
    });
    timeToCalculateTimeOfRecord!.cancel();
  }

  void play() {
    if (audioPlayer != null) {
      if (audioPlayer!.state == audio.PlayerState.stopped) {
        audioPlayer!.stop();
        maxDurationOfRecord = 100;
        currentPosInMilliseconds = 0;
      }
      audioPlayer!.play(audio.DeviceFileSource(path!)).then((value) {
        emit(StartPlayerLoading());
      });
    }

    setupAudioToPlay();
  }

  void stopPlayer() {
    _recorderSubscription!.cancel();

    if (audioPlayer!.state == audio.PlayerState.playing) {
      audioPlayer!.stop().then((value) {
        emit(StartPlayerFinish());
      });
    }
  }

  setupAudioToPlay() async {
    _recorderSubscription = audioPlayer!.onDurationChanged.listen((e) {
      maxDurationOfRecord = e.inMilliseconds;

      emit(StartPlayerLoading());
    });
    _recorderSubscription = audioPlayer!.onPositionChanged.listen((e) {
      currentPosInMilliseconds =
          e.inMilliseconds; //get the current position of playing audio

      timerOfAudioPlayerText = convertToTimeLabelFromMilliseconds(
        currentPosInMilliseconds: currentPosInMilliseconds,
      );
      emit(StartPlayerLoading());
    });

    emit(StartPlayerLoading());
  }

  Future<void> setSubscriptionDuration(
      double d) async // v is between 0.0 and 2000 (milliseconds)
  {
    emit(StartPlayerLoading());
    await audioPlayer!.seek(
      Duration(milliseconds: d.floor()),
    );
  }

  resetRecorder() {
    isFinishRecording = false;

    if (audioPlayer != null &&
        audioPlayer?.state == audio.PlayerState.playing) {
      audioPlayer!.stop();
    }
    if (audioRecorder != null && audioRecorder!.isRecording) {
      audioRecorder!.stopRecorder();
    }
    if (timeToCalculateTimeOfRecord != null) {
      timeToCalculateTimeOfRecord!.cancel();
    }
    maxDurationOfRecord = 100;
    currentPosInMilliseconds = 0;
    timeOfAudioRecorderText = "00:00";
  }
}
