import 'package:flutter/material.dart';
import 'package:msp_educare_demo/audio_play_service.dart';
import 'package:msp_educare_demo/common/commonMethods/download_file.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class VoiceAudioPlayer extends StatefulWidget {
  const VoiceAudioPlayer({Key? key}) : super(key: key);

  @override
  State<VoiceAudioPlayer> createState() => _VoiceAudioPlayerState();
}

class _VoiceAudioPlayerState extends State<VoiceAudioPlayer> {
  @override
  void dispose() {
    AudioPlayService.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
          Container(
            // margin: const EdgeInsets.symmetric(horizontal: 30),
            height:60 ,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(50)),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  child: Icon(AudioPlayService.player.playing
                      ? Icons.pause
                      : Icons.play_arrow),
                  onTap: () {
                    if (AudioPlayService.player.playing) {
                      AudioPlayService.player.stop();
                    } else {
                      AudioPlayService.player.play();
                    }
                    setState(() {});
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: StreamBuilder<Duration>(
                  initialData: const Duration(seconds: 0),
                  stream: AudioPlayService.player.positionStream,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            '${ConstUtils.formatDuration((snapshot.data ?? const Duration(seconds: 0)).inSeconds)} / ${ConstUtils.formatDuration((AudioPlayService.player.duration ?? const Duration(seconds: 0)).inSeconds)}'),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            // child: CustomVideoProgressIndicator(
                            //   isProgressCircleVisible: false,
                            //   currentPosition:
                            //       snapshot.data ?? const Duration(seconds: 0),
                            //   videoDuration: AudioPlayService.player.duration ??
                            //       const Duration(seconds: 0),
                            // ),
                          ),
                        ),
                      ],
                    );
                  },
                )),
                InkWell(
                  child: Icon(AudioPlayService.player.volume == 0
                      ? Icons.volume_off
                      : Icons.volume_up),
                  onTap: () {
                    if (AudioPlayService.player.volume == 0) {
                      AudioPlayService.player.setVolume(1.0);
                    } else {
                      AudioPlayService.player.setVolume(0.0);
                    }
                    setState(() {});
                  },
                ),
                PopupMenuButton(

                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text('Download'),
                      onTap: () {
                        downloadFile(
                            "https://superadmin.mspeducare.com/public/uploads/20230408123253.mp3");
                      },
                    )
                  ],
                )
              ],
            ),
          )
        ;
  }
}
