import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../blocs/PersonsBloc.dart';
import '../globals/utils.dart';
import '../models/person.dart';
import '../models/person_response.dart';
import '../models/popular_movies_rs.dart';
import '../more/sabt.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel infoItem;

  MovieDetailScreen(this.infoItem);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _imageSource =
        "https://image.tmdb.org/t/p/w500/${widget.infoItem.posterPath}";
    String _movieTitle = widget.infoItem.title;

    return Scaffold(
      backgroundColor: AppColorCodes.pageBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: AppColorCodes.pageBackgroundColor,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 44, right: 20),
                    child: SABT(
                        child: Text("$_movieTitle",
                            style: TextStyle(color: AppColorCodes.primaryColor),
                            overflow: TextOverflow.ellipsis)),
                  ),
                  background: Container(
                    child: Image.network(
                      _imageSource,
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(_movieTitle,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: RatingBar(
                  onRatingUpdate: (val) {},
                  ignoreGestures: true,
                  itemSize: 20,
                  minRating: 1,
                  direction: Axis.horizontal,
                  initialRating: widget.infoItem.voteAverage == null
                      ? 0
                      : widget.infoItem.voteAverage / 2,
                  allowHalfRating: true,
                  itemCount: 5,
//                        itemPadding: EdgeInsets.symmetric(horizontal: 3),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.pink.withOpacity(0.7),
                  ),
                ),
              ),
              createExpansionCard(),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 20, bottom: 12),
                    child: Text("Cast",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16)),
                  ),
                  CastSection(widget.infoItem),
                ],
              ),
              SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  var _isListExpanded = false;
  Widget createExpansionCard() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isListExpanded = !_isListExpanded;
        });
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (!_isListExpanded)
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text(widget.infoItem.overview),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Text("Show More",
                            style:
                                TextStyle(color: AppColorCodes.primaryColor))),
                  ],
                ),
              if (_isListExpanded) Text(widget.infoItem.overview),
              if (_isListExpanded)
                Row(
                  children: [
                    Expanded(flex: 3, child: Text("")),
                    Expanded(
                        flex: 1,
                        child: Text("Show Less",
                            style:
                                TextStyle(color: AppColorCodes.mainTextColor))),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CastSection extends StatefulWidget {
  final MovieModel movieItem;

  CastSection(this.movieItem);

  @override
  _CastSectionState createState() => _CastSectionState();
}

class _CastSectionState extends State<CastSection> {
  MovieModel movieItem;

  @override
  void initState() {
    super.initState();
    movieItem = widget.movieItem;
    personsBloc.getPersons(movieItem.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CastResponse>(
      stream: personsBloc.subject.stream,
      builder: (context, AsyncSnapshot<CastResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot);
          }
          return _buildCastSection(snapshot.data);
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

  Center _buildErrorWidget(AsyncSnapshot<CastResponse> snapshot) {
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

  Widget _buildCastSection(CastResponse data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        shrinkWrap: true,
        itemCount: data.cast.take(4).length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          Actor _actor = data.cast[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  color: AppColorCodes.pageBackgroundColor,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(50.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/placeholder.png",
                      image:
                          "https://image.tmdb.org/t/p/w500/${_actor.profilePath}",
                      width: 120,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${_actor.name}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
