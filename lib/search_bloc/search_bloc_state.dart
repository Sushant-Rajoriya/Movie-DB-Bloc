part of 'search_bloc_bloc.dart';

abstract class SearchBlocState extends Equatable {
  const SearchBlocState();

  @override
  List<Object> get props => [];
}

class SearchBlocInitial extends SearchBlocState {}

class SearchBlocLoaded extends SearchBlocState {
  final List movies;

  const SearchBlocLoaded(
    this.movies,
  );

  @override
  List<Object> get props => [movies];
}
