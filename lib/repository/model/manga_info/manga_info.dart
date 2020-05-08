import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kagayaku/repository/repository.dart';

part 'manga_info.g.dart';

@JsonSerializable()
class MangaInfo extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imgUrl;
  final String author;
  final double score;
  final List<MangaChapter> chapters;

  MangaInfo({
    this.id,
    this.title,
    this.description,
    this.author,
    this.imgUrl,
    this.score,
    this.chapters,
  });

  factory MangaInfo.fromJson(Map<String, dynamic> json) =>
      _$MangaInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MangaInfoToJson(this);

  @override
  String toString() =>
      '\n id: $id \n title: $title \n description: ${description.substring(0, 50)}... \n image: $imgUrl \n score: $score \n chapters: ${chapters.length}';

  @override
  List<Object> get props => [
        id,
        title,
        description,
        imgUrl,
        score,
        chapters,
      ];
}
