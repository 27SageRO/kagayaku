import 'package:equatable/equatable.dart';
import 'package:kagayaku/repository/omise.dart';
import 'package:kagayaku/res/R.dart';

abstract class SettingsEvent extends Equatable {}

class SettingsChanged extends SettingsEvent {
  final AppTheme appTheme;
  final Omise omise;

  SettingsChanged({this.appTheme, this.omise});

  @override
  List<Object> get props => [appTheme, omise];
}
