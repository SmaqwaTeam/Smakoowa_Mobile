import 'package:flutter/material.dart';

import '../../models/recipe.dart';

class RecipeIngredientsList extends StatelessWidget {
  final List<Ingredients> recipeInfo;
  // final List<Instructions>? temp;

  RecipeIngredientsList({
    required this.recipeInfo,
    // this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
            top: 5.0,
            bottom: 15.0,
          ),
          child: const Text(
            'Ingredients',
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: const Color(0x33FF5C4D),
          ),
          margin: const EdgeInsets.only(
            bottom: 15.0,
          ),
          padding: const EdgeInsets.only(
            top: 5.0,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(
                      bottom: recipeInfo.length - 1 == index ? 5.0 : 0.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    leading: const CircleAvatar(
                      radius: 10.0,
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      child: Icon(
                        Icons.check,
                        size: 13.0,
                      ),
                    ),
                    title: Text(
                      recipeInfo[index].getName(),
                      style: const TextStyle(
                        color: Color(0xBB000000),
                      ),
                    ),
                  ),
                  Container()
                ],
              );
            },
            itemCount: recipeInfo.length,
          ),
        ),
      ],
    );
  }
}

class RecipeInstructionList extends StatelessWidget {
  final List<Instructions> recipeInfo;
  // final List<Instructions>? temp;

  RecipeInstructionList({
    required this.recipeInfo,
    // this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
            top: 5.0,
            bottom: 15.0,
          ),
          child: const Text(
            'Cooking Instructions',
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0x33FF5C4D),
          ),
          margin: const EdgeInsets.only(
            bottom: 15.0,
          ),
          padding: const EdgeInsets.only(
            top: 5.0,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(
                      bottom: recipeInfo.length - 1 == index ? 5.0 : 0.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    leading: Text(
                      'Step ${index + 1}',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(
                      recipeInfo[index].getName(),
                      style: const TextStyle(
                        color: Color(0xBB000000),
                      ),
                    ),
                  ),
                  recipeInfo.length - 1 == index
                      ? Container()
                      : const Divider(
                          thickness: 0.2,
                          color: Colors.black54,
                          indent: 15.0,
                          endIndent: 15.0,
                        ),
                ],
              );
            },
            itemCount: recipeInfo.length,
          ),
        ),
      ],
    );
  }
}

//backup
// class RecipeDetailsList extends StatelessWidget {
//   final String title;
//   final List<dynamic> recipeInfo;
//   final List<Instructions>? temp;

//   RecipeDetailsList({
//     required this.title,
//     required this.recipeInfo,
//     this.temp,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           alignment: Alignment.center,
//           margin: EdgeInsets.only(
//             top: 5.0,
//             bottom: 15.0,
//           ),
//           child: Text(
//             title,
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15.0),
//             color: Color(0x33FF5C4D),
//           ),
//           margin: EdgeInsets.only(
//             bottom: 15.0,
//           ),
//           padding: EdgeInsets.only(
//             top: 5.0,
//           ),
//           child: ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               return Column(
//                 children: [
//                   ListTile(
//                     contentPadding: EdgeInsets.only(
//                       bottom: recipeInfo.length - 1 == index ? 5.0 : 0.0,
//                       left: 15.0,
//                       right: 15.0,
//                     ),
//                     leading: title == 'Ingredients'
//                         ? const CircleAvatar(
//                             radius: 10.0,
//                             backgroundColor: Colors.orange,
//                             foregroundColor: Colors.white,
//                             child: Icon(
//                               Icons.check,
//                               size: 13.0,
//                             ),
//                           )
//                         : Text(
//                             'Step ${index + 1}',
//                             style: TextStyle(
//                               color: Colors.orange,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                     title: Text(
//                       title != 'Ingredients'
//                           ? temp![index].content
//                           : recipeInfo[index],
//                       style: TextStyle(
//                         color: Color(0xBB000000),
//                       ),
//                     ),
//                   ),
//                   title != 'Cooking Instructions'
//                       ? Container()
//                       : recipeInfo.length - 1 == index
//                           ? Container()
//                           : Divider(
//                               thickness: 0.2,
//                               color: Colors.black54,
//                               indent: 15.0,
//                               endIndent: 15.0,
//                             ),
//                 ],
//               );
//             },
//             itemCount: recipeInfo.length,
//           ),
//         ),
//       ],
//     );
//   }
// }