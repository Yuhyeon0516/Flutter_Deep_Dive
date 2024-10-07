import 'package:spotify/domain/song/entities/song.dart';

abstract class PlayListState {}

class PlayListLoadingState extends PlayListState {}

class PlayListLoadedState extends PlayListState {
  final List<SongEntity> songs;

  PlayListLoadedState({
    required this.songs,
  });
}

class PlayListFailureState extends PlayListState {}
