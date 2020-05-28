import 'package:http/http.dart';
import 'repository.dart';

abstract class Omise {
  Future<Response> getHTTPS(String path, {String url});
  Future<List<Manga>> getPopularManga({int page});
  Future<MangaInfo> getMangaInfo(String id);
  Future<MangaChapterPages> getMangaChapterPages(String id, {String mangaId});
  Future<String> getMangaChapterImage(String pageUrl);
}

abstract class OmiseParser {
  List<Manga> parsePopularManga(Response response, {String id});
  MangaInfo parseMangaInfo(Response response, {String id});
  MangaChapterPages parseMangaChapterPages(Response response, {String id});
  String parseMangaChapterImage(Response response);
}
