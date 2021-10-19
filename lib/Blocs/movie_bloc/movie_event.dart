part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieData extends MovieEvent {
  final int defaultIndex;

  const FetchMovieData({required this.defaultIndex});

  @override
  List<Object> get props => [defaultIndex];
}
