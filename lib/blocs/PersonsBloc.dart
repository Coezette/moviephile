import 'package:rxdart/rxdart.dart';

import 'package:moviephile/models/person_response.dart';
import 'package:moviephile/repository/movies_repository.dart';

///Bloc related to the state of the movie cast (Persons)
class PersonsBloc {
  final MoviesRepository _moviesRepository = MoviesRepository();
  final BehaviorSubject<CastResponse> _subject =
      BehaviorSubject<CastResponse>();

  ///Initiating the API call to getPersons (getting the cast for a movie)
  getPersons(int movID) async {
    CastResponse response = await _moviesRepository.getCast(movID: movID);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<CastResponse> get subject => _subject;
}

///Exposing the single instance of PersonsBloc
final personsBloc = PersonsBloc();
