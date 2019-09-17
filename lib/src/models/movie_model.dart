class Movies {
  List<Movie> items = new List();

  Movies();

  Movies.fromJson(List<dynamic> json) {
    if (json == null) return;
    for (var item in json) {
      final movie = new Movie.fromJson(item);
      items.add(movie);
    }
  }
}

class Movie {
  int id;
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.id,
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    popularity = json['popularity'] / 1;
    voteCount = json['vote_count'];
    video = json['video'];
    posterPath = json['poster_path'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    voteAverage = json['vote_average'] / 1;
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  getPosterImage() {
    return 'https://image.tmdb.org/t/p/w300/$posterPath';
  }
}
