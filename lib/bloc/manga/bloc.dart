import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagayaku/bloc/B.dart';
import 'package:kagayaku/repository/repository.dart';

class MangaBloc extends Bloc<MangaEvent, MangaState> {
  final Omise omise;

  MangaBloc(this.omise);

  @override
  MangaState get initialState => MangaLoading();

  @override
  Stream<MangaState> mapEventToState(MangaEvent event) async* {
    if (event is MangaFetch) {
      try {
        final mangaInfo = await omise.getMangaInfo(event.id);
        yield MangaSuccess(mangaInfo: mangaInfo);
      } catch (e) {
        yield MangaError();
      }
    }
  }
}
