import 'package:flutter/material.dart';
import 'package:moviephile/blocs/now_playing_bloc.dart';
import 'package:moviephile/globals/utils.dart';
import 'package:moviephile/models/popular_movies_rs.dart';
import 'package:moviephile/screens/main_widgets/genres_main_section.dart';
import 'package:page_indicator/page_indicator.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  double _width = 0;
  double _height = 0;
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorCodes.pageBackgroundColor,
        elevation: 0,
        title: Text(
          "MoviePhile",
          style: TextStyle(color: AppColorCodes.primaryColor),
        ),
      ),
      body: Column(
        children: [
          NowPlayingMain(),
          SizedBox(height: 40),
          GenresMainSection(),
        ],
      ),
    );
  }
}

class NowPlayingMain extends StatefulWidget {
  @override
  _NowPlayingMainState createState() => _NowPlayingMainState();
}

class _NowPlayingMainState extends State<NowPlayingMain> {
  double _width = 0;
  double _height = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowPlayingBloc.getNowPlaying();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    return StreamBuilder<PopularMoviesRS>(
      stream: nowPlayingBloc.subject.stream,
      builder: (context, AsyncSnapshot<PopularMoviesRS> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot);
          }
          return _buildNowPlayingTile(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot);
        } else {
          return Center(
            child: CircularProgressIndicator(
                backgroundColor: AppColorCodes.primaryColor),
          );
        }
      },
    );
  }

  Center _buildErrorWidget(AsyncSnapshot<PopularMoviesRS> snapshot) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sorry something went wrong"),
          SizedBox(height: 6),
          Text("${snapshot.data.error}"),
        ],
      ),
    );
  }

  Widget _buildNowPlayingTile(PopularMoviesRS data) {
    List<MovieModel> movies = data.movies;
    if (movies.length == 0) {
      return Center(
        child: Container(
          width: _width,
          child: Text("Sorry, no movies found"),
        ),
      );
    } else {
      return Container(
        height: 230,
        child: PageIndicatorContainer(
          length: movies.take(8).length,
          align: IndicatorAlign.bottom,
          indicatorColor: Colors.black12,
          indicatorSelectorColor: AppColorCodes.primaryColor,
          indicatorSpace: 10,
          padding: EdgeInsets.all(5.0),
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.take(8).length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    width: _width,
                    height: 230,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/w500/${movies[index].posterPath}")),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(1.0),
                          Colors.black.withOpacity(0.0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Container(
                      width: 240,
                      child: Text(
                        movies[index].title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );
    }
  }
}
