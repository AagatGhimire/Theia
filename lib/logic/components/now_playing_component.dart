import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:theia/logic/bloc/get_now_playing_movie_bloc.dart';
import 'package:theia/services/movie.dart';

import 'package:theia/services/movie_response.dart';
import 'package:theia/view/movie_detail_page.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  PageController pageController = PageController(
    viewportFraction: 1,
    keepPage: true,
  );

  // fetch now playing movies when widget is initialized
  @override
  void initState() {
    nowPlayingMoviesBloc.getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          // display error
          if (snapshot.data?.error != null && snapshot.data!.error.isNotEmpty) {
            return _buildErrorWidget(snapshot.data!.error);
          }

          // display movie if available
          return _buildNowPlayingWidget(snapshot.data!);

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

  // display list of now playing movies
  Widget _buildNowPlayingWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.isEmpty) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'No more movies',
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 220.0,

        // scroller indicator
        child: PageIndicatorContainer(
          length: movies.take(5).length,
          align: IndicatorAlign.bottom,
          indicatorSpace: 8.0,
          padding: const EdgeInsets.all(5.0),
          shape: IndicatorShape.circle(size: 8.0),
          indicatorColor: Colors.amber,
          indicatorSelectorColor: Colors.amber.shade50,
          child: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: movies.take(5).length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  MovieDetailScreen(movie: movies[index]);
                },
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: movies[index],
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 220.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/original/${movies[index].backPoster}'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),

                    // play button
                    // const Positioned(
                    //   bottom: 0.0,
                    //   top: 0.0,
                    //   left: 0.0,
                    //   right: 0.0,
                    //   child: Icon(
                    //     Icons.play_circle,
                    //   ),
                    // ),

                    // movie title(inside the poster)
                    Positioned(
                      bottom: 30.0,
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        width: 250.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              movies[index].title,
                              style: const TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
