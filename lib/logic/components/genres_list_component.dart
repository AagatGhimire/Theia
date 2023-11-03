import 'package:flutter/material.dart';
import 'package:theia/logic/bloc/get_movies_by_genre_bloc.dart';
import 'package:theia/logic/components/movie_by_genre.dart';
import 'package:theia/services/genre.dart';

class GenresListComponent extends StatefulWidget {
  final List<Genre> genres;
  const GenresListComponent({
    super.key,
    required this.genres,
  });

  @override
  State<GenresListComponent> createState() => _GenresListComponentState(genres);
}

class _GenresListComponentState extends State<GenresListComponent>
    with SingleTickerProviderStateMixin {
  final List<Genre> genres;

  _GenresListComponentState(this.genres);
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: genres.length,
    );
    _tabController?.addListener(
      () {
        if (_tabController!.indexIsChanging) {
          movieListByGenreBloc.dispose();
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 307.0,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              bottom: TabBar(
                controller: _tabController,
                // indicatorColor: ,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                // unselectedLabelColor: ,
                // labelColor: ,
                isScrollable: true,
                tabs: genres.map((Genre genre) {
                  return Container(
                    padding: const EdgeInsets.only(
                      bottom: 15.0,
                      top: 10.0,
                    ),
                    child: Text(
                      genre.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: genres.map((Genre genre) {
              return GenreMovies(
                genreId: genre.id,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
