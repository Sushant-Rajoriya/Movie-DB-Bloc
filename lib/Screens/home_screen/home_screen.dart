import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db_bloc/Screens/home_screen/my_widgets/movie_widget.dart';
import 'package:movie_db_bloc/Screens/home_screen/my_widgets/top_bar.dart';
import 'package:movie_db_bloc/Screens/movie_details/movie_details_screen.dart';
import 'package:movie_db_bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_db_bloc/my_tmdb_api/keys.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    movieBloc.add(const FetchMovieData(defaultIndex: 0));

    return BlocBuilder<MovieBloc, MovieState>(
      bloc: movieBloc,
      builder: (context, state) {
        if (state is MovieStateLoaded) {
          return Scaffold(
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontSize: 30),
                          ),
                        ),
                        Text(
                          "Edit Profile",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Logout',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 20),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white10,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(name: widget.userName),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "Feature Movies",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              letterSpacing: .5,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
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
                                      movieName: state.movies[index]['title'] ??
                                          'Loading',
                                      movieDiscP: state.movies[index]
                                              ['overview'] ??
                                          'Loading',
                                      imagePath: Keys.imageBasicPath +
                                          state.movies[index]['poster_path'],
                                      rating: state.movies[index]
                                              ['vote_average']
                                          .toString(),
                                    )));
                          },
                          child: MovieWidget(
                            imagePath: Keys.imageBasicPath +
                                state.movies[index]['poster_path'],
                            rating:
                                state.movies[index]['vote_average'].toString(),
                            movieName:
                                state.movies[index]['title'] ?? 'Loading',
                            deckP: state.movies[index]['overview'] ?? 'Loading',
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: GestureDetector(
              onTap: () {
                movieBloc.add(const FetchMovieData(defaultIndex: 0));
              },
              child: const Text("Try Again"),
            ),
          );
        }
      },
    );
  }
}
