import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_music/const/style.dart';
import 'package:local_music/state_management/riverpod/genre_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GenreWidget extends ConsumerWidget {
  const GenreWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(genreProvider);
    return data.when(
      data: (data) {
        return Expanded(
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Genres",style: Style().songTitleStyle,),
                    TextButton(onPressed: () {
                      ///
                    },
                    child: Text("More",style: Style().songTitleStyle)),
                  ],
                ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  // controller: SwiperController(),
                  // pagination: SwiperPagination.dots,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final genreData = data[index];
                    return Column(
                      children: [
                        Container(
                          width: 75.0,
                          height: 75.0,
                          margin: const EdgeInsets.all(10.0),
                          child: QueryArtworkWidget(
                            artworkBorder: BorderRadius.zero,
                            id: genreData.id,
                            type: ArtworkType.GENRE,
                            nullArtworkWidget: const Placeholder(),
                            size: 512,
                          ),
                        ),
                        Text(genreData.genre)
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      error: (error, __) => Text(error.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
