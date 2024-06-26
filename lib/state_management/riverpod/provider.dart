import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_music/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

final songUriProvider = StateProvider((ref) => "");
final songIndexProvider = StateProvider((ref) => 0);
final albumNameProvider = StateProvider((ref) => "");

final lastPlaySongProvider = StateProvider((ref) => "");

final audioPlayerProvider = FutureProvider((ref) {
  final uri = ref.watch(songUriProvider);
  final index = ref.watch(songIndexProvider);
  PlayerController().playSong(uri, index);
});

final allSongsProvider = FutureProvider((ref) {
  final data = PlayerController().audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.DESC_OR_GREATER,
        sortType: SongSortType.DATE_ADDED,
        uriType: UriType.EXTERNAL,
      );
  return data;
});

final albumProvider = FutureProvider((ref) {
  final data = PlayerController().audioQuery.queryAlbums(
        ignoreCase: null,
        orderType: null,
        sortType: null,
        uriType: null,
      );
  return data;
});

final getSongsFromAlbumProvider = FutureProvider((ref) {
  final albumName = ref.watch(albumNameProvider);
  final data = PlayerController().audioQuery.queryAudiosFrom(
        AudiosFromType.ALBUM,
        albumName,
      );
  return data;
});
