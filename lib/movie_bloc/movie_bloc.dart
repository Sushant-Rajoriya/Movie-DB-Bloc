import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'package:movie_db_bloc/my_tmdb_api/keys.dart';
part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(InitialState());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMovieData) {
      final trendingResult = await http.get(
        Uri.parse(
            '${Keys.tmDbBasicPath}trending/all/day?api_key=${Keys.apiKey}'),
      );
      final treanding = json.decode(trendingResult.body)['results'];
      yield MovieStateLoaded(movies: treanding, defaultIndex: 0);
    }
  }
}
