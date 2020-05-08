import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga_chapter_pages.g.dart';

@JsonSerializable()
class MangaChapterPages extends Equatable {
  final String id;
  final List<String> pages;
  MangaChapterPages({this.id, this.pages});

  factory MangaChapterPages.fromJson(Map<String, dynamic> json) =>
      _$MangaChapterPagesFromJson(json);

  Map<String, dynamic> toJson() => _$MangaChapterPagesToJson(this);

  @override
  String toString() => '\nid: $id pages: ${pages.join(', ')}\n';

  @override
  List<Object> get props => [id, pages];
}
