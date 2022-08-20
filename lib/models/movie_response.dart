class MovieResponse {
  int totalResults;
  List<Movie> results;
MovieResponse({this.page, this.totalResults, this.totalPages, this.results});
MovieResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    if (json['results'] != null) {
      results = List<Movie>();
      json['results'].forEach((v) {
        results.add(new Movie.fromJson(v));
      });
    }
  }
}
class Movie {
  int id;
  var voteAverage;
  String title;
  String posterPath;
  String overview;
  String releaseDate;
Movie(
      {this.id,
      this.voteAverage,
      this.title,
      this.posterPath,,
      this.overview,
      this.releaseDate});
Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voteAverage = json['vote_average'];
    title = json['title'];
    posterPath = json['poster_path'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }
}