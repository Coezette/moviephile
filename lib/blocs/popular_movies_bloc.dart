import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviephile/events/movies_events.dart';
import 'package:moviephile/models/popular_movies_rs.dart';
import 'package:moviephile/repository/movies_repository.dart';
import 'package:moviephile/states/popular_movies_state.dart';
import 'package:rxdart/rxdart.dart';

class PopularMoviesBloc extends Bloc<MoviesEvents, PopularMoviesState> {
  final MoviesRepository _moviesRepository = MoviesRepository();
//  final BehaviorSubject<PopularMoviesRS> _subject =
//      BehaviorSubject<PopularMoviesRS>();

  PopularMoviesBloc(PopularMoviesState initialState)
      : super(PopularMoviesInitial());

  @override
  Stream<PopularMoviesState> mapEventToState(MoviesEvents event) async* {
    final currentState = state;

    if (event is FetchPopularMoviesEvent && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PopularMoviesInitial) {
          final _popularMoviesRSSingePage =
              await _moviesRepository.getPopularMovies(page: 1);
          yield PopularMoviesSuccess(
              movies: _popularMoviesRSSingePage.movies,
              popularMoviesRS: _popularMoviesRSSingePage,
              hasReachedMax: false,
              page: 1);
          return;
        }

        if (currentState is PopularMoviesSuccess) {
          final _popularMoviesRSSingePage = await _moviesRepository
              .getPopularMovies(page: currentState.page + 1);
          print("current_movies_list_size:  ${currentState.movies.length}");

          yield currentState.page == currentState.popularMoviesRS.totalPages - 1
              ? currentState.copyWith(hasReachedMax: true)
              : PopularMoviesSuccess(
                  movies:
                      currentState.movies + _popularMoviesRSSingePage.movies,
                  popularMoviesRS: _popularMoviesRSSingePage,
                  hasReachedMax: false,
                  page: currentState.page + 1,
                );
        }
      } catch (_) {
        print("failure_happening ##########");
        yield PopularMoviesFailure();
      }
    }
  }

  bool _hasReachedMax(PopularMoviesState state) =>
      state is PopularMoviesSuccess && state.hasReachedMax;

  dispose() {
//    _subject.close();
  }

//  BehaviorSubject<PopularMoviesRS> get subject => _subject;
}

//final popularMoviesBloc = PopularMoviesBloc(PopularMoviesInitial());

//    throw UnimplementedError();
//##### OLD Method
/*
class PopularMoviesBloc {
  final MoviesRepository _moviesRepository = MoviesRepository();
  final BehaviorSubject<PopularMoviesRS> _subject =
      BehaviorSubject<PopularMoviesRS>();

  getPopularMovies() async {
    PopularMoviesRS response = await _moviesRepository.getPopularMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PopularMoviesRS> get subject => _subject;
}

final popularMoviesBloc = PopularMoviesBloc();
 */
