import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/song/usecases/get_news_songs_usecase.dart';
import 'package:spotify/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoadingState());

  Future<void> getNewsSongs() async {
    final retunredSongs = await sl<GetNewsSongsUsecase>().call();

    retunredSongs.fold(
      (l) {
        emit(NewsSongsFailureState());
      },
      (r) {
        emit(NewsSongsLoadedState(songs: r));
      },
    );
  }
}
