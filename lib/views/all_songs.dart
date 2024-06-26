import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:local_music/const/style.dart';
import 'package:local_music/state_management/riverpod/provider.dart';
import 'package:local_music/controller/player_controller.dart';
import 'package:local_music/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  var controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(allSongsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Musica',
          style: Style().songTitleStyle,
        ),
      ),
      body: data.when(
        data: (data) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final songInfo = data[index];
                    // ref.watch(adds);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Obx(
                        () =>
                        
                         ListTile(
                          leading: QueryArtworkWidget(
                            id: songInfo.id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget:
                                const Icon(Icons.image, size: 32),
                          ),
                          title: Text(songInfo.displayNameWOExt,
                              maxLines: 1, style: Style().songTitleStyle),
                          subtitle: Text(songInfo.artist!,
                              style: Style().artistStyle),
                          trailing: controller.playIndex.value == index
                              ? const Icon(Icons.play_arrow)
                              : null,
                          onTap: () {
                            // ignore: deprecated_member_use
                            // ref.read(lastPlaySongProvider.state).state = songInfo.displayNameWOExt;
                            // ref.read(songUriProvider.state).state = songInfo.uri!;
                            // ref.read(songIndexProvider.state).state = index;
                            // ref.read(songPlayProvider);
                            // Navigator.of(context).push(MaterialPageRoute(builder: (_)=> Player(songInfo: songInfo)));
                            
                            // Get.to(
                            //   () => Player(songInfo: data),
                            //   transition: Transition.downToUp,
                            // );
                            showModalBottomSheet(
                              isDismissible: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Player(songInfo: data);
                              });
                            controller.playSong(songInfo.uri!, index);

                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      isDismissible: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Player(songInfo: data);
                      });
                },
                child: Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(
                        width: 3.0,
                      )),
                  child: Obx(
                    () => Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          child: QueryArtworkWidget(
                            id: data[controller.playIndex.value].id,
                            type: ArtworkType.AUDIO,
                            artworkWidth: 20,
                            artworkHeight: 20,
                            nullArtworkWidget: const Icon(Icons.image),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 150,
                          child: TextScroll(
                            data[controller.playIndex.value].displayNameWOExt,
                            mode: TextScrollMode.endless,
                            velocity:
                                const Velocity(pixelsPerSecond: Offset(30, 0)),
                            delayBefore: const Duration(seconds: 1),
                            numberOfReps: 110,
                            pauseBetween: const Duration(milliseconds: 50),
                            style: const TextStyle(color: Colors.black),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const Spacer(),
                        CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.transparent,
                            child: IconButton(
                              onPressed: () {
                                
                                if (controller.isPlaying.value) {
                                  controller.audioPlayer.pause();
                                  controller.isPlaying(false);
                                } else {
                                  
                                  controller.audioPlayer.play();
                                  controller.playSong(data[controller.playIndex.value].uri!, controller.playIndex.value);
                                  controller.isPlaying(true);
                                }
                              },
                              icon: controller.isPlaying.value
                                  ? const Icon(Icons.pause)
                                  : const Icon(Icons.play_arrow),
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
        error: (e, __) => Center(
          child: Text(e.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
