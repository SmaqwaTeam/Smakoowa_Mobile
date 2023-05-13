import 'package:flutter/material.dart';

import '../../utils/endpoints.api.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  // final String rating;
  final String cookTime;
  final String? thumbnailUrl;

  RecipeCard({
    required this.title,
    required this.cookTime,
    // required this.rating,
    this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: const Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.25),
            BlendMode.multiply,
          ),
          image: thumbnailUrl != null
              ? NetworkImage(
                  '${ApiEndPoints.baseUrl}/api/Images/GetRecipeImage/$thumbnailUrl')
              : const NetworkImage(
                  'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&resize=556,505'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    // backgroundColor: Colors.black.withOpacity(0.4),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Container(
                //   padding: const EdgeInsets.all(5),
                //   margin: const EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     color: Colors.black.withOpacity(0.4),
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   child: Row(
                //     children: const [
                //       Icon(
                //         Icons.star,
                //         color: Colors.yellow,
                //         size: 18,
                //       ),
                //       SizedBox(width: 7),
                //       Text(
                //         '5.0',
                //         style: TextStyle(
                //           color: Colors.white,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        cookTime,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
