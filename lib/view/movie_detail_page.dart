import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:theia/logic/components/movie_info.dart';
import 'package:theia/services/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState(movie);
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final Movie movie;

  _MovieDetailScreenState(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              movie.title.length > 40
                  ? '${movie.title.substring(0, 37)}...'
                  : movie.title,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            background: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://image.tmdb.org/t/p/original/${movie.backPoster}"),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(colors: colors)
                //   ),
                // ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 20.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    movie.rating.toString(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  RatingBar(
                    itemSize: 10.0,
                    initialRating: (movie.rating) / 2,
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
                    minRating: 1,
                    maxRating: 5,
                    allowHalfRating: true,
                    direction: Axis.horizontal,
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, top: 20.0),
              child: Text(
                'OVERVIEW',
                style: TextStyle(
                  // color: ,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                movie.overview,
                style: const TextStyle(
                  // color: Colors.white,
                  fontSize: 12.0,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            MovieInfo(id: movie.id),
            // SimilarMovies(id: movie.id),
          ]),
        ),
      ]),
    );
  }
}
