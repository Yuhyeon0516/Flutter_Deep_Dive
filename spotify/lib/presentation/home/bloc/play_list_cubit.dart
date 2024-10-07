import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/song/usecases/get_play_list.dart';
import 'package:spotify/presentation/home/bloc/play_list_state.dart';
import 'package:spotify/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoadingState());

  Future<void> getPlayList() async {
    final retunredSongs = await sl<GetPlayListUsecase>().call();

    retunredSongs.fold(
      (l) {
        emit(PlayListFailureState());
      },
      (r) {
        emit(PlayListLoadedState(songs: r));
      },
    );
  }
}
