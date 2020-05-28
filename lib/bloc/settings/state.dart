import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:kagayaku/repository/repository.dart';
import 'package:kagayaku/res/R.dart';

class SettingsState extends Equatable {
  final AppTheme appTheme;
  final Omise omise;

  SettingsState({
    @required this.appTheme,
    @required this.omise,
  });

  SettingsState copyWith({
    AppTheme appTheme,
    Omise omise,
  }) {
    return SettingsState(
      appTheme: appTheme ?? this.appTheme,
      omise: omise ?? this.omise,
    );
  }

  @override
  List<Object> get props => [appTheme, omise];
}
