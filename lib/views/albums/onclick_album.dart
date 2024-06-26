import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:local_music/const/style.dart';
import 'package:local_music/state_management/riverpod/provider.dart';
import 'package:local_music/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class OnClickAlbum extends ConsumerStatefulWidget {
  final AlbumModel albumModel;
  const OnClickAlbum({super.key, required this.albumModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnClickAlbumState();
}

class _OnClickAlbumState extends ConsumerState<OnClickAlbum> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(getSongsFromAlbumProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.albumModel.album),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: QueryArtworkWidget(
              artworkBorder: BorderRadius.zero,
              artworkHeight: 300.0,
              artworkFit: BoxFit.fitHeight,
              artworkWidth: MediaQuery.of(context).size.width,
              size: 512,
              id: widget.albumModel.id,
              nullArtworkWidget: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width -50,
                    height: 300,
                    child: const Placeholder(),
                  )),
              type: ArtworkType.ALBUM,
            ),
          ),
          Text(widget.albumModel.album),
          Text(widget.albumModel.numOfSongs.toString()),
          Text(widget.albumModel.artist!.split(",")[0]),
          Expanded(
            child: data.when(
              data: (data){
                debugPrint(data.length.toString());
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final songData = data[index];
                    // return Text(widget.albumModel.getMap.toString().split(",")[index]);
                    return ListTile(
                      onTap: (){
                        // ignore: deprecated_member_use
                        ref.read(songUriProvider.state).state= songData.uri!;
                        // ignore: deprecated_member_use
                        ref.read(songIndexProvider.state).state= index;

                        ref.read(audioPlayerProvider);
                        Get.to(()=> Player(songInfo: data),);
                      },
                      leading: QueryArtworkWidget(
                        id: songData.id,
                        artworkBorder: BorderRadius.zero,
                        type: ArtworkType.AUDIO,
                      ),
                      title: Text(songData.displayNameWOExt,style: Style().songTitleStyle,),
                      subtitle: Text(songData.artist!,style: Style().artistStyle,),



                    );
                  },
                );
              },
              error: (error,__)=> Text(error.toString()),
              loading: ()=> const Center(child: CircularProgressIndicator.adaptive(),),
            ),
          )
        ],
      ),
    );
  }
}
