import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'repository.dart';
import 'package:built_collection/built_collection.dart';

abstract class Omise {
  Future<http.Response> getHTTPS(String path);
  Future<BuiltList<Manga>> getPopularManga({int page});
}

abstract class OmiseParser {
  BuiltList<Manga> parsePopularManga(Document doc);
}

