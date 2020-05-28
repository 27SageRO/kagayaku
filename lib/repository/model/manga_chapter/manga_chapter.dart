import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga_chapter.g.dart';

@JsonSerializable()
class MangaChapter extends Equatable {
  final String id;
  final String chapter;
  final String volume;
  final String title;

  MangaChapter({
    this.id,
    this.chapter,
    this.volume,
    this.title,
  });

  factory MangaChapter.fromJson(Map<String, dynamic> json) =>
      _$MangaChapterFromJson(json);

  Map<String, dynamic> toJson() => _$MangaChapterToJson(this);

  @override
  String toString() =>
      '\nid: $id\nchapter: $chapter\nvolume: $volume\ntitle: $title\n';

  @override
  List<Object> get props => [id, chapter, volume, title];
}
