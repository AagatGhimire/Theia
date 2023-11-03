import 'package:flutter/material.dart';
import 'package:theia/logic/bloc/get_movie_detail_bloc.dart';
import 'package:theia/services/movie_detail.dart';
import 'package:theia/services/movie_detail_response.dart';

class MovieInfo extends StatefulWidget {
  final int id;
  const MovieInfo({
    super.key,
    required this.id,
  });

  @override
  State<MovieInfo> createState() => _MovieInfoState(id);
}

class _MovieInfoState extends State<MovieInfo> {
  final int id;

  _MovieInfoState(this.id);

  @override
  void initState() {
    movieDetailBloc.getMovieDetail(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieDetailResponse>(
      stream: movieDetailBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieDetailResponse> snapshot) {
        if (snapshot.hasData) {
          // display error
          if (snapshot.data?.error != null && snapshot.data!.error.isNotEmpty) {
            return _buildErrorWidget(snapshot.data!.error);
          }

          // display movie if available
          return _buildMovieDetailWidget(snapshot.data!);

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

  Widget _buildMovieDetailWidget(MovieDetailResponse data) {
    MovieDetail detail = data.movieDetail;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Budget',
                    style: TextStyle(
                      // color: ,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // Text(
                  //   "${detail.}min",
                  //   style: const TextStyle(
                  //       // color: ,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 12.0),
                  // ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'DURATION',
                    style: TextStyle(
                        // color: ,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "${detail.runTime}min",
                    style: const TextStyle(
                        // color: ,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                ],
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     Text(
              //       "RELEASE DATE",
              //       style: TextStyle(
              //           color: Style.Colors.titleColor,
              //           fontWeight: FontWeight.w500,
              //           fontSize: 12.0),
              //     ),
              //     SizedBox(
              //       height: 10.0,
              //     ),
              //     Text(detail.releaseDate,
              //         style: TextStyle(
              //             color: Style.Colors.secondColor,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 12.0))
              //   ],
              // ),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "GENRES",
                style: TextStyle(
                    // color: ,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 38.0,
                padding: const EdgeInsets.only(
                  right: 10.0,
                  top: 10.0,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: detail.genres?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.white,
                          ),
                        ),
                        child: Text(
                          detail.genres![index].name,
                          maxLines: 2,
                          style: const TextStyle(
                              height: 1.4,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9.0),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
