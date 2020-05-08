// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Manga _$MangaFromJson(Map<String, dynamic> json) {
  return Manga(
    id: json['id'] as String,
    title: json['title'] as String,
    imgUrl: json['imgUrl'] as String,
    recentChapter: json['recentChapter'] as String,
    score: (json['score'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MangaToJson(Manga instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imgUrl': instance.imgUrl,
      'recentChapter': instance.recentChapter,
      'score': instance.score,
    };
