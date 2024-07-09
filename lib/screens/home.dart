import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/controllers/player_controller.dart';
import 'package:music_player_app/screens/player.dart';
import 'package:music_player_app/utils/colors.dart';
import 'package:music_player_app/utils/text_style.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  var controller = Get.put(PlayerController());
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  List<SongModel> allSongs = [];
  List<SongModel> filteredSongs = [];

  @override
  void initState() {
    super.initState();
    fetchSongs();
  }

  void fetchSongs() async {
    var songs = await controller.audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
    setState(() {
      allSongs = songs;
      filteredSongs = songs;
    });
  }

  void filterSongs(String query) {
    String normalizedQuery = query.replaceAll('_', ' ').toLowerCase();
    setState(() {
      filteredSongs = allSongs
          .where((song) =>
              song.displayNameWOExt
                  .replaceAll('_', ' ')
                  .toLowerCase()
                  .contains(normalizedQuery) ||
              (song.artist != null &&
                  song.artist!
                      .replaceAll('_', ' ')
                      .toLowerCase()
                      .contains(normalizedQuery)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      searchController.clear();
                      filterSongs('');
                    });
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: whiteColor,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: const Icon(
                    Icons.search,
                    color: whiteColor,
                  ),
                )
        ],
        leading: const Icon(
          Icons.sort_rounded,
          color: whiteColor,
        ),
        title: isSearching
            ? TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: textStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                autofocus: true,
                style: textStyle(color: whiteColor),
                onChanged: filterSongs,
              )
            : Text(
                'Music Library',
                style: textStyle(
                  fontFamily: 'ChakraPetch',
                  fontWeight: FontWeight.bold,
                  size: 18,
                  color: whiteColor,
                ),
              ),
      ),
      body: filteredSongs.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: filteredSongs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(
                      () => ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: bgColor,
                        title: Text(
                          filteredSongs[index].displayNameWOExt,
                          style: textStyle(
                            size: 15,
                            color: whiteColor,
                            fontFamily: 'ChakraPetch',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          '${filteredSongs[index].artist}',
                          style: textStyle(
                              size: 12,
                              color: whiteColor,
                              fontFamily: 'ChakraPetch',
                              fontWeight: FontWeight.normal),
                        ),
                        leading: QueryArtworkWidget(
                          id: filteredSongs[index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(
                            Icons.music_note,
                            color: whiteColor,
                            size: 32,
                          ),
                        ),
                        trailing: controller.playIndex.value == index &&
                                controller.isPlaying.value
                            ? const Icon(
                                Icons.play_arrow,
                                color: whiteColor,
                                size: 26,
                              )
                            : null,
                        onTap: () {
                          Get.to(
                            () => Player(
                              data: filteredSongs,
                            ),
                          );
                          controller.playSong(filteredSongs[index].uri, index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
