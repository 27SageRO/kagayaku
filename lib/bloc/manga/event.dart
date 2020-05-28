import 'package:equatable/equatable.dart';

abstract class MangaEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MangaFetch extends MangaEvent {
  final String id;
  MangaFetch({this.id});

  @override
  List<Object> get props => [id];
}
