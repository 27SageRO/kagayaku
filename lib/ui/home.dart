import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagayaku/bloc/B.dart';
import 'package:kagayaku/ui/ui.dart';

class HomeUi extends StatelessWidget {
  static const String routeName = 'HomeUi';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (BuildContext context, SettingsState state) {
        return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                title: Text('Discover'),
                icon: Icon(CupertinoIcons.search),
              ),
              BottomNavigationBarItem(
                title: Text('More'),
                icon: Icon(CupertinoIcons.ellipsis),
              ),
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return BlocProvider(
                  create: (_) => DiscoverBloc(state.omise),
                  child: DiscoverUi(),
                );
              case 1:
                return SettingsUi();
              default:
                return null;
            }
          },
        );
      },
    );
  }
}
