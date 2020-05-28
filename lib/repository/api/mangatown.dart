import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kagayaku/repository/repository.dart';

class _Config {
  static String source = 'MangaTown';
  static String url = 'mangatown.com';
  static Duration timeout = Duration(seconds: 12);
}

class MangaTown extends Omise {
  final OmiseParser _parser = _Parser();

  @override
  Future<Response> getHTTPS(String path, {String url}) async {
    final uri = Uri.https(_Config.url, path);
    print(uri.toString());
    final res = await http.get(url ?? uri).timeout(_Config.timeout);
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
  Future<List<Manga>> getPopularManga({int page}) async {
    final res = await getHTTPS('hot/$page.htm');
    return _parser.parsePopularManga(res);
  }

  @override
  Future<MangaInfo> getMangaInfo(String id) async {
    final res = await getHTTPS('manga/$id');
    return _parser.parseMangaInfo(res, id: id);
  }

  @override
  Future<MangaChapterPages> getMangaChapterPages(String id,
      {String mangaId}) async {
    final res = await getHTTPS('manga/$mangaId/$id');
    return _parser.parseMangaChapterPages(res, id: id);
  }

  @override
  Future<String> getMangaChapterImage(String pageUrl) async {
    final res = await getHTTPS(pageUrl);
    return _parser.parseMangaChapterImage(res);
  }
}

class _Parser extends OmiseParser {
  @override
  List<Manga> parsePopularManga(Response response, {String id}) {
    final mangaList = <Manga>[];
    final doc = parse(response.body);
    final parent = doc.querySelector('ul.manga_pic_list');
    parent.children.forEach((o) {
      final link = o.children[0].attributes['href'];
      final id = link.substring(7, link.length - 1);
      final title = o.children[0].attributes['title'];
      final imgUrl = o.children[0].children[0].attributes['src'];
      final recentChapter =
          o.getElementsByClassName('color_0077')[0].text.trim();
      final score = double.parse(o
          .getElementsByClassName('score')[0]
          .children[5]
          .text
          .replaceAll(',', '.'));
      mangaList.add(Manga(
        id: id,
        title: title,
        imgUrl: imgUrl,
        recentChapter: recentChapter,
        score: score,
      ));
    });
    return mangaList;
  }

  @override
  MangaInfo parseMangaInfo(Response response, {String id}) {
    final doc = parse(response.body);
    final title = doc.querySelector('h1.title-top').text;
    final description = doc.getElementById('show').text.replaceAll('HIDE', '');
    final imgUrl =
        doc.querySelector('div.detail_info').children[0].attributes['src'];
    final author = doc.querySelector('a.color_0077').text;

    final chapterListDoc =
        doc.querySelector('ul.chapter_list').getElementsByTagName('li');

    final chapters = <MangaChapter>[];

    chapterListDoc.forEach((o) {
      final children = o.children;
      final link = children[0].attributes['href'];
      final chapter = MangaChapter(
        id: link.substring(link.lastIndexOf('/c') + 1, link.length - 1),
        title: children[1].text,
        chapter: children[0].text,
      );
      chapters.add(chapter);
    });

    return MangaInfo(
      id: id,
      title: title,
      description: description,
      imgUrl: imgUrl,
      author: author,
      chapters: chapters,
    );
  }

  @override
  MangaChapterPages parseMangaChapterPages(Response response, {String id}) {
    final doc = parse(response.body);
    final values = doc
        .querySelector('div.page_select')
        .querySelector('select')
        .children
        .map((e) => e.attributes['value']);
    return MangaChapterPages(id: id, pages: values.toList());
  }

  @override
  String parseMangaChapterImage(Response response) {
    final doc = parse(response.body);
    final imgUrl = doc.querySelector('img#image').attributes['src'];
    return imgUrl.substring(2);
  }
}
