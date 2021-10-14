import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetailsScreen extends StatelessWidget {
  final String imagePath;
  final String movieName;
  final String rating;
  final String movieDiscP;
  const MovieDetailsScreen({
    Key? key,
    required this.imagePath,
    required this.movieName,
    required this.rating,
    required this.movieDiscP,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              imagePath,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 25,
                    color: Colors.yellow,
                    child: Center(
                      child: Text(
                        "IMDB " + rating,
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
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                movieDiscP,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      color: Colors.black, letterSpacing: .5, fontSize: 15),
                ),
                maxLines: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
