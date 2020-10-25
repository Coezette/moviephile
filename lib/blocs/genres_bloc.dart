import 'package:moviephile/models/genre.dart';
import 'package:moviephile/repository/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

class GenresBloc {
  final MoviesRepository _moviesRepository = MoviesRepository();
  final BehaviorSubject<GenreResponse> _subject =
      BehaviorSubject<GenreResponse>();

  getGenres() async {
    GenreResponse response = await _moviesRepository.getGenres();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _subject;
}

final genresBloc = GenresBloc();
