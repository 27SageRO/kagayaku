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
    List<Manga> popularManga;
    MangaInfo mangaInfo;
    MangaChapterPages mangaChapterPages;

    test('Popular manga', () async {
      popularManga = await omise.getPopularManga(page: 1);
      expect(popularManga.isNotEmpty, true);
      print(popularManga[0].toString());
    });

    test('Manga info', () async {
      mangaInfo = await omise.getMangaInfo(popularManga[0].id);
      expect(mangaInfo.chapters.isNotEmpty, true);
      print(mangaInfo);
    });

    test('Manga chapter pages', () async {
      mangaChapterPages = await omise.getMangaChapterPages(mangaInfo.chapters[0].id, mangaId: mangaInfo.id);
      expect(mangaChapterPages.pages.isNotEmpty, true);
      print(mangaChapterPages);
    });

    test('Manga get chapter image', () async {
      final image = await omise.getMangaChapterImage(mangaChapterPages.pages[0]);
      expect(image != null, true);
      print(image);
    });
  });
}
