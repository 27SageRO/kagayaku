import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagayaku/repository/api/mangadex.dart';
import 'package:kagayaku/bloc/B.dart';
import 'package:kagayaku/res/R.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  @override
  SettingsState get initialState =>
      SettingsState(appTheme: AppTheme.Dark, omise: MangaDex());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsChanged) {
      yield state.copyWith(
        appTheme: event.appTheme,
        omise: event.omise,
      );
    }
  }
}
