import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/song/repositories/song.dart';
import 'package:spotify/service_locator.dart';

class GetNewsSongsUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return sl<SongRepository>().getNewsSongs();
  }
}
