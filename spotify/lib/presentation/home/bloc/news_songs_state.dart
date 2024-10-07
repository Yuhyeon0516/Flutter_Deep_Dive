import 'package:spotify/domain/song/entities/song.dart';

abstract class NewsSongsState {}

class NewsSongsLoadingState extends NewsSongsState {}

class NewsSongsLoadedState extends NewsSongsState {
  final List<SongEntity> songs;

  NewsSongsLoadedState({
    required this.songs,
  });
}

class NewsSongsFailureState extends NewsSongsState {}
