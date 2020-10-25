import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviephile/blocs/popular_movies_bloc.dart';
import 'package:moviephile/events/movies_events.dart';
import 'package:moviephile/globals/utils.dart';
import 'package:moviephile/models/popular_movies_rs.dart';
import 'package:moviephile/screens/movie_detail_screen.dart';
import 'package:moviephile/states/popular_movies_state.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PopularMoviesBloc _popularMoviesBloc;

  double _width = 0;
  double _height = 0;

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
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MoviePhile",
          style: TextStyle(color: AppColorCodes.primaryColor),
        ),
        elevation: 0.0,
        backgroundColor: AppColorCodes.pageBackgroundColor,
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MovieDetailScreen(movie)),
        );
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        elevation: 0,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: new BorderRadius.circular(10.0),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/placeholder.png",
//                  image: "https://cdn.vox-cdn.com/thumbor/heXu37IbDvVy6Qbo1wbPjNvi6Ys=/0x0:712x423/1200x800/filters:focal(385x120:497x232)/cdn.vox-cdn.com/uploads/chorus_image/image/55531035/Screen_Shot_2017_06_30_at_3.17.00_PM.0.png",
                  image: "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                  width: 120,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${movie.title}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      RatingBar(
                        onRatingUpdate: (val) {
                          print(val);
                        },
                        itemSize: 20,
                        minRating: 1,
                        ignoreGestures: true,

                        direction: Axis.horizontal,
                        initialRating: movie.voteAverage == null
                            ? 0
                            : movie.voteAverage / 2,
//                        allowHalfRating: true,
                        itemCount: 5,
//                        itemPadding: EdgeInsets.symmetric(horizontal: 3),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.pink.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "${movie.overview}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 12, color: Colors.black.withOpacity(0.6)),
                      ),
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
