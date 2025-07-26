import 'package:flutter/material.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/data/model/review_model.dart';
import 'package:imdb_app/data/services/constant/api_constants.dart';
import 'package:imdb_app/data/services/reviews_service.dart';
import 'package:imdb_app/features/home/utils/image_utils.dart';

class ReviewPage extends StatefulWidget {
  final int id;
  const ReviewPage({super.key, required this.id});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late final ReviewsService _reviewsService;
  ReviewsModel? reviews;

  @override
  void initState() {
    super.initState();
    _reviewsService = ReviewsService();
    loadData();
  }

  Future<void> loadData() async {
    final response = await _reviewsService.fetchReviews(widget.id);
    setState(() {
      reviews = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topNavBar(context, "Comments"),
      body: reviews == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 18),
                itemCount: reviews!.reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews!.reviews[index];
                  return Container(
                    width: 300,
                    constraints: BoxConstraints(minHeight: 100),
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.secondary
                              .withAlpha(32), // Gölge rengi ve opaklık
                          blurRadius: 5, // Gölge yumuşaklığı
                          spreadRadius: 1, // Gölge yayılması
                          offset: Offset(0, 0), // Gölge pozisyonu (x, y)
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  review.authorDetails!.avatarPath != null
                                  ? ImageHelper.getImage(
                                      review.authorDetails!.avatarPath,
                                      ApiConstants.posterSize.m,
                                    )
                                  : null,
                              child: review.authorDetails!.avatarPath == null
                                  ? Icon(Icons.person_rounded)
                                  : null,
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Text(
                                  review.authorDetails!.name == ""
                                      ? "Anonymous"
                                      : review.authorDetails!.name.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "June 12, 2023",
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text(review.authorDetails!.rating.toString()),
                                Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          review.content.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
