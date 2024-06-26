import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:local_music/state_management/riverpod/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SwiperWidget extends ConsumerWidget {
  const SwiperWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(allSongsProvider);
    return data.when(
      data: (data) => SizedBox(
        height: MediaQuery.of(context).size.height / 2 - 100,
        child: Swiper(
          itemWidth: 300,
          itemHeight: 300,
          layout: SwiperLayout.DEFAULT,
        
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            final songInfo = data[index*10];
            debugPrint("songInfo::::::: ${songInfo.artist.toString()}");
            return InkWell(
              onTap: (){

              },
              child: Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.blue[100 * index],
                child: QueryArtworkWidget(
                  id: songInfo.id,
                  type: ArtworkType.AUDIO,
                  artworkWidth: 300.0,
                  artworkHeight: 300.0,
                  // size: 512,
                  artworkBorder: BorderRadius.zero,
                ),
                // child: Text(songInfo.getMap.toString()),
              ),
            );
          },
        ),
      ),
      error: (error, __) => Text(error.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
