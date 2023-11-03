import 'package:flutter/material.dart';
import 'package:theia/logic/bloc/get_genres_bloc.dart';
import 'package:theia/logic/components/genres_list_component.dart';
import 'package:theia/services/genre.dart';
import 'package:theia/services/genre_response.dart';

class GenresComponent extends StatefulWidget {
  const GenresComponent({super.key});

  @override
  State<GenresComponent> createState() => _GenresComponentState();
}

class _GenresComponentState extends State<GenresComponent> {
  // fetch movie genres when widget is initialized
  @override
  void initState() {
    genresBloc.getGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: genresBloc.subject.stream,
      builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
        if (snapshot.hasData) {
          // display error
          if (snapshot.data?.error != null && snapshot.data!.error.isNotEmpty) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          // display genre if available
          return _buildGenreWidget(snapshot.data!);
        }
        // display error
        else if (snapshot.hasError) {
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

  Widget _buildGenreWidget(GenreResponse data) {
    List<Genre> genres = data.genres;
    if (genres.isEmpty) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'No more movies',
                  style: TextStyle(color: Colors.black12),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      return GenresListComponent(genres: genres);
    }
  }
}
