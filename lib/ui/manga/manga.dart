import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagayaku/bloc/B.dart';

class MangaUiArgs {
  final String id;
  MangaUiArgs({this.id});
}

class MangaUi extends StatelessWidget {
  static const routeName = 'MangaUi';

  final String id;

  const MangaUi({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: 'Back',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      child: BlocBuilder<MangaBloc, MangaState>(
        builder: (BuildContext context, MangaState state) {
          if (state is MangaLoading) {
            BlocProvider.of<MangaBloc>(context).add(MangaFetch(id: id));
          }

          if (state is MangaSuccess) {
            print(state.mangaInfo);
          }

          return Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}
