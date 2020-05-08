// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaChapter _$MangaChapterFromJson(Map<String, dynamic> json) {
  return MangaChapter(
    id: json['id'] as String,
    chapter: json['chapter'] as String,
    volume: json['volume'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$MangaChapterToJson(MangaChapter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chapter': instance.chapter,
      'volume': instance.volume,
      'title': instance.title,
    };
