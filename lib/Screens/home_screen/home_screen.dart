import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db_bloc/Blocs/fatch_movie_cubit/fatch_movie_cubit.dart';
import 'package:movie_db_bloc/Blocs/search_movie_cubit/search_movie_cubit.dart';
import 'package:movie_db_bloc/Data/my_tmdb_api/keys.dart';
import 'package:movie_db_bloc/Screens/home_screen/my_widgets/movie_widget.dart';
import 'package:movie_db_bloc/Screens/movie_details/movie_details_screen.dart';
import 'package:movie_db_bloc/Screens/search_screen/search_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<FatchMovieCubit>(context).fatch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(context),
      backgroundColor: Colors.white10,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Hello  ${widget.userName} !",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              letterSpacing: .5,
                              fontSize: 20),
                        ),
                      ),
                      Text(
                        "Welcome to MovieDB app",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              color: Colors.white60,
                              letterSpacing: .5,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                                value:
                                    BlocProvider.of<SearchMovieCubit>(context),
                                child: const SearchScreen(),
                              )));
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.white60,
                      size: 28.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  "Feature Movies",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        color: Colors.white, letterSpacing: .5, fontSize: 20),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<FatchMovieCubit, FatchMovieState>(
                builder: (context, state) {
                  return myMovieTiles(state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView myMovieTiles(FatchMovieState state) {
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
                      imagePath: Keys.imageBasicPath +
                          state.movies[index]['poster_path'],
                      rating: state.movies[index]['vote_average'].toString(),
                    )));
          },
          child: MovieWidget(
            imagePath: Keys.imageBasicPath + state.movies[index]['poster_path'],
            rating: state.movies[index]['vote_average'].toString(),
            movieName: state.movies[index]['title'] ?? 'Loading',
            deckP: state.movies[index]['overview'] ?? 'Loading',
          ),
        );
      },
    );
  }

  Drawer myDrawer(BuildContext context) {
    return Drawer(
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
                        color: Colors.white, letterSpacing: .5, fontSize: 30),
                  ),
                ),
                Text(
                  "Edit Profile",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        color: Colors.white, letterSpacing: .5, fontSize: 25),
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
                    color: Colors.black, letterSpacing: .5, fontSize: 20),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
