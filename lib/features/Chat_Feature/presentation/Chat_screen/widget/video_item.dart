import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';

class VideoPostItem extends StatefulWidget {
  final String videoUrl;
  final bool isLocal;
  final bool canPlay;
  final double playerHeight;

  const VideoPostItem(
      {Key? key,
      required this.videoUrl,
      required this.isLocal,
      this.playerHeight = 211,
      required this.canPlay})
      : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoPostItem> {
  late VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();
    if (widget.isLocal) {
      videoController = VideoPlayerController.file(File(widget.videoUrl))
        ..initialize().then((_) {
          setState(() {});
        });
    } else {
      videoController = VideoPlayerController.network(widget.videoUrl)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.canPlay
        ? InkWell(
            onTap: () {
              setState(() {
                videoController!.value.isPlaying
                    ? videoController!.pause()
                    : videoController!.play();
              });
            },
            child: Stack(children: [
              SizedBox(
                height: getWidgetHeight(widget.playerHeight),
                width: getWidgetWidth(375),
                child: videoController!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: videoController!.value.aspectRatio,
                        child: VideoPlayer(videoController!),
                      )
                    : Container(),
              ),
              Positioned(
                bottom: 10,
                left: 4,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildIndicator(),
                    getSpaceWidth(3),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (videoController!.value.volume == 1.0) {
                            videoController!.setVolume(0.0);
                          } else {
                            videoController!.setVolume(1.0);
                          }
                        });
                      },
                      child: Icon(
                        videoController!.value.volume == 1.0
                            ? Icons.volume_up
                            : Icons.volume_off,
                        color: AppConstants.lightWhiteColor,
                        size: 25,
                      ),
                    ),
                    getSpaceWidth(3),
                  ],
                ),
              ),
              buildPlay(),
            ]),
          )
        : Stack(children: [
            SizedBox(
              height: getWidgetHeight(widget.playerHeight),
              width: getWidgetWidth(375),
              child: videoController!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: videoController!.value.aspectRatio,
                      child: VideoPlayer(videoController!),
                    )
                  : Container(),
            ),
            Positioned(
              bottom: 10,
              left: 4,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildIndicator(),
                  getSpaceWidth(3),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (videoController!.value.volume == 1.0) {
                          videoController!.setVolume(0.0);
                        } else {
                          videoController!.setVolume(1.0);
                        }
                      });
                    },
                    child: Icon(
                      videoController!.value.volume == 1.0
                          ? Icons.volume_up
                          : Icons.volume_off,
                      color: AppConstants.lightWhiteColor,
                      size: 25,
                    ),
                  ),
                  getSpaceWidth(3),
                ],
              ),
            ),
            buildPlay(),
          ]);
  }

  @override
  void dispose() {
    super.dispose();
    videoController!.dispose();
  }

  Widget buildPlay() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 50),
        reverseDuration: const Duration(milliseconds: 200),
        child: videoController!.value.isPlaying &&
                videoController!.value.isInitialized
            ? Container()
            : Container(
                height: getWidgetHeight(widget.playerHeight),
                width: getWidgetWidth(375),
                color: Colors.black26,
                child: const Center(
                  child: Icon(
                    Icons.play_arrow,
                    color: AppConstants.lightWhiteColor,
                  ),
                ),
              ),
      );

  Widget buildIndicator() => Expanded(
        child: RotatedBox(
          quarterTurns: 2,
          child: VideoProgressIndicator(
            videoController!,
            colors: VideoProgressColors(
                playedColor: AppConstants.lightWhiteColor,
                backgroundColor: AppConstants.lightWhiteColor.withOpacity(0.1),
                bufferedColor: AppConstants.greyColor.withOpacity(0.5)),
            padding: EdgeInsets.symmetric(
                horizontal: getWidgetWidth(4), vertical: getWidgetHeight(1)),
            allowScrubbing: true,
          ),
        ),
      );
}
