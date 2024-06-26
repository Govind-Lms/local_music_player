// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:local_music/const/style.dart';
// import 'package:local_music/riverpod/provider.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class FavoriteWidget extends ConsumerWidget {
//   const FavoriteWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final data = ref.watch(allSongsProvider);
//     return data.when(
//       data: (data) { return
//         Expanded(
//           child: Column(
          
//             children: [
//               Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Favorites",style: Style().songTitleStyle,),
//                     TextButton(onPressed: () {
//                       ///
//                     },
//                     child: Text("More",style: Style().songTitleStyle)),
//                   ],
//                 ),
//               Flexible(
//                 flex: 9,
//                 child: Container(
//                   margin: const EdgeInsets.all(10.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     color: const Color.fromARGB(255, 245, 235, 247),
//                   ),
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: 10,
//                     itemBuilder: (BuildContext context, int index) {
//                       final songInfo = data[index*10 +1];
//                       return ListTile(
//                         leading: QueryArtworkWidget(
//                           id: songInfo.id,
//                           type: ArtworkType.AUDIO,
//                           nullArtworkWidget: const Icon(Icons.image, size: 32),
//                         ),
//                         title: Text(songInfo.displayNameWOExt,
//                             maxLines: 1, style: Style().songTitleStyle),
//                         subtitle: Text(songInfo.artist!, style: Style().artistStyle),
//                         trailing: index == 0 
//                             ? const Icon(Icons.play_arrow)
//                             : null,
//                         onTap: () {
//                           // ref.read(songUriProvider.state).state = songInfo.uri!;
//                           // ref.read(songIndexProvider.state).state = index;
//                           // ref.read(songPlayProvider);
//                           // Navigator.of(context).push(MaterialPageRoute(builder: (_)=> Player(songInfo: songInfo)));
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//       error: (error, __) => Text(error.toString()),
//       loading: () => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
