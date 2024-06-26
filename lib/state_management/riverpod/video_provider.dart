import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_music/controller/player_controller.dart';
var controller = PlayerController();
final videoDataProvider = FutureProvider((ref) async{
  controller = PlayerController();
  final data = controller.videoQuery.queryVideos();
  return data;
});

final videoPathProvider = StateProvider((ref) => "");


final videoThumbnailProvider = FutureProvider((ref) {
  controller = PlayerController();
  final path =  ref.watch(videoPathProvider);
  final data =  controller.videoQuery.getVideoThumbnail(path);
  return data;
});
