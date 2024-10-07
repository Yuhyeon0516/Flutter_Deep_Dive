import 'package:dartz/dartz.dart';
import 'package:spotify/data/song/datasource/song_firebase_service.dart';
import 'package:spotify/domain/song/repositories/song.dart';
import 'package:spotify/service_locator.dart';

class SongRepositoryImpl implements SongRepository {
  @override
  Future<Either> getNewsSongs() {
    return sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() {
    return sl<SongFirebaseService>().getPlayList();
  }
}
