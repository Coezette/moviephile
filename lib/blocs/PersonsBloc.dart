import 'package:moviephile/models/genre.dart';
import 'package:moviephile/models/person_response.dart';
import 'package:moviephile/models/popular_movies_rs.dart';
import 'package:moviephile/repository/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

class PersonsBloc {
  final MoviesRepository _moviesRepository = MoviesRepository();
  final BehaviorSubject<CastResponse> _subject =
      BehaviorSubject<CastResponse>();

  getPersons(int movID) async {
    CastResponse response = await _moviesRepository.getCast(movID: movID);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<CastResponse> get subject => _subject;
}

final personsBloc = PersonsBloc();
