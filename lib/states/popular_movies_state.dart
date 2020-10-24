import 'package:moviephile/models/popular_movies_rs.dart';

abstract class PopularMoviesState {
  const PopularMoviesState();
}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesFailure extends PopularMoviesState {}

class PopularMoviesSuccess extends PopularMoviesState {
  final int page;
  final List<MovieModel> movies;
  final PopularMoviesRS popularMoviesRS;
  final bool hasReachedMax;

  const PopularMoviesSuccess({
    this.page,
    this.movies,
    this.popularMoviesRS,
    this.hasReachedMax,
  });

  PopularMoviesSuccess copyWith({
    int page,
    List<MovieModel> movies,
    PopularMoviesRS popularMoviesRS,
    bool hasReachedMax,
  }) {
    return PopularMoviesSuccess(
      page: page ?? this.page,
      movies: movies ?? this.movies,
      popularMoviesRS: popularMoviesRS ?? this.popularMoviesRS,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
