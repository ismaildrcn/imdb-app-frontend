class MovieModel {
  final String id;
  final String url;
  final String primaryTitle;
  final String? originalTitle;
  final String type;
  final String? description;
  final String? primaryImage;
  final List<Thumbnail> thumbnails;
  final String? trailer;
  final String? contentRating;
  final int startYear;
  final dynamic endYear;
  final DateTime? releaseDate;
  final List<String> interests;
  final List<String> countriesOfOrigin;
  final List<dynamic> externalLinks;
  final List<String> spokenLanguages;
  final List<String> filmingLocations;
  final List<ProductionCompany> productionCompanies;
  final int? budget;
  final int? grossWorldwide;
  final List<String> genres;
  final bool? isAdult;
  final int? runtimeMinutes;
  final double? averageRating;
  final int? numVotes;
  final int? metascore;
  final List<Directory>? directors;
  final List<Writer>? writers;
  final List<Actor>? cast;

  MovieModel({
    required this.id,
    required this.url,
    required this.primaryTitle,
    required this.originalTitle,
    required this.type,
    required this.description,
    required this.primaryImage,
    required this.thumbnails,
    required this.trailer,
    required this.contentRating,
    required this.startYear,
    required this.endYear,
    required this.releaseDate,
    required this.interests,
    required this.countriesOfOrigin,
    required this.externalLinks,
    required this.spokenLanguages,
    required this.filmingLocations,
    required this.productionCompanies,
    required this.budget,
    required this.grossWorldwide,
    required this.genres,
    required this.isAdult,
    required this.runtimeMinutes,
    required this.averageRating,
    required this.numVotes,
    required this.metascore,
    this.directors,
    this.writers,
    this.cast,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"],
      url: json["url"],
      primaryTitle: json["primaryTitle"],
      originalTitle: json["originalTitle"],
      type: json["type"],
      description: json["description"],
      primaryImage: json["primaryImage"],
      thumbnails: json["thumbnails"] == null
          ? []
          : List<Thumbnail>.from(
              json["thumbnails"]!.map((x) => Thumbnail.fromJson(x)),
            ),
      trailer: json["trailer"],
      contentRating: json["contentRating"],
      startYear: json["startYear"],
      endYear: json["endYear"],
      releaseDate: DateTime.tryParse(json["releaseDate"] ?? ""),
      interests: json["interests"] == null
          ? []
          : List<String>.from(json["interests"]!.map((x) => x)),
      countriesOfOrigin: json["countriesOfOrigin"] == null
          ? []
          : List<String>.from(json["countriesOfOrigin"]!.map((x) => x)),
      externalLinks: json["externalLinks"] == null
          ? []
          : List<dynamic>.from(json["externalLinks"]!.map((x) => x)),
      spokenLanguages: json["spokenLanguages"] == null
          ? []
          : List<String>.from(json["spokenLanguages"]!.map((x) => x)),
      filmingLocations: json["filmingLocations"] == null
          ? []
          : List<String>.from(json["filmingLocations"]!.map((x) => x)),
      productionCompanies: json["productionCompanies"] == null
          ? []
          : List<ProductionCompany>.from(
              json["productionCompanies"]!.map(
                (x) => ProductionCompany.fromJson(x),
              ),
            ),
      budget: json["budget"],
      grossWorldwide: json["grossWorldwide"],
      genres: json["genres"] == null
          ? []
          : List<String>.from(json["genres"]!.map((x) => x)),
      isAdult: json["isAdult"],
      runtimeMinutes: json["runtimeMinutes"],
      averageRating: json["averageRating"] != null
          ? (json["averageRating"] as num).toDouble()
          : null,
      numVotes: json["numVotes"],
      metascore: json["metascore"],
      directors: json['directors'] == null
          ? []
          : List<Directory>.from(
              json["directors"]!.map((x) => Directory.fromJson(json)),
            ),
      writers: json['writers'] == null
          ? []
          : List<Writer>.from(
              json["writers"]!.map((x) => Writer.fromJson(json)),
            ),
      cast: json['cast'] == null
          ? []
          : List<Actor>.from(json["cast"]!.map((x) => Actor.fromJson(json))),
    );
  }
}

class Thumbnail {
  Thumbnail({required this.url, required this.width, required this.height});

  final String? url;
  final int? width;
  final int? height;

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      url: json["url"],
      width: json["width"],
      height: json["height"],
    );
  }

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
  };
}

class Directory {
  final String id;
  final String url;
  final String fullName;

  Directory({required this.id, required this.url, required this.fullName});

  factory Directory.fromJson(Map<String, dynamic> json) {
    return Directory(
      id: json['id'],
      url: json['url'],
      fullName: json['fullName'],
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "url": url, "fullName": fullName};
}

class Writer {
  final String id;
  final String url;
  final String fullName;

  Writer({required this.id, required this.url, required this.fullName});

  factory Writer.fromJson(Map<String, dynamic> json) {
    return Writer(id: json['id'], url: json['url'], fullName: json['fullName']);
  }

  Map<String, dynamic> toJson() => {"id": id, "url": url, "fullName": fullName};
}

class Actor {
  final String id;
  final String url;
  final String fullName;
  final String primaryImage;
  final List<Thumbnail> thumbnails;
  final String job;
  final List<dynamic> characters;

  Actor({
    required this.id,
    required this.url,
    required this.fullName,
    required this.primaryImage,
    required this.thumbnails,
    required this.job,
    required this.characters,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['id'],
      url: json['url'],
      fullName: json['fullName'],
      primaryImage: json['primaryImage'],
      thumbnails: json['thumbnails'],
      job: json['job'],
      characters: json['characters'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "fullName": fullName,
    "primaryImage": primaryImage,
    "thumbnails": thumbnails,
    "job": job,
    "characters": characters,
  };
}

class ProductionCompany {
  ProductionCompany({required this.id, required this.name});

  final String? id;
  final String? name;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(id: json["id"], name: json["name"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
