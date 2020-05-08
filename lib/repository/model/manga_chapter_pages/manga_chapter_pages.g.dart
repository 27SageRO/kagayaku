// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_chapter_pages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaChapterPages _$MangaChapterPagesFromJson(Map<String, dynamic> json) {
  return MangaChapterPages(
    id: json['id'] as String,
    pages: (json['pages'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$MangaChapterPagesToJson(MangaChapterPages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pages': instance.pages,
    };
