import 'package:get_it/get_it.dart';
import 'package:spotify/data/auth/datasource/auth_firebase_service.dart';
import 'package:spotify/data/auth/repositories/auth_repository_impl.dart';
import 'package:spotify/data/song/datasource/song_firebase_service.dart';
import 'package:spotify/data/song/repositories/song_repository_impl.dart';
import 'package:spotify/domain/auth/repositories/auth.dart';
import 'package:spotify/domain/auth/usecases/signin.dart';
import 'package:spotify/domain/auth/usecases/signup.dart';
import 'package:spotify/domain/song/repositories/song.dart';
import 'package:spotify/domain/song/usecases/get_news_songs_usecase.dart';
import 'package:spotify/domain/song/usecases/get_play_list.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongRepository>(SongRepositoryImpl());

  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<SigninUsecase>(SigninUsecase());
  sl.registerSingleton<GetNewsSongsUsecase>(GetNewsSongsUsecase());
  sl.registerSingleton<GetPlayListUsecase>(GetPlayListUsecase());
}
