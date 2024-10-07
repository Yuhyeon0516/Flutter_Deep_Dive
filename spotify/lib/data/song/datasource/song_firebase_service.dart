import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify/data/song/models/song.dart';
import 'package:spotify/domain/song/entities/song.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
}

class SongFirebaseServiceImpl implements SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      final List<SongEntity> songs = [];

      final data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      for (var e in data.docs) {
        final songModel = SongModel.fromJson(e.data());

        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return const Left('Error Occurred');
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      final List<SongEntity> songs = [];

      final data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();

      for (var e in data.docs) {
        final songModel = SongModel.fromJson(e.data());

        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return const Left('Error Occurred');
    }
  }
}
