import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_music/controller/player_controller.dart';
import 'package:local_music/views/video_tab/video_tab.dart';

part 'videourl_state.dart';

class VideourlCubit extends Cubit<VideourlState> {
  VideourlCubit() : super(VideourlInitial());
  final controller = PlayerController();
  Future<void> fetchUrls() async{
    try{
      emit(VideourlLoading());
      final data =  await controller.videoQuery.getVideoThumbnail(strings[0]);
      emit(VideourlSuccess(urls: data));
    }
    catch (e){
      emit(VideourlError("Error In Cubit"));
    }
  }
}


