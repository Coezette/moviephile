import 'package:rxdart/rxdart.dart';

import 'package:moviephile/models/genre.dart';
import 'package:moviephile/repository/movies_repository.dart';

///Bloc related to the list of Genres
class GenresBloc {
  final MoviesRepository _moviesRepository = MoviesRepository();
  final BehaviorSubject<GenreResponse> _subject =
      BehaviorSubject<GenreResponse>();

  ///To initiate the API call to get list of Genres
  getGenres() async {
    GenreResponse response = await _moviesRepository.getGenres();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _subject;
}

///Exposing the GenresBloc instance
final genresBloc = GenresBloc();
