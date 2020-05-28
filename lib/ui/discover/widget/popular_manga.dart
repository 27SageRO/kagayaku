import 'package:flutter/widgets.dart';
import 'package:kagayaku/bloc/B.dart';
import 'package:kagayaku/repository/repository.dart';
import 'package:kagayaku/ui/ui.dart';

class PopularManga extends StatelessWidget {
  final DiscoverSuccess state;

  const PopularManga({Key key, @required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('Popular Manga'),
          ),
          Container(
            height: 250,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              itemCount: state.popularManga.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final manga = state.popularManga[index];
                return _Manga(manga: manga);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Manga extends StatelessWidget {
  final Manga manga;

  const _Manga({Key key, @required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(
          context,
          MangaUi.routeName,
          arguments: MangaUiArgs(
            id: manga.id,
          ),
        )
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                manga.imgUrl,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                manga.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
