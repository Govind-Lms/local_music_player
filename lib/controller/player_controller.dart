import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_storage_query/video_storage_query.dart';

class PlayerController extends GetxController{


  final videoQuery = VideoStorageQuery();
  var path = ''.obs;


  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  var  playIndex = 0.obs;
  var isPlaying = false.obs;
  var isRepeat = false.obs;
  

  var isShuffle = false.obs;

  var position= ''.obs;
  var duration = ''.obs;
  var max = 0.0.obs;
  var value = 0.0.obs;

  updatePosition() {
    audioPlayer.durationStream.listen((d) { 
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });
     audioPlayer.positionStream.listen((p) { 
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  

  changeDuration(seconds) {
    final duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }
  
  checkPermission () async{
    final status = await Permission.manageExternalStorage.request();
    if(status.isGranted){
      
    }
    else{
      checkPermission();
    }
  }

  playSong(String uri, index) {
    playIndex.value = index;
    try{
      audioPlayer
        .setAudioSource(AudioSource.uri(Uri.parse(uri)));
      // audioPlayer.shuffle();
      audioPlayer
        .play();
      isPlaying(true);
      updatePosition();
    }
    on Exception catch(e){
      print("Audio Player Error : $e");
    }
  }
  getThumbnails(path)async{
    path.value = path;
    final data  = await videoQuery.getVideoThumbnail(path);
    return data;
  }
  


  playShuffleSong() {
       audioPlayer.setShuffleModeEnabled(true);
  }

  

}