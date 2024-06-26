import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:local_music/const/style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:swipe/swipe.dart';

import '../controller/player_controller.dart';

class Player extends ConsumerStatefulWidget {
  final List<SongModel> songInfo;
  const Player({super.key, required this.songInfo});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayerState();
}

class _PlayerState extends ConsumerState<Player> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Obx(
                () => Swipe(
                  horizontalMaxHeightThreshold: 50.0,
                  horizontalMinDisplacement: 50.0,
                  onSwipeDown: () {
                    Navigator.of(context).pop(true);
                  },
                  onSwipeLeft: () {
                    controller.playSong(
                      widget.songInfo[controller.playIndex.value + 1].uri!,
                      controller.playIndex.value + 1,
                    );
                  },
                  onSwipeRight: () {
                    controller.playSong(
                      widget.songInfo[controller.playIndex.value - 1].uri!,
                      controller.playIndex.value - 1,
                    );
                  },
                  child: Column(
                    children: [
                      QueryArtworkWidget(
                        artworkFit: BoxFit.cover,
                        quality: 100,
                        id: widget.songInfo[controller.playIndex.value].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: const Icon(Icons.image, size: 200),
                        artworkWidth: MediaQuery.of(context).size.width - 50,
                        artworkHeight: MediaQuery.of(context).size.height / 2.5,
                      ),
                      Text(
                        widget.songInfo[controller.playIndex.value]
                            .displayNameWOExt,
                        maxLines: 1,
                        style: Style()
                            .songTitleStyle
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        "${widget.songInfo[controller.playIndex.value].artist}",
                        style:
                            Style().artistStyle.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    color: Colors.white,
                  ),
                  child: Obx(
                    () {
                      if (controller.isRepeat.value) {
                        print('Obx repeat:${controller.isRepeat.value}');
                        controller.audioPlayer.setLoopMode(LoopMode.one);
                      } else if (controller.isRepeat.value == false) {
                        controller.audioPlayer.setLoopMode(LoopMode.off);
                      }

                      if (controller.isShuffle.value) {
                        print("shuffle ${controller.isShuffle.value}");
                        controller.audioPlayer
                          ..shuffle()
                          ..setShuffleModeEnabled(true);
                      } else if (controller.isShuffle.value == false) {
                        print("shuffle ${controller.isShuffle.value}");
                        controller.audioPlayer.setShuffleModeEnabled(false);
                      } else {}
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () async{
                                  String on = "Shuffle On";
                                  String off = "Shuffle Off";
                                  if (controller.isShuffle.value == false) {
                                    
                                    setState(() {
                                      controller.isShuffle.value = true;
                                    });

                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(on),
                                      backgroundColor: Colors.blue,
                                    ));

                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(off)));
                                    setState(() {
                                      controller.isShuffle.value = false;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.shuffle_outlined,
                                  color: controller.isShuffle.value == false
                                      ? Colors.grey
                                      : Colors.blue,
                                  size: 30,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    controller.playSong(
                                      widget
                                          .songInfo[
                                              controller.playIndex.value - 1]
                                          .uri!,
                                      controller.playIndex.value - 1,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.skip_previous_rounded,
                                    size: 40,
                                  )),
                              CircleAvatar(
                                radius: 30.0,
                                backgroundColor: Colors.black,
                                child: IconButton(
                                  onPressed: () {
                                    if (controller.isPlaying.value) {
                                      controller.audioPlayer.pause();
                                      controller.isPlaying(false);
                                      debugPrint(
                                          "Audio Player : ${controller.audioPlayer.shuffleIndicesStream}");
                                    } else {
                                      controller.audioPlayer.play();
                                      controller.isPlaying(true);
                                    }
                                  },
                                  icon: controller.isPlaying.value
                                      ? const Icon(
                                          Icons.pause_rounded,
                                          size: 48,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.play_arrow_rounded,
                                          size: 48,
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.playSong(
                                    widget
                                        .songInfo[
                                            controller.playIndex.value + 1]
                                        .uri!,
                                    controller.playIndex.value + 1,
                                  );
                                },
                                icon: const Icon(
                                  Icons.skip_next_rounded,
                                  size: 40,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (controller.isRepeat.value == false) {
                                    setState(() {
                                      controller.isRepeat(true);
                                    });
                                    debugPrint(
                                        "Is repeat true ${controller.isRepeat.value}");
                                  } else if (controller.isRepeat.value ==
                                      true) {
                                    setState(() {
                                      controller.isRepeat(false);
                                    });
                                    debugPrint(
                                        "Is repeat false ${controller.isRepeat.value}");
                                  } else {}
                                },
                                icon: Icon(
                                  Icons.repeat_one_on_outlined,
                                  color: controller.isRepeat.value
                                      ? Colors.blue
                                      : Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          // const Spacer(),
                          Obx(
                            () {
                              return Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Slider(
                                      // divisions: 10,
                                      label: 'j',
                                      activeColor: Colors.blue,
                                      thumbColor: Colors.black,
                                      inactiveColor: Colors.grey,
                                      min: 0.0,
                                      max: controller.max.value,
                                      value: controller.value.value,
                                      onChanged: (newVal) {
                                        controller
                                            .changeDuration(newVal.toInt());
                                        newVal = newVal;
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.position.value,
                                          style: Style().artistStyle.copyWith(
                                              color: Colors.black,
                                              fontSize: 12.0),
                                        ),
                                        Text(
                                          controller.duration.value,
                                          style: Style().artistStyle.copyWith(
                                              color: Colors.black,
                                              fontSize: 12.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20.0)
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
