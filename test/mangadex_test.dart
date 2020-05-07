// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:kagayaku/repository/repository.dart';

void main() {
  Omise omise;

  setUpAll(() {
    omise = MangaDex();
  });

  group('Mangadex test', () {
    /*test('Anime info', () async {
      var anime = await jikan.getAnimeInfo(1);
      expect(anime.title, 'Cowboy Bebop');
      expect(anime.genres.first.name, 'Action');
      expect(anime.studios.first.name, 'Sunrise');
    }); */

    test('Popular manga', () async {
      final resp = await omise.getPopularManga(page: 1);
      expect(resp.length, 40);
      print(resp[0].toString());
    });
  });
}
