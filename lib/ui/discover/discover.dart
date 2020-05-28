import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagayaku/bloc/B.dart';
import 'package:kagayaku/ui/discover/widget/popular_manga.dart';

class DiscoverUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverBloc, DiscoverState>(
      builder: (context, DiscoverState discoverState) {
        final theme = CupertinoTheme.of(context);

        if (discoverState is DiscoverLoading) {
          BlocProvider.of<DiscoverBloc>(context).add(DiscoverFetch());
        }

        return CupertinoPageScaffold(
          child: CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                transitionBetweenRoutes: false,
                border: Border.all(color: theme.scaffoldBackgroundColor),
                backgroundColor: theme.scaffoldBackgroundColor,
                automaticallyImplyLeading: false,
                largeTitle: Text('Discover'),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SearchBar(),
              ),
              if (discoverState is DiscoverLoading)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
              if (discoverState is DiscoverSuccess)
                PopularManga(state: discoverState),
            ],
          ),
        );
      },
    );
  }
}

class _SearchBar extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 38;

  @override
  double get maxExtent => 38;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = CupertinoTheme.of(context);
    return SizedBox.expand(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: theme.barBackgroundColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                CupertinoIcons.search,
                color: CupertinoColors.systemGrey,
                size: 22,
              ),
            ),
            Flexible(
              child: CupertinoTextField(
                style: TextStyle(fontSize: 16),
                clearButtonMode: OverlayVisibilityMode.editing,
                decoration: BoxDecoration(color: Colors.transparent),
                placeholder: 'Search your favorite manga',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_SearchBar oldDelegate) => true;
}
