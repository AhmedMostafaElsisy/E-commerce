import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../Data/chat_models/chat_model.dart';
import '../../../Logic/player_Cubit/player_cubit.dart';
import '../../../Logic/player_Cubit/player_state.dart';

class VoiceMassageWidget extends StatefulWidget {
  final ChatMassageModel model;
  final bool isSender;

  const VoiceMassageWidget({
    Key? key,
    required this.model,
    required this.isSender,
  }) : super(key: key);

  @override
  State<VoiceMassageWidget> createState() => _VoiceMassageWidgetState();
}

class _VoiceMassageWidgetState extends State<VoiceMassageWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlayerCubit, PlayerStates>(
      listener: (playerCtx, playerState) {},
      builder: (playerCtx, playerState) {
        debugPrint(
            "here is voice length ${playerCtx.read<PlayerCubit>().currentPosInMilliseconds.toDouble()}");
        debugPrint(
            "here is voice length ${playerCtx.read<PlayerCubit>().maxDurationOfRecord.toDouble()}");
        return Align(
          alignment:
              widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: getWidgetWidth(250),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppConstants.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Slider(
                    inactiveColor: widget.isSender
                        ? AppConstants.lightWhiteColor
                        : AppConstants.greyColor,
                    activeColor: widget.isSender
                        ? AppConstants.lightWhiteColor
                        : AppConstants.mainColor,
                    thumbColor: widget.isSender
                        ? AppConstants.lightWhiteColor
                        : AppConstants.mainColor,
                    value: playerCtx
                        .read<PlayerCubit>()
                        .currentPosInMilliseconds
                        .toDouble(),
                    min: 0.0,
                    max: playerCtx
                        .read<PlayerCubit>()
                        .maxDurationOfRecord
                        .toDouble(),
                    mouseCursor: MouseCursor.defer,
                    onChanged:
                        playerCtx.read<PlayerCubit>().setSubscriptionDuration,
                  ),
                ),
                InkWell(
                  onTap: () {
                    playerCtx
                        .read<PlayerCubit>()
                        .selectModel(massagingModel: widget.model);
                    playerCtx.read<PlayerCubit>().audioPlayer!.state ==
                            PlayerState.playing
                        ? playerCtx.read<PlayerCubit>().stopPlayer()
                        : playerCtx.read<PlayerCubit>().play(
                              widget.model.isLocal!
                                  ? widget.model.massageContent!
                                  : widget.model.attachment!,
                            );
                  },
                  child: Container(
                    width: getWidgetWidth(30),
                    height: getWidgetHeight(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: widget.isSender
                          ? AppConstants.lightWhiteColor
                          : AppConstants.mainColor,
                    ),
                    child: Center(
                        child: Icon(
                      playerCtx.read<PlayerCubit>().audioPlayer!.state ==
                                  PlayerState.playing &&
                              playerCtx
                                      .read<PlayerCubit>()
                                      .selectedModel
                                      .massageId ==
                                  widget.model.massageId
                          ? Icons.stop
                          : Icons.play_arrow,
                      color: widget.isSender
                          ? AppConstants.mainColor
                          : AppConstants.lightWhiteColor,
                      size: 20,
                    )),
                  ),
                ),
                getSpaceWidth(10),
              ],
            ),
          ),
        );
      },
    );
  }
}
