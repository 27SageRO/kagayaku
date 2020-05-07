import 'package:built_collection/built_collection.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:kagayaku/repository/repository.dart';

class _Config {
  static String url = 'mangadex.org';
  static Duration timeout = Duration(seconds: 12);
  static Object queryParams = {
    'lang_id': 'gb',
  };
}

class MangaDex extends Omise {
  final OmiseParser _parser = new _Parser();

  @override
  Future<http.Response> getHTTPS(String path) async {
    final uri = Uri.https(_Config.url, path, _Config.queryParams);
    final res = await http.get(uri).timeout(_Config.timeout);
    if (res.statusCode == 503 ||
        res.statusCode == 502 ||
        res.statusCode == 403) {
      throw ('MangaDex is currently in DDOS mitigation mode. (Status code ${res.statusCode})');
    } else if (res.statusCode == 500) {
      throw ('MangaDex is currently unavailable. (Status code 500)');
    } else if (res.statusCode == 404) {
      throw ('Cannot reach Mangadex.org (404).');
    }
    return res;
  }

  @override
  Future<BuiltList<Manga>> getPopularManga({int page = 1}) async {
    final res = await getHTTPS('titles/9/$page');
    final doc = parse(res.body);
    return _parser.parsePopularManga(doc);
  }
}

class _Parser extends OmiseParser {
  @override
  BuiltList<Manga> parsePopularManga(Document doc) {
    var listBuilder = BuiltList<Manga>().toBuilder();
    final entries = doc.querySelectorAll('div.manga-entry');
    entries.forEach((o) {
      // Parse each values
      final int id = int.parse(o.attributes['data-id']);
      final String title = o.getElementsByClassName('manga_title')[0].text;
      final String imgUrl = _Config.url +
          o
              .querySelector('img.rounded')
              .attributes['src']
              .replaceAll('.large', '');
      final String description = o.children[o.children.length - 1].text;

      final ratingElem =
          o.querySelector('ul.list-inline').children[0].children[2];
      final double score = double.parse(ratingElem.innerHtml);
      // Create Manga instance
      listBuilder.add(Manga(
        id: id,
        title: title,
        imgUrl: imgUrl,
        description: description,
        score: score,
      ));
    });
    // Build
    return listBuilder.build();
  }
}
