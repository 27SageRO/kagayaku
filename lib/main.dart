import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagayaku/res/R.dart';
import 'package:kagayaku/ui/ui.dart';
import 'bloc/B.dart';

void main() {
  BlocSupervisor.delegate = _SimpleBlocDelegate();
  runApp(Kagayaku());

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}

class Kagayaku extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsBloc(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          setStatusBarColor(state);
          return CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: appThemeData[state.appTheme],
            initialRoute: HomeUi.routeName,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case MangaUi.routeName:
                  final MangaUiArgs args = settings.arguments;
                  return CupertinoPageRoute(
                    maintainState: true,
                    builder: (_) => BlocProvider(
                      create: (_) => MangaBloc(state.omise),
                      child: MangaUi(id: args.id),
                    ),
                    settings: settings,
                  );
                case HomeUi.routeName:
                  return CupertinoPageRoute(
                    builder: (_) => HomeUi(),
                    settings: settings,
                  );
                default:
                  return null;
              }
            },
          );
        },
      ),
    );
  }

  void setStatusBarColor(SettingsState state) {
    if (state.appTheme == AppTheme.Dark) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      );
    } else if (state.appTheme == AppTheme.Light) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      );
    }
  }
}

class _SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    print(error);
    super.onError(bloc, error, stacktrace);
  }
}
