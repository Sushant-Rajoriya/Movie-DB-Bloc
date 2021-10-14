import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchMovieWidget extends StatelessWidget {
  final String imagePath;
  final String movieName;
  final String rating;
  final String deckP;

  const SearchMovieWidget(
      {Key? key,
      required this.imagePath,
      required this.movieName,
      required this.rating,
      required this.deckP})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                imagePath,
                height: 150.0,
                width: 100.0,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 180,
                  child: Text(
                    movieName,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          color: Colors.black, letterSpacing: .5, fontSize: 25),
                    ),
                    maxLines: 3,
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: Center(
                    child: Text(
                      deckP,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 15),
                      ),
                      maxLines: 3,
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 25,
                  color: Colors.yellow,
                  child: Center(
                    child: Text(
                      "IMDB $rating ",
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
