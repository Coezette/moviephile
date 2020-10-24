import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviephile/blocs/popular_movies_bloc.dart';
import 'package:moviephile/events/movies_events.dart';
import 'package:moviephile/models/popular_movies_rs.dart';
import 'package:moviephile/states/popular_movies_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PopularMoviesBloc _popularMoviesBloc;

  @override
  void initState() {
    super.initState();
//    popularMoviesBloc..getPopularMovies();

    _scrollController.addListener(_onScroll);
    _popularMoviesBloc = BlocProvider.of<PopularMoviesBloc>(context);
    print("this part reached!!!X!!!");
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _popularMoviesBloc.add(FetchPopularMoviesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MoviePhile"),
      ),
      body: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
        builder: (context, state) {
          if (state is PopularMoviesInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PopularMoviesFailure) {
            return Center(
              child: Text('failed to fetch movies'),
            );
          }
          if (state is PopularMoviesSuccess) {
            if (state.movies.isEmpty) {
              return Center(
                child: Text('no movies'),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.movies.length
                    ? BottomLoader()
                    : MovieWidget(movie: state.movies[index]);
              },
              itemCount: state.hasReachedMax
//                  ? state.movies.length
                  ? state.movies.length
                  : state.movies.length + 1,
              controller: _scrollController,
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  //######

  Widget _buildPopularMovieTileWidget(PopularMoviesRS data) {
    List<MovieModel> movies = data.movies;
    if (movies.length == 0) {
      return Center(child: Text("Sorry no movies found"));
    } else {
      return ListView.builder(
        controller: _scrollController,
        itemCount: movies.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(movies[index].title),
          );
        },
      );
    }
  }

  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MoviePhile"),
      ),
      body: StreamBuilder<PopularMoviesRS>(
        stream: _popularMoviesBloc.subject.stream,
        builder: (context, AsyncSnapshot<PopularMoviesRS> snapshot) {
          print("snapshotData: ${snapshot.hasData}");

          if (snapshot.hasData) {
            return _buildPopularMovieTileWidget(snapshot.data);
          } else {
            return Center(
              child: Text("Sorry something went wrong"),
            );
          }
        },
      ),
    );
  }

  Widget _buildPopularMovieTileWidget(PopularMoviesRS data) {
    List<MovieModel> movies = data.movies;
    if (movies.length == 0) {
      return Center(child: Text("Sorry no movies found"));
    } else {
      return ListView.builder(
        controller: _scrollController,
        itemCount: movies.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(movies[index].title),
          );
        },
      );
    }
  }
   */
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class MovieWidget extends StatelessWidget {
  final MovieModel movie;

  const MovieWidget({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${movie.title}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(movie.title),
//      subtitle: Text(movie.body),
      dense: true,
    );
  }
}
