class ReviewsModel {
  ReviewsModel({
    required this.id,
    required this.page,
    required this.reviews,
    required this.totalPages,
    required this.totalResults,
  });

  final int? id;
  final int? page;
  final List<Review> reviews;
  final int? totalPages;
  final int? totalResults;

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      id: json["id"],
      page: json["page"],
      reviews: json["results"] == null
          ? []
          : List<Review>.from(json["results"]!.map((x) => Review.fromJson(x))),
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "page": page,
    "results": reviews.map((x) => x.toJson()).toList(),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Review {
  Review({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  final String? author;
  final AuthorDetails? authorDetails;
  final String? content;
  final DateTime? createdAt;
  final String? id;
  final DateTime? updatedAt;
  final String? url;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json["author"],
      authorDetails: json["author_details"] == null
          ? null
          : AuthorDetails.fromJson(json["author_details"]),
      content: json["content"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
    "author": author,
    "author_details": authorDetails?.toJson(),
    "content": content,
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "updated_at": updatedAt?.toIso8601String(),
    "url": url,
  };
}

class AuthorDetails {
  AuthorDetails({
    required this.name,
    required this.username,
    required this.avatarPath,
    required this.rating,
  });

  final String? name;
  final String? username;
  final String? avatarPath;
  final double? rating;

  factory AuthorDetails.fromJson(Map<String, dynamic> json) {
    return AuthorDetails(
      name: json["name"],
      username: json["username"],
      avatarPath: json["avatar_path"],
      rating: json["rating"] != null ? json["rating"] / 2 : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "avatar_path": avatarPath,
    "rating": rating,
  };
}
