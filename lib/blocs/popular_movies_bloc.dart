import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moviephile/events/movies_events.dart';
import 'package:moviephile/repository/movies_repository.dart';
import 'package:moviephile/states/popular_movies_state.dart';

///Bloc related to the PopularMovies response
class PopularMoviesBloc extends Bloc<MoviesEvents, PopularMoviesState> {
  final MoviesRepository _moviesRepository = MoviesRepository();

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
//          print("current_movies_list_size:  ${currentState.movies.length}");

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
        yield PopularMoviesFailure();
      }
    }
  }

  bool _hasReachedMax(PopularMoviesState state) =>
      state is PopularMoviesSuccess && state.hasReachedMax;

  dispose() {}
}
