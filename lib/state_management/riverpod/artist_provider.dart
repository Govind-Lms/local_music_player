
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_music/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

final artistProvider = FutureProvider((ref) {
  final data = PlayerController().audioQuery.queryArtists();
  return data;
});

final artistNameProvider = StateProvider<String>((ref) => "");

final getArtistSongsProvider = FutureProvider((ref) {
  final artist = ref.watch(artistNameProvider);
  final data = PlayerController().audioQuery.queryAudiosFrom(
    AudiosFromType.ARTIST,
    artist);
  return data;
});