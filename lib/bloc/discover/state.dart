import 'package:equatable/equatable.dart';
import 'package:kagayaku/repository/repository.dart';

abstract class DiscoverState extends Equatable {
  @override
  List<Object> get props => [];
}

class DiscoverLoading extends DiscoverState {}

class DiscoverError extends DiscoverState {
  final String error;
  DiscoverError({this.error});

  @override
  List<Object> get props => [error];
}

class DiscoverSuccess extends DiscoverState {
  final List<Manga> popularManga;

  DiscoverSuccess({this.popularManga});

  DiscoverSuccess copyWith({List<Manga> popularManga}) {
    return DiscoverSuccess(
      popularManga: popularManga ?? this.popularManga,
    );
  }

  @override
  List<Object> get props => [popularManga];
}
