part of 'search_bloc_bloc.dart';

abstract class SearchBlocEvent extends Equatable {
  const SearchBlocEvent();

  @override
  List<Object> get props => [];
}

class SerchTermChangedEvent extends SearchBlocEvent {
  final String searchTerm;

  const SerchTermChangedEvent(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}
