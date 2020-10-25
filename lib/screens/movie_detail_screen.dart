import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviephile/globals/utils.dart';
import 'package:moviephile/models/popular_movies_rs.dart';
import 'package:moviephile/more/sabt.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel infoItem;

  MovieDetailScreen(this.infoItem);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  String _renderContent;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;

    String _imageSource =
        "https://image.tmdb.org/t/p/w500/${widget.infoItem.posterPath}";
    String _movieTitle = widget.infoItem.title;

    Text title = Text(
      "$_movieTitle",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      textAlign: TextAlign.center,
    );

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
