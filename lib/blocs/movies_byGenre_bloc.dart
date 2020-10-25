import 'package:moviephile/models/genre.dart';
import 'package:moviephile/models/popular_movies_rs.dart';
import 'package:moviephile/repository/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieListByGenreBloc {
  final MoviesRepository _moviesRepository = MoviesRepository();
  final BehaviorSubject<PopularMoviesRS> _subject =
      BehaviorSubject<PopularMoviesRS>();

  getMoviesByGenre(int id) async {
    PopularMoviesRS response = await _moviesRepository.getMoviesByGenre(id);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
    //TODO: look into drainStream
  }

  BehaviorSubject<PopularMoviesRS> get subject => _subject;
}

final movieListByGenreBloc = MovieListByGenreBloc();
