import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagayaku/repository/repository.dart';

import '../B.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final Omise omise;

  DiscoverBloc(this.omise);

  @override
  DiscoverState get initialState => DiscoverLoading();

  @override
  Stream<DiscoverState> mapEventToState(DiscoverEvent event) async* {
    if (event is DiscoverFetch) {
      try {
        final resp = await omise.getPopularManga(page: 1);
        yield DiscoverSuccess(popularManga: resp);
      } catch (e) {
        yield DiscoverError(error: e);
      } finally {
        return;
      }
    }
  }
}
