import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'search_bloc_event.dart';
part 'search_bloc_state.dart';

class SearchBlocBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  SearchBlocBloc() : super(SearchBlocInitial()) {
    /*
    Stream<SearchBlocState> onEvent(SearchBlocEvent event) async* {
      if (event is SerchTermChangedEvent) {
        if (event.searchTerm.length > 2) {
          final searchResult = await http.get(
            Uri.parse(
                '${Keys.tmDbBasicPath}search/movie?api_key=${Keys.apiKey}&query=${event.searchTerm}'),
          );
          final searchedMovie = json.decode(searchResult.body)['results'];
          yield SearchBlocLoaded(searchedMovie);
        }
      }
    }
*/
  }
}
