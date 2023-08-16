import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({Key? key, required this.videoLink})
      : super(key: key);
  final String videoLink;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  BetterPlayerConfiguration? betterPlayerConfiguration;
  BetterPlayerListVideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    controller = BetterPlayerListVideoPlayerController();
    betterPlayerConfiguration = const BetterPlayerConfiguration(autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        child: BetterPlayerListVideoPlayer(
          BetterPlayerDataSource(
            BetterPlayerDataSourceType.network,
            widget.videoLink,
            notificationConfiguration:
                const BetterPlayerNotificationConfiguration(
                    showNotification: false, author: "Test"),
            bufferingConfiguration: const BetterPlayerBufferingConfiguration(
                minBufferMs: 2000,
                maxBufferMs: 10000,
                bufferForPlaybackMs: 1000,
                bufferForPlaybackAfterRebufferMs: 2000),
          ),
          configuration: const BetterPlayerConfiguration(
              autoPlay: false, aspectRatio: 1, handleLifecycle: true),
          //key: Key(videoListData.hashCode.toString()),
          playFraction: 0.8,
          betterPlayerListVideoPlayerController: controller,
        ),
        aspectRatio: 1);
  }
}
