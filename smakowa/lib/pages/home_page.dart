import 'package:flutter/material.dart';
import 'package:smakowa/pages/recipe_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 22,
            ),
            child: const Text(
              'Recomended for you',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          RecipeCard(
              title: 'My recipe',
              cookTime: '20 min',
              rating: '5',
              thumbnailUrl:
                  'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&resize=556,505'),
          RecipeCard(
              title: 'Pasta dish',
              cookTime: '10 min',
              rating: '4.0',
              thumbnailUrl:
                  'https://hips.hearstapps.com/hmg-prod/images/easy-dinner-recipes-1676057761.jpeg'),
          RecipeCard(
              title: 'Chicken with honey dressing rice and vegetables',
              cookTime: '10 min',
              rating: '4.0',
              thumbnailUrl:
                  'https://images.themodernproper.com/billowy-turkey/production/posts/2022/MarryMeChicken_7.jpg?w=1200&h=1800&q=82&fm=jpg&fit=crop&dm=1661981453&s=eda3bbe6bf02f7b108d003457c1ea99e'),
          RecipeCard(
              title: 'Pancakes',
              cookTime: '10 min',
              rating: '4.0',
              thumbnailUrl: 'thumbnailUrl'),
        ],
      ),
    );
  }
}
