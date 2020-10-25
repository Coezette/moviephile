import 'package:moviephile/models/genre.dart';
import 'package:moviephile/models/popular_movies_rs.dart';
import 'package:moviephile/repository/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingBloc {
  final MoviesRepository _moviesRepository = MoviesRepository();
  final BehaviorSubject<PopularMoviesRS> _subject =
      BehaviorSubject<PopularMoviesRS>();

  getNowPlaying() async {
    PopularMoviesRS response = await _moviesRepository.getNowPlaying();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PopularMoviesRS> get subject => _subject;
}

final nowPlayingBloc = NowPlayingBloc();
