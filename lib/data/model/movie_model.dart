class MovieModel {
  final int id;
  final bool adult;
  final String? backdropPath;
  final Collection? belongsToCollection;
  final int? budget;
  final List<Genres>? genres;
  final String? homepage;
  final String? imdbId;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String posterPath;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  MovieModel({
    required this.id,
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"],
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      belongsToCollection: json["belongs_to_collection"] == null
          ? null
          : Collection.fromJson(json["belongs_to_collection"]!),
      budget: json["budget"],
      genres: json["genres"] == null
          ? []
          : List<Genres>.from(json["genres"]!.map((x) => Genres.fromJson(x))),
      homepage: json["homepage"],
      imdbId: json["imdbId"],
      originCountry: json["origin_country"] == null
          ? []
          : List<String>.from(json["origin_country"]!.map((x) => x)),
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"],
      posterPath: json["poster_path"],
      productionCompanies: json["production_companies"] == null
          ? []
          : List<ProductionCompany>.from(
              json["production_companies"]!.map(
                (x) => ProductionCompany.fromJson(x),
              ),
            ),
      productionCountries: json["production_countries"] == null
          ? []
          : List<ProductionCountry>.from(
              json["production_countries"]!.map(
                (x) => ProductionCountry.fromJson(x),
              ),
            ),
      releaseDate: json["release_date"],
      revenue: json["revenue"],
      runtime: json["runtime"],
      spokenLanguages: json["spoken_languages"] == null
          ? []
          : List<SpokenLanguage>.from(
              json["spoken_languages"]!.map((x) => SpokenLanguage.fromJson(x)),
            ),
      status: json["status"],
      tagline: json["tagline"],
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
    );
  }
}

class ProductionCompany {
  ProductionCompany({
    required this.logoPath,
    required this.originCountry,
    required this.id,
    required this.name,
  });

  final int id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json["id"],
      originCountry: json["originCountry"],
      name: json["name"],
      logoPath: json["logoPath"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "logoPath": logoPath,
    "name": name,
    "originCountry": originCountry,
  };
}

class Collection {
  final int id;
  final String name;
  final String posterPath;
  final String backdropPath;

  Collection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json["id"],
      name: json["name"],
      posterPath: json["poster_path"],
      backdropPath: json["backdrop_path"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "poster_path": posterPath,
    "backdrop_path": backdropPath,
  };
}

class Genres {
  final int id;
  final String name;

  Genres({required this.id, required this.name});

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(id: json["id"], name: json["name"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class ProductionCountry {
  final String iso_3166_1;
  final String name;

  ProductionCountry({required this.iso_3166_1, required this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso_3166_1: json["iso_3166_1"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {"iso_3166_1": iso_3166_1, "name": name};
}

class SpokenLanguage {
  final String? englishName;
  final String? iso_639_1;
  final String? name;

  SpokenLanguage({
    required this.englishName,
    required this.iso_639_1,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json["englishName"],
      iso_639_1: json["iso_639_1"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "englishName": englishName,
    "iso_639_1": iso_639_1,
    "name": name,
  };
}
