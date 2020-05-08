// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaInfo _$MangaInfoFromJson(Map<String, dynamic> json) {
  return MangaInfo(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    author: json['author'] as String,
    imgUrl: json['imgUrl'] as String,
    score: (json['score'] as num)?.toDouble(),
    chapters: (json['chapters'] as List)
        ?.map((e) =>
            e == null ? null : MangaChapter.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MangaInfoToJson(MangaInfo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imgUrl': instance.imgUrl,
      'author': instance.author,
      'score': instance.score,
      'chapters': instance.chapters,
    };
