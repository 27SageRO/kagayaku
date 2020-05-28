import 'package:equatable/equatable.dart';
import 'package:kagayaku/repository/repository.dart';

abstract class MangaState extends Equatable {
  @override
  List<Object> get props => [];
}

class MangaLoading extends MangaState {}

class MangaError extends MangaState {}

class MangaSuccess extends MangaState {
  final MangaInfo mangaInfo;
  MangaSuccess({this.mangaInfo});

  MangaSuccess copyWith({MangaInfo mangaInfo}) {
    return MangaSuccess(
      mangaInfo: mangaInfo ?? this.mangaInfo,
    );
  }

  @override
  List<Object> get props => [mangaInfo];
}
