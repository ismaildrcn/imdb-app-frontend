class ApiConstants {
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';

  static const PosterSize posterSize = PosterSize();
}

class PosterSize {
  const PosterSize();

  String get s => "w92";
  String get m => "w154";
  String get l => "w342";
  String get original => "original";
}
