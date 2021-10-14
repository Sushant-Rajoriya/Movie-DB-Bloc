import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_bloc/Screens/movie_details/movie_details_screen.dart';
import 'package:movie_db_bloc/Screens/search_screen/search_movie_widget.dart';
import 'package:movie_db_bloc/my_tmdb_api/keys.dart';
import 'package:movie_db_bloc/search_bloc/search_bloc_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    SearchBlocBloc searchBlocBloc = BlocProvider.of<SearchBlocBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Hero(
                    tag: "search",
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Colors.black,
                      size: 28.0,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) {
                        searchBlocBloc.add(SerchTermChangedEvent(value));
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter Movie Name',
                      ),
                    ),
                  ),
                  BlocBuilder<SearchBlocBloc, SearchBlocState>(
                    bloc: searchBlocBloc,
                    builder: (context, state) {
                      if (state is SearchBlocLoaded) {
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            scrollDirection: Axis.vertical,
                            itemCount: state.movies.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MovieDetailsScreen(
                                            movieName: state.movies[index]
                                                    ['title'] ??
                                                'Loading',
                                            movieDiscP: state.movies[index]
                                                    ['overview'] ??
                                                'Loading',
                                            imagePath: Keys.imageBasicPath +
                                                state.movies[index]
                                                    ['poster_path'],
                                            rating: state.movies[index]
                                                    ['vote_average']
                                                .toString(),
                                          )));
                                },
                                child: SearchMovieWidget(
                                  imagePath: Keys.imageBasicPath +
                                      state.movies[index]['poster_path'],
                                  rating: state.movies[index]['vote_average']
                                      .toString(),
                                  movieName:
                                      state.movies[index]['title'] ?? 'Loading',
                                  deckP: state.movies[index]['overview'] ??
                                      'Loading',
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
