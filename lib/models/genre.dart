class Genre {
  final int id;
  final String name;

  Genre(this.id, this.name);

  Genre.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}

class GenreResponse {
  final List<Genre> genres;
  final String error;

  GenreResponse(this.genres, this.error);

  GenreResponse.fromJson(Map<String, dynamic> json)
      : genres =
            (json["genres"] as List).map((e) => new Genre.fromJson(e)).toList(),
        error = "";

  GenreResponse.withError(String errorVal)
      : genres = List(),
        error = errorVal;
}
