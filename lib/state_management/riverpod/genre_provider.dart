
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_music/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

final genreNameProvider = StateProvider((ref) => "");

final genreProvider = FutureProvider((ref) {
  final data = PlayerController().audioQuery.queryGenres();
  return data;
});


final getSongsFromGenreProvider = FutureProvider((ref) {
  final genreName = ref.watch(genreNameProvider);
  final data  = PlayerController().audioQuery.queryAudiosFrom(
    AudiosFromType.ALBUM,
    genreName,
  );
  return data;
});


