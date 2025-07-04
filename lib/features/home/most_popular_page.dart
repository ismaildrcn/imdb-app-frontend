import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_app/data/model/most_popular_movies_model.dart';

class MostPopularPage extends StatelessWidget {
  final List<MostPopularMoviesModel> allMovies;
  const MostPopularPage({super.key, required this.allMovies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 0.70, // Yüksekliği artırmak için oranı düşürün
      ),
      itemCount: allMovies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.push("/movie/${allMovies[index].id}");
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 195,
                height: 270, // Yüksekliği artırdım
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSecondary.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: (allMovies[index].primaryImage != null)
                        ? NetworkImage(allMovies[index].primaryImage!)
                        : AssetImage("assets/img/no-image.jpg")
                              as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 12), // Aralığı artırabilirsiniz
              SizedBox(
                width: 195,
                child: Text(
                  allMovies[index].originalTitle ?? '',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 2, // Satır sayısını artırabilirsiniz
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
