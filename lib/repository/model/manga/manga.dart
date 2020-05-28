import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga.g.dart';

@JsonSerializable()
class Manga extends Equatable {
  final String id;
  final String title;
  final String imgUrl;
  final String recentChapter;
  final double score;

  Manga({this.id, this.title, this.imgUrl, this.recentChapter, this.score});

  factory Manga.fromJson(Map<String, dynamic> json) => _$MangaFromJson(json);

  Map<String, dynamic> toJson() => _$MangaToJson(this);

  @override
  String toString() =>
      '\n id: $id \n title: $title \n image: $imgUrl \n Recent chapter: $recentChapter \n score: $score \n';

  @override
  List<Object> get props => [
        id,
        title,
        imgUrl,
        recentChapter,
        score,
      ];
}
