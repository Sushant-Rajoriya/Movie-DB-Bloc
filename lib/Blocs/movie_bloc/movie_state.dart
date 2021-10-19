part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class InitialState extends MovieState {}

class MovieStateLoaded extends MovieState {
  final List movies;
  final int defaultIndex;

  const MovieStateLoaded({required this.movies, required this.defaultIndex});

  @override
  List<Object> get props => [movies, defaultIndex];
}
