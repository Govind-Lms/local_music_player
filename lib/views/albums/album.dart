import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:local_music/const/style.dart';
import 'package:local_music/state_management/riverpod/provider.dart';
import 'package:local_music/views/albums/onclick_album.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumView extends ConsumerStatefulWidget {
  const AlbumView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AlbumViewState();
}

class _AlbumViewState extends ConsumerState<AlbumView> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(albumProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Video',
          style: Style().songTitleStyle,
        ),
      ),
      body: data.when(
        data: (data){
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final albumData = data[index];
              return Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const[
                    BoxShadow(
                      offset: Offset(3,3),
                      color: Colors.black12,
                    )
                  ]
                ),
                child: InkWell(
                  onTap: (){
                    ref.read(albumNameProvider.notifier).state = albumData.album;
                    debugPrint("Album Name ${albumNameProvider.notifier}");
                    Get.to(()=>OnClickAlbum(albumModel: albumData));
                  },
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: QueryArtworkWidget(
                          id: albumData.id,
                          artworkBorder: BorderRadius.circular(10.0),
                          artworkWidth: MediaQuery.of(context).size.width,
                          type: ArtworkType.ALBUM,
                          nullArtworkWidget: const Center(child: Icon(Icons.image_not_supported)),
                        ),
                      ),
                      Expanded(flex: 1,child: Text(albumData.album.toString()))
                    ],
                  ),
                ),
              );
            },
          );
        },
        error: (error,__) {
          debugPrint(error.toString());
          return Text(error.toString());
        },
        loading: ()=> const Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
