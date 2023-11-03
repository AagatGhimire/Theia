import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:theia/logic/bloc/get_movies_by_genre_bloc.dart';
import 'package:theia/services/movie.dart';
import 'package:theia/services/movie_response.dart';
import 'package:theia/view/movie_detail_page.dart';

class GenreMovies extends StatefulWidget {
  final int genreId;
  const GenreMovies({
    super.key,
    required this.genreId,
  });

  @override
  State<GenreMovies> createState() => _GenreMoviesState(genreId);
}

class _GenreMoviesState extends State<GenreMovies> {
  final int genreId;
  _GenreMoviesState(this.genreId);

  @override
  void initState() {
    movieListByGenreBloc.getMoviesByGenre(genreId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: movieListByGenreBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          // display error
          if (snapshot.data?.error != null && snapshot.data!.error.isNotEmpty) {
            return _buildErrorWidget(snapshot.data!.error);
          }

          // display movies if available
          return _buildMovieByGenreWidget(context, snapshot.data!);

          // display error
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        }

        // display loading screen indicator
        else {
          return _buildLoadingWidget();
        }
      },
    );
  }
}

// display loading indicator
Widget _buildLoadingWidget() {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ),
  );
}

// display an error message
Widget _buildErrorWidget(String error) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('An error occured: $error'),
      ],
    ),
  );
}

Widget _buildMovieByGenreWidget(context, MovieResponse data) {
  List<Movie> movies = data.movies;
  if (movies.isEmpty) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'No more movies',
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ],
          )
        ],
      ),
    );
  } else {
    return Container(
      height: 270.0,
      padding: const EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              right: 15.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieDetailScreen(movie: movies[index]),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  movies[index].poster == null
                      ? Container(
                          width: 120.0,
                          height: 180.0,
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(
                                Radius.circular(2.0),
                              )),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.movie,
                                // color: ,
                                size: 60.0,
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: 120.0,
                          height: 180.0,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(2.0),
                            ),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w200/${movies[index].poster}'),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      movies[index].title,
                      maxLines: 2,
                      style: const TextStyle(
                        height: 1.4,
                        // color:,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        movies[index].rating.toString(),
                        style: const TextStyle(
                          // color: ,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      RatingBar(
                        itemSize: 8.0,
                        ratingWidget: RatingWidget(
                          full: Icon(
                            Icons.star,
                            color: Colors.amber.shade600,
                          ),
                          half: Icon(
                            Icons.star,
                            color: Colors.amber.shade600,
                          ),
                          empty: Icon(
                            Icons.star,
                            color: Colors.amber.shade600,
                          ),
                        ),
                        initialRating: (movies[index].rating) / 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
