import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:kagayaku/bloc/B.dart';
import 'package:kagayaku/repository/repository.dart';
import 'package:kagayaku/res/theme.dart';

class SettingsUi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsUiState();
  }
}

class _SettingsUiState extends State<SettingsUi> {
  SettingsBloc _settingsBloc;

  @override
  void initState() {
    super.initState();
    _settingsBloc = BlocProvider.of<SettingsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return CupertinoPageScaffold(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CupertinoSliverNavigationBar(
                  transitionBetweenRoutes: false,
                  brightness: state.appTheme == AppTheme.Light
                      ? Brightness.light
                      : Brightness.dark,
                  backgroundColor: Colors.transparent,
                  largeTitle: Text(
                    'Settings',
                  ),
                ),
              ];
            },
            body: _buildWithSettingsState(context, state),
          ),
        );
      },
    );
  }

  Widget _buildWithSettingsState(BuildContext context, SettingsState state) {
    return CupertinoSettings(
      items: <Widget>[
        CSControl(
          nameWidget: Text('Dark Mode'),
          contentWidget: CupertinoSwitch(
            value: state.appTheme == AppTheme.Dark,
            onChanged: _handleOnThemeChange,
          ),
        ),
        const CSDescription(
          'Using dark mode extends battery life on devices with OLED display',
        ),
        const CSHeader('Manga Source'),
        CSSelection<int>(
          items: const <CSSelectionItem<int>>[
            CSSelectionItem<int>(text: 'MangaDex', value: 0),
            CSSelectionItem<int>(text: 'MangaTown', value: 1),
          ],
          onSelected: (value) => _handleOnSelectSource(value, state),
          currentSelection: 0,
        ),
        const CSDescription('Choose your preferred manga source.'),
      ],
    );
  }

  void _handleOnSelectSource(int value, SettingsState state) {
    if (value == 0 && state.omise is! MangaDex) {
      _settingsBloc.add(SettingsChanged(omise: MangaDex()));
    } else if (value == 1 && state.omise is! MangaTown) {
      _settingsBloc.add(SettingsChanged(omise: MangaTown()));
    }
  }

  void _handleOnThemeChange(bool value) {
    if (!value) {
      _settingsBloc.add(SettingsChanged(appTheme: AppTheme.Light));
    } else {
      _settingsBloc.add(SettingsChanged(appTheme: AppTheme.Dark));
    }
  }
}
