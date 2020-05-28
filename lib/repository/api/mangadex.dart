import 'dart:convert';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kagayaku/repository/repository.dart';

class _Config {
  static String source = 'MangaDex';
  static String url = 'mangadex.org';
  static Duration timeout = Duration(seconds: 12);
  static Object queryParams = {
    'lang_code': 'gb',
  };
}

class MangaDex extends Omise {
  final OmiseParser _parser = _Parser();

  @override
  Future<http.Response> getHTTPS(String path, {String url}) async {
    final uri = Uri.https(_Config.url, path, _Config.queryParams);
    print(uri.toString());
    final res = await http.get(uri).timeout(_Config.timeout);
    if (res.statusCode == 503 ||
        res.statusCode == 502 ||
        res.statusCode == 403) {
      throw ('${_Config.source} is currently in DDOS mitigation mode. (Status code ${res.statusCode})');
    } else if (res.statusCode == 500) {
      throw ('${_Config.source} is currently unavailable. (Status code 500)');
    } else if (res.statusCode == 404) {
      throw ('Cannot reach ${_Config.source} (404).');
    }
    return res;
  }

  @override
  Future<List<Manga>> getPopularManga({int page = 1}) async {
    final res = await getHTTPS('titles/9/$page');
    return _parser.parsePopularManga(res);
  }

  @override
  Future<MangaInfo> getMangaInfo(String id) async {
    final res = await getHTTPS('api/manga/$id');
    return _parser.parseMangaInfo(res, id: id);
  }

  @override
  Future<MangaChapterPages> getMangaChapterPages(String id,
      {String mangaId}) async {
    final res = await getHTTPS('api/chapter/$id');
    return _parser.parseMangaChapterPages(res, id: id);
  }

  @override
  Future<String> getMangaChapterImage(String pageUrl) async {
    return pageUrl;
  }
}

class _Parser extends OmiseParser {
  @override
  List<Manga> parsePopularManga(Response response, {String id}) {
    final mangaList = <Manga>[];
    final doc = parse(response.body);
    final entries = doc.querySelectorAll('div.manga-entry');
    entries.forEach((o) {
      // Parse each values
      final id = o.attributes['data-id'];
      final title = o.getElementsByClassName('manga_title')[0].text;
      final imgUrl =
          _Config.url + o.querySelector('img.rounded').attributes['src'];

      final ratingElem =
          o.querySelector('ul.list-inline').children[0].children[2];
      final score = double.parse(ratingElem.innerHtml);
      // Create Manga instance
      mangaList.add(Manga(
        id: id,
        title: title,
        imgUrl: 'https://www.' + imgUrl,
        score: score,
      ));
    });
    // Build
    return mangaList;
  }

  @override
  MangaInfo parseMangaInfo(Response response, {String id}) {
    // final data = json.decode(doc.text);
    final decodedJson = json.decode(response.body);
    final mangaJson = decodedJson['manga'];
    final chaptersJson = decodedJson['chapter'];

    final chapters = <MangaChapter>[];

    for (String k in chaptersJson.keys) {
      if (chaptersJson[k]['lang_code'] != 'gb') {
        continue;
      }

      final chapter = MangaChapter(
        id: k,
        chapter: chaptersJson[k]['chapter'],
        title: chaptersJson[k]['title'],
        volume: chaptersJson[k]['volume'],
      );
      chapters.add(chapter);
    }

    return MangaInfo(
      id: id,
      title: mangaJson['title'],
      description: mangaJson['description'],
      imgUrl: _Config.url + mangaJson['cover_url'],
      author: mangaJson['author'],
      chapters: chapters,
    );
  }

  @override
  MangaChapterPages parseMangaChapterPages(http.Response response,
      {String id}) {
    final decodedJson = json.decode(response.body);
    final pagesJson = decodedJson['page_array'];
    final server = decodedJson['server'];
    final hash = decodedJson['hash'];

    var pages = <String>[];

    for (final page in pagesJson) {
      pages.add('$server$hash/$page');
    }
    return MangaChapterPages(id: id, pages: pages);
  }

  @override
  String parseMangaChapterImage(Response response) {
    throw UnimplementedError();
  }
}
