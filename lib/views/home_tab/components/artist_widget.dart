import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:local_music/const/style.dart';
import 'package:local_music/state_management/riverpod/artist_provider.dart';
import 'package:local_music/views/artist/artist_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistWidget extends ConsumerWidget {
  const ArtistWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(artistProvider);
    return data.when(
      data: (data) => Flexible(
        child: SizedBox(
          height: 145,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Artists",
                    style: Style().songTitleStyle,
                  ),
                  TextButton(
                      onPressed: () {
                        ///
                      },
                      child: Text("More", style: Style().songTitleStyle)),
                ],
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    final artistData = data[index * 10];
                    return InkWell(
                      onTap: (){
                        ref.read(artistNameProvider.notifier).state = artistData.artist;
                        Get.to(()=>  ArtistView(artistModel: artistData,),transition: Transition.downToUp);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        width: 76.0,
                        height: 76.0,
                        child: QueryArtworkWidget(
                          id: artistData.id,
                          type: ArtworkType.ARTIST,
                          artworkHeight: 100.0,
                          artworkBorder: BorderRadius.circular(100.0),
                          artworkWidth: 100.0,
                          artworkFit: BoxFit.fitHeight,
                          size: 512,
                          nullArtworkWidget: const CircleAvatar(
                              radius: 38,
                              child: Icon(
                                Icons.person,
                                size: 50.0,
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      error: (error, __) => Text(error.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
