import 'package:rxdart/rxdart.dart';

import 'package:moviephile/models/popular_movies_rs.dart';
import 'package:moviephile/repository/movies_repository.dart';

///Bloc related to the NowPlaying response
class NowPlayingBloc {
  final MoviesRepository _moviesRepository = MoviesRepository();
  final BehaviorSubject<PopularMoviesRS> _subject =
      BehaviorSubject<PopularMoviesRS>();

  ///To initiate the API call to get NowPlaying
  getNowPlaying() async {
    PopularMoviesRS response = await _moviesRepository.getNowPlaying();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PopularMoviesRS> get subject => _subject;
}

///Exposing the single instance of the NowPlayingBloc
final nowPlayingBloc = NowPlayingBloc();
