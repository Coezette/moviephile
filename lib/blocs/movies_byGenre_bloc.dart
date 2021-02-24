import 'package:flutter/cupertino.dart';

import 'package:rxdart/rxdart.dart';

import 'package:moviephile/models/popular_movies_rs.dart';
import 'package:moviephile/repository/movies_repository.dart';

///Bloc related to the Movies in each Genre
class MovieListByGenreBloc {
  final MoviesRepository _moviesRepository = MoviesRepository();
  final BehaviorSubject<PopularMoviesRS> _subject =
      BehaviorSubject<PopularMoviesRS>();

  ///To initiate the API call to get MoviesByGenre
  getMoviesByGenre(int id) async {
    PopularMoviesRS response = await _moviesRepository.getMoviesByGenre(id);
    _subject.sink.add(response);
  }

  void drainStream() => _subject.value = null;

  @mustCallSuper
  dispose() async {
    _subject.drain();
    await _subject.close();
  }

  BehaviorSubject<PopularMoviesRS> get subject => _subject;
}

///Exposing the single instance of MovieListByGenreBloc
final movieListByGenreBloc = MovieListByGenreBloc();
