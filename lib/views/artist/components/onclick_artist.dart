import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:local_music/const/style.dart';
import 'package:local_music/state_management/riverpod/artist_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistSongs extends ConsumerWidget {
  const ArtistSongs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(getArtistSongsProvider);
    return data.when(
      data: (data) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final songInfo = data[index];
              return Slidable(
                key: Key(songInfo.title),
                endActionPane: ActionPane(
                  motion: const StretchMotion(),

                  children: [
                    SlidableAction(
                      onPressed: (_) {},
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      icon: Icons.favorite,
                      label: 'Favorite',
                    ),
                    SlidableAction(
                      onPressed: (_) {},
                      backgroundColor: const Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.share,
                      label: 'Share',
                    ),
                  ],
                ),
                child: ListTile(
                  leading: QueryArtworkWidget(
                    id: songInfo.id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const Icon(Icons.image, size: 32),
                  ),
                  title: Text(songInfo.displayNameWOExt,
                      maxLines: 1, style: Style().songTitleStyle),
                  subtitle: Text(songInfo.artist!, style: Style().artistStyle),
                  trailing: index == 0 ? const Icon(Icons.play_arrow) : null,
                  
                ),
              );
            },
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
