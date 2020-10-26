import 'package:flutter/material.dart';
import 'package:moviephile/blocs/genres_bloc.dart';
import 'package:moviephile/blocs/movies_byGenre_bloc.dart';
import 'package:moviephile/globals/utils.dart';
import 'package:moviephile/models/genre.dart';
import 'package:moviephile/models/popular_movies_rs.dart';
import 'package:moviephile/screens/movie_detail_screen.dart';

class GenresMainSection extends StatefulWidget {
  @override
  _GenresMainSectionState createState() => _GenresMainSectionState();
}

class _GenresMainSectionState extends State<GenresMainSection> {
  double _width = 0;
  double _height = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genresBloc.getGenres();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    return StreamBuilder<GenreResponse>(
      stream: genresBloc.subject.stream,
      builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot);
          }
          return _buildGenresSection(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot);
        } else {
          return Center(
            child: CircularProgressIndicator(
                backgroundColor: AppColorCodes.primaryColor),
          );
        }
      },
    );
  }

  Center _buildErrorWidget(AsyncSnapshot<GenreResponse> snapshot) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sorry something went wrong"),
          SizedBox(height: 6),
          Text("${snapshot.data.error}"),
        ],
      ),
    );
  }

  Widget _buildGenresSection(GenreResponse data) {
    List<Genre> genres = data.genres;
    if (genres.length == 0) {
      return Center(
        child: Container(
          child: Text("No Genres Found"),
        ),
      );
    } else {
      return GenresSingleListView(genres: genres);
//      return Text("${genres.first.name}");
    }
  }
}

class GenresSingleListView extends StatefulWidget {
  //this is all the genres as one
  final List<Genre> genres;

  GenresSingleListView({@required this.genres, Key key}) : super(key: key);

  @override
  _GenresSingleListViewState createState() =>
      _GenresSingleListViewState(genres);
}

class _GenresSingleListViewState extends State<GenresSingleListView> {
  final List<Genre> genres;
  _GenresSingleListViewState(this.genres);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: genres.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  "${genres[index].name}",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MoviesByGenreListItem(id: genres[index].id),
            ],
          );
        },
      ),
    );
  }
}

//>>>
class MoviesByGenreListItem extends StatefulWidget {
  final int id;

  MoviesByGenreListItem({@required this.id, Key key}) : super(key: key);

  @override
  _MoviesByGenreListItemState createState() => _MoviesByGenreListItemState(id);
}

class _MoviesByGenreListItemState extends State<MoviesByGenreListItem> {
  int id;

  _MoviesByGenreListItemState(this.id);
  MovieListByGenreBloc _uniqueMBGBloc;
  double _width = 0;
  double _height = 0;

  @override
  void initState() {
    super.initState();
    _uniqueMBGBloc = MovieListByGenreBloc();
    _uniqueMBGBloc.getMoviesByGenre(id);
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    return StreamBuilder<PopularMoviesRS>(
      stream: _uniqueMBGBloc.subject.stream,
      builder: (context, AsyncSnapshot<PopularMoviesRS> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot);
          }
          return _buildMoviesByGenreList(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot);
        } else {
          return Center(
            child: Text(""),
//            child: CircularProgressIndicator(
//                backgroundColor: AppColorCodes.primaryColor),
          );
        }
      },
    );
  }

  Center _buildErrorWidget(AsyncSnapshot<PopularMoviesRS> snapshot) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sorry something went wrong"),
          SizedBox(height: 6),
          Text("${snapshot.data.error}"),
        ],
      ),
    );
  }

  Widget _buildMoviesByGenreList(PopularMoviesRS data) {
    List<MovieModel> movies = data.movies;
    if (movies.length == 0) {
      return Center(
        child: Container(
          width: _width,
          child: Text("Sorry, no movies found"),
        ),
      );
    } else {
      return Container(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.take(8).length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(movies[index])),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Card(
                  child: Container(
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(10.0),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/placeholder.png",
                        image:
                            "https://image.tmdb.org/t/p/w500/${movies[index].posterPath}",
                        width: 120,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
