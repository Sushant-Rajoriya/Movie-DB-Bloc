import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;
import 'package:movie_db_bloc/Data/my_tmdb_api/keys.dart';
part 'fatch_movie_state.dart';

class FatchMovieCubit extends Cubit<FatchMovieState> {
  FatchMovieCubit() : super(FatchMovieState(movies: []));

  Future<void> fatch() async {
    final trendingResult = await http.get(
      Uri.parse('${Keys.tmDbBasicPath}trending/all/day?api_key=${Keys.apiKey}'),
    );
    final treanding = json.decode(trendingResult.body)['results'];
    emit(FatchMovieState(movies: treanding));
  }
}
