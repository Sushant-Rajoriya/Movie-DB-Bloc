import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;
import 'package:movie_db_bloc/Data/my_tmdb_api/keys.dart';

part 'search_movie_state.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  SearchMovieCubit() : super(SearchMovieState(movies: []));

  Future<void> searchMovies(String searchTerm) async {
    final searchResult = await http.get(
      Uri.parse(
          '${Keys.tmDbBasicPath}search/movie?api_key=${Keys.apiKey}&query=$searchTerm'),
    );
    final searchedMovie = json.decode(searchResult.body)['results'];

    emit(SearchMovieState(movies: searchedMovie));
  }
}
