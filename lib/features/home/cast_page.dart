import 'package:flutter/material.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/data/model/movie_model.dart';

class CastPage extends StatefulWidget {
  final List<Actor> cast;
  const CastPage({super.key, required this.cast});

  @override
  State<CastPage> createState() => _CastPageState();
}

class _CastPageState extends State<CastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topNavBar(context, "Cast"),
      body: SafeArea(
        child: widget.cast.isEmpty
            ? const Center(child: Text("No cast available"))
            : Padding(
                padding: const EdgeInsets.all(18),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: 4,
                    childAspectRatio:
                        0.75, // Yüksekliği artırmak için oranı düşürün
                  ),
                  itemCount: widget.cast.length,
                  itemBuilder: (context, index) {
                    final actor = widget.cast[index];
                    return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 82,
                            height: 87,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSecondary.withAlpha(25),
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: (actor.primaryImage != null)
                                    ? NetworkImage(actor.primaryImage!)
                                    : AssetImage("assets/img/no-image.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            actor.fullName!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
