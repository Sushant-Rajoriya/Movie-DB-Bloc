import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_db_bloc/Blocs/search_movie_cubit/search_movie_cubit.dart';
import 'package:movie_db_bloc/Data/my_tmdb_api/keys.dart';
import 'package:movie_db_bloc/Screens/movie_details/movie_details_screen.dart';
import 'package:movie_db_bloc/Screens/search_screen/search_movie_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: TextField(
                        onSubmitted: (value) {
                          BlocProvider.of<SearchMovieCubit>(context)
                              .searchMovies(value);
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter Movie Name',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<SearchMovieCubit, SearchMovieState>(
                  builder: (context, state) {
                    return searchedMovieList(state);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView searchedMovieList(SearchMovieState state) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      itemCount: state.movies.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(
                      movieName: state.movies[index]['title'] ?? 'Loading',
                      movieDiscP: state.movies[index]['overview'] ?? 'Loading',
                      imagePath: state.movies[index]['poster_path'] == null
                          ? "https://www.cssauthor.com/wp-content/uploads/2015/03/Movies-Text-Effect-PSD.jpg"
                          : Keys.imageBasicPath +
                              state.movies[index]['poster_path'],
                      rating: state.movies[index]['vote_average'].toString(),
                    )));
          },
          child: SearchMovieWidget(
            imagePath: state.movies[index]['poster_path'] == null
                ? "https://www.cssauthor.com/wp-content/uploads/2015/03/Movies-Text-Effect-PSD.jpg"
                : Keys.imageBasicPath + state.movies[index]['poster_path'],
            rating: state.movies[index]['vote_average'].toString(),
            movieName: state.movies[index]['title'] ?? 'Loading',
            deckP: state.movies[index]['overview'] ?? 'Loading',
          ),
        );
      },
    );
  }
}
