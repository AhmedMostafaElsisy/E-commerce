import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../Logic/Recorder_Cubit/recorder_cubit.dart';
import '../../../Logic/Recorder_Cubit/recorder_state.dart';
import '../../../Logic/chat_details_cubit/chat_details_cubit.dart';

class SendVoiceMassage extends StatefulWidget {
  final int receiverId;

  const SendVoiceMassage({Key? key, required this.receiverId})
      : super(key: key);

  @override
  State<SendVoiceMassage> createState() => _SendVoiceMassageState();
}

class _SendVoiceMassageState extends State<SendVoiceMassage>
    with WidgetsBindingObserver {
  final bool isPlaying = false;

  @override
  void initState() {
    BlocProvider.of<RecorderCubit>(context).initRecorder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecorderCubit, RecorderStates>(
      listener: (recorderCtx, recorderState) {
        if (recorderState is RecordStatesInit) {
          recorderCtx.read<RecorderCubit>().startOrStopRecording();
        } else if (recorderState is StopRecordSuccess) {
          // FileCdnCubit.get(context)
          //     .uploadImge(image: XFile(recorderState.filePath));
          // debugPrint("this user voice path ${recorderState.filePath}");
        }
      },
      builder: (recorderCtx, recorderState) {
        return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getWidgetWidth(16),
              vertical: getWidgetHeight(10),
            ),

            ///flag to check if the user is( done from record voice and ready for send or delete the voice) or still recording
            child: recorderCtx.read<RecorderCubit>().isFinishRecording

                ///ready for send voice
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: getWidgetWidth(345),
                        height: getWidgetHeight(70),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                              color: AppConstants.greyColor.withOpacity(0.25),
                            )),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Slider(
                                  thumbColor: AppConstants.mainColor,
                                  activeColor: AppConstants.gradientColor,
                                  value: recorderCtx
                                      .read<RecorderCubit>()
                                      .currentPosInMilliseconds
                                      .toDouble(),
                                  min: 0.0,
                                  max: recorderCtx
                                      .read<RecorderCubit>()
                                      .maxDurationOfRecord
                                      .toDouble(),
                                  onChanged: recorderCtx
                                      .read<RecorderCubit>()
                                      .setSubscriptionDuration,
                                ),
                              ),
                              getSpaceWidth(10),
                              InkWell(
                                onTap: () {
                                  /// play or pause the recorder voice
                                  recorderCtx
                                              .read<RecorderCubit>()
                                              .audioPlayer!
                                              .state ==
                                          PlayerState.playing
                                      ? recorderCtx
                                          .read<RecorderCubit>()
                                          .stopPlayer()
                                      : recorderCtx
                                          .read<RecorderCubit>()
                                          .play();
                                },
                                child: Container(
                                  width: getWidgetWidth(40),
                                  height: getWidgetHeight(40),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppConstants.mainColor),
                                  child: Center(
                                      child: Icon(
                                    recorderCtx
                                                .read<RecorderCubit>()
                                                .audioPlayer!
                                                .state ==
                                            PlayerState.playing
                                        ? Icons.stop
                                        : Icons.play_arrow,
                                    color: AppConstants.lightWhiteColor,
                                    size: 18,
                                  )),
                                ),
                              ),
                              getSpaceWidth(10),
                            ]),
                      ),
                      getSpaceHeight(10),

                      /// delete the voice icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(

                              ///refresh and rest the record  controller and reset the flag
                              onTap: () {
                                recorderCtx
                                    .read<RecorderCubit>()
                                    .resetRecorder();
                                BlocProvider.of<ChatDetailsCubit>(context)
                                    .setVoiceRecord(value: false);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: AppConstants.lightRedColor,
                                size: 20,
                              )),

                          ///send the recorded voice
                          InkWell(
                            onTap: () {
                              BlocProvider.of<ChatDetailsCubit>(context)
                                  .setVoiceRecord(value: false);
                              BlocProvider.of<ChatDetailsCubit>(context)
                                  .sendVoiceMassage(
                                      voiceFile: recorderCtx
                                          .read<RecorderCubit>()
                                          .path!,
                                      receiverId: widget.receiverId);

                              recorderCtx.read<RecorderCubit>().resetRecorder();
                            },
                            child: SizedBox(
                              width: getWidgetWidth(25),
                              height: getWidgetWidth(25),
                              child: CommonAssetSvgImageWidget(
                                imageString: "send.svg",
                                height: getWidgetHeight(25),
                                width: getWidgetWidth(25),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                :

                ///user record voice now
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: getWidgetWidth(345),
                        height: getWidgetHeight(65),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                              color: AppConstants.greyColor.withOpacity(0.25),
                            )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ///record wave

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidgetWidth(10),
                                    vertical: getWidgetHeight(8)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ///start or stop recording
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            recorderCtx
                                                .read<RecorderCubit>()
                                                .startOrStopRecording();
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: CommonAssetSvgImageWidget(
                                              imageString: "voice_icon.svg",
                                              width: (28),
                                              height: (28),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        getSpaceWidth(20),
                                        InkWell(
                                          onTap: () {
                                            BlocProvider.of<ChatDetailsCubit>(
                                                    context)
                                                .setVoiceRecord(value: false);
                                            recorderCtx
                                                .read<RecorderCubit>()
                                                .resetRecorder();
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: CommonAssetSvgImageWidget(
                                              imageString: "close.svg",
                                              width: (15),
                                              height: (15),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    ///record duration
                                    CommonTitleText(
                                      textKey: recorderCtx
                                          .read<RecorderCubit>()
                                          .timeOfAudioRecorderText,
                                      textColor: AppConstants.greyColor,
                                      textFontSize: 14,
                                      textWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      )
                    ],
                  ));
      },
    );
  }
}
