import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:video_storage_query/video_storage_query.dart';

class VideoPlayerScreen extends ConsumerStatefulWidget {
  final VideoItem videoItem;
  const VideoPlayerScreen({super.key, required this.videoItem});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends ConsumerState<VideoPlayerScreen> {
  late VideoPlayerController playerController;

  @override
  void initState() {
    super.initState();
    playerController = VideoPlayerController.file(File(widget.videoItem.path))
      ..setVolume(1.0)
      ..setLooping(true)
      ..initialize().then((_) {
        playerController.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    playerController.dispose();
  }

  var isVisible = false;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: playerController.value.isInitialized
          ? Stack(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: AspectRatio(
                    aspectRatio: playerController.value.aspectRatio,
                    child: VideoPlayer(playerController),
                  ),
                ),
                Visibility(
                  visible: isVisible,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.black87,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                playerController.value.isPlaying
                                    ? playerController.pause()
                                    : playerController.play();
                              });
                            },
                            icon: Icon(playerController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow),
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }

}
