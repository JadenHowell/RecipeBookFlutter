import 'dart:convert';

import 'package:recipebook/model/recipe_data.dart';

import 'package:recipebook/model/storage.dart';

import 'ingredient.dart';
import 'measurements.dart';

class ReData{
  static ReData _instance;
  Storage _storage;
  List<RecipeData> actualData;

  ReData._private(){
    _storage = Storage();
    actualData = [];
  }

  ReData._testPrivate() {
    actualData = _testDataList;
    _storage = Storage();
  }

  factory ReData() {
    if (_instance == null) {
      _instance = ReData._private();
    }
    return _instance;
  }

  factory ReData.test() {
    if (_instance == null) {
      _instance = ReData._testPrivate();
    }
    return _instance;
  }

  Future init() async {
    actualData = await readData();
  }

  Future saveData() {
    sortData();

    String recipeListString = jsonEncode(actualData);
    String data = '{ "data": $recipeListString }';
    return _storage.writeData(data);
  }

  void sortData(){
    actualData.sort((a,b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

  Future<List<RecipeData>> readData() async {
    String data = await _storage.readData();
    final map = jsonDecode(data);
    return (map['data'] as List<dynamic>).map((e) => RecipeData.fromJson(e)).toList();
  }

  static List<RecipeData> get _testDataList => [
    RecipeData(
      name: 'No bake cookies',
      ingredients: [
        Ingredient(
          itemName: 'milk',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'sugar',
          amount: 2,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'peanut butter',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'cocoa',
          amount: 3,
          measure: Measurement.tablespoon,
        ),
        Ingredient(
          itemName: 'quick oats',
          amount: 4,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'butter',
          amount: 1,
          measure: Measurement.cube,
        ),
        Ingredient(
          itemName: 'vanilla',
          amount: 1,
          measure: Measurement.teaspoon,
        ),
        Ingredient(
          itemName: 'minced test ingredient',
          amount: 8,
          measure: Measurement.pound,
        ),
        Ingredient(
          itemName:
          'this is really just to see if someone had a really long ingredient name would this work',
          amount: 7,
          measure: Measurement.kilo,
        ),
      ],
      instructions:
      'First, do the first thing. \nSecond, do the next thing\nThen the next\nThen the next\nAnd so on\nAnd so on\nUntil the cookies are done.\nDid you get all that?',
      cookingTime: Duration(hours: 1, minutes: 15),
      isFavorite: true,
      category: 'Dessert',
      numServings: 4,
    ),
    RecipeData(
      name: 'Second recipe',
      ingredients: [
        Ingredient(
          itemName: 'water',
          amount: 8,
          measure: Measurement.teaspoon,
        ),
        Ingredient(
          itemName: 'sugar',
          amount: 2,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'salt',
          amount: 3,
          measure: Measurement.gallon,
        ),
        Ingredient(
          itemName: 'butter',
          amount: 1,
          measure: Measurement.cube,
        ),
        Ingredient(
          itemName: 'vanilla',
          amount: 1,
          measure: Measurement.NA,
        ),
        Ingredient(
          itemName: 'minced test ingredient',
          amount: 8,
          measure: Measurement.pound,
        ),
      ],
      instructions: 'This is a test recipe lol',
      cookingTime: Duration(hours: 8, minutes: 5),
      isFavorite: true,
      category: 'Dessert',
      numServings: 4,
    ),
    RecipeData(
      name: 'Chow Mein',
      ingredients: [
        Ingredient(
          itemName: 'noodles',
          amount: 2,
          measure: Measurement.pound,
        ),
        Ingredient(
          itemName: 'soy sauce',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'minced spring onion',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'salt',
          amount: 2,
          measure: Measurement.teaspoon,
        ),
        Ingredient(
          itemName: 'oyster sauce',
          amount: 4,
          measure: Measurement.kilo,
        ),
        Ingredient(
          itemName: 'oil',
          amount: 1,
          measure: Measurement.cube,
        ),
        Ingredient(
          itemName: 'vanilla',
          amount: 1,
          measure: Measurement.teaspoon,
        ),
      ],
      instructions:
      'literraly just throw it all in a wok\nits not rocket science\ni believe you can do it\nand if you believe too it will be done\nso basically加油',
      cookingTime: Duration(hours: 1, minutes: 15),
      isFavorite: true,
      category: 'chinese',
      numServings: 4,
    ),
    RecipeData(
      name: 'No bake cookies 2.0',
      ingredients: [
        Ingredient(
          itemName: 'milk',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'sugar',
          amount: 2,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'peanut butter',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'cocoa',
          amount: 3,
          measure: Measurement.tablespoon,
        ),
        Ingredient(
          itemName: 'quick oats',
          amount: 4,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'butter',
          amount: 1,
          measure: Measurement.cube,
        ),
        Ingredient(
          itemName: 'vanilla',
          amount: 1,
          measure: Measurement.teaspoon,
        ),
        Ingredient(
          itemName: 'minced test ingredient',
          amount: 8,
          measure: Measurement.pound,
        ),
        Ingredient(
          itemName:
          'this is really just to see if someone had a really long ingredient name would this work',
          amount: 7,
          measure: Measurement.kilo,
        ),
      ],
      instructions:
      'First, do the first thing. \nSecond, do the next thing\nThen the next\nThen the next\nAnd so on\nAnd so on\nUntil the cookies are done.\nDid you get all that?',
      cookingTime: Duration(hours: 1, minutes: 15),
      isFavorite: true,
      category: 'Dessert',
      numServings: 4,
    ),
    RecipeData(
      name: 'No bake cookies 3.0',
      ingredients: [
        Ingredient(
          itemName: 'milk',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'sugar',
          amount: 2,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'peanut butter',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'cocoa',
          amount: 3,
          measure: Measurement.tablespoon,
        ),
        Ingredient(
          itemName: 'quick oats',
          amount: 4,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'butter',
          amount: 1,
          measure: Measurement.cube,
        ),
        Ingredient(
          itemName: 'vanilla',
          amount: 1,
          measure: Measurement.teaspoon,
        ),
        Ingredient(
          itemName: 'minced test ingredient',
          amount: 8,
          measure: Measurement.pound,
        ),
        Ingredient(
          itemName:
          'this is really just to see if someone had a really long ingredient name would this work',
          amount: 7,
          measure: Measurement.kilo,
        ),
      ],
      instructions:
      'First, do the first thing. \nSecond, do the next thing\nThen the next\nThen the next\nAnd so on\nAnd so on\nUntil the cookies are done.\nDid you get all that?',
      cookingTime: Duration(hours: 1, minutes: 15),
      isFavorite: true,
      category: 'Dessert',
      numServings: 4,
    ),
    RecipeData(
      name: 'No bake cookies 4.0',
      ingredients: [
        Ingredient(
          itemName: 'milk',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'sugar',
          amount: 2,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'peanut butter',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'cocoa',
          amount: 3,
          measure: Measurement.tablespoon,
        ),
        Ingredient(
          itemName: 'quick oats',
          amount: 4,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'butter',
          amount: 1,
          measure: Measurement.cube,
        ),
        Ingredient(
          itemName: 'vanilla',
          amount: 1,
          measure: Measurement.teaspoon,
        ),
        Ingredient(
          itemName: 'minced test ingredient',
          amount: 8,
          measure: Measurement.pound,
        ),
        Ingredient(
          itemName:
          'this is really just to see if someone had a really long ingredient name would this work',
          amount: 7,
          measure: Measurement.kilo,
        ),
      ],
      instructions:
      'First, do the first thing. \nSecond, do the next thing\nThen the next\nThen the next\nAnd so on\nAnd so on\nUntil the cookies are done.\nDid you get all that?',
      cookingTime: Duration(hours: 1, minutes: 15),
      isFavorite: true,
      category: 'Dessert',
      numServings: 4,
    ),
    RecipeData(
      name: 'No bake cookies 4.1',
      ingredients: [
        Ingredient(
          itemName: 'milk',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'sugar',
          amount: 2,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'peanut butter',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'cocoa',
          amount: 3,
          measure: Measurement.tablespoon,
        ),
        Ingredient(
          itemName: 'quick oats',
          amount: 4,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'butter',
          amount: 1,
          measure: Measurement.cube,
        ),
        Ingredient(
          itemName: 'vanilla',
          amount: 1,
          measure: Measurement.teaspoon,
        ),
        Ingredient(
          itemName: 'minced test ingredient',
          amount: 8,
          measure: Measurement.pound,
        ),
        Ingredient(
          itemName:
          'this is really just to see if someone had a really long ingredient name would this work',
          amount: 7,
          measure: Measurement.kilo,
        ),
      ],
      instructions:
      'First, do the first thing. \nSecond, do the next thing\nThen the next\nThen the next\nAnd so on\nAnd so on\nUntil the cookies are done.\nDid you get all that?',
      cookingTime: Duration(hours: 1, minutes: 15),
      isFavorite: true,
      category: 'Dessert',
      numServings: 4,
    ),
    RecipeData(
      name: 'No bake cookies 5.0',
      ingredients: [
        Ingredient(
          itemName: 'milk',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'sugar',
          amount: 2,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'peanut butter',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'cocoa',
          amount: 3,
          measure: Measurement.tablespoon,
        ),
        Ingredient(
          itemName: 'quick oats',
          amount: 4,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'butter',
          amount: 1,
          measure: Measurement.cube,
        ),
        Ingredient(
          itemName: 'vanilla',
          amount: 1,
          measure: Measurement.teaspoon,
        ),
        Ingredient(
          itemName: 'minced test ingredient',
          amount: 8,
          measure: Measurement.pound,
        ),
        Ingredient(
          itemName:
          'this is really just to see if someone had a really long ingredient name would this work',
          amount: 7,
          measure: Measurement.kilo,
        ),
      ],
      instructions:
      'First, do the first thing. \nSecond, do the next thing\nThen the next\nThen the next\nAnd so on\nAnd so on\nUntil the cookies are done.\nDid you get all that?',
      cookingTime: Duration(hours: 1, minutes: 15),
      isFavorite: true,
      category: 'Dessert',
      numServings: 4,
    ),
    RecipeData(
      name: 'No bake cookies 6.66',
      ingredients: [
        Ingredient(
          itemName: 'milk',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'sugar',
          amount: 2,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'peanut butter',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'cocoa',
          amount: 3,
          measure: Measurement.tablespoon,
        ),
        Ingredient(
          itemName: 'quick oats',
          amount: 4,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'butter',
          amount: 1,
          measure: Measurement.cube,
        ),
        Ingredient(
          itemName: 'vanilla',
          amount: 1,
          measure: Measurement.teaspoon,
        ),
        Ingredient(
          itemName: 'minced test ingredient',
          amount: 8,
          measure: Measurement.pound,
        ),
        Ingredient(
          itemName:
          'this is really just to see if someone had a really long ingredient name would this work',
          amount: 7,
          measure: Measurement.kilo,
        ),
      ],
      instructions:
      'First, do the first thing. \nSecond, do the next thing\nThen the next\nThen the next\nAnd so on\nAnd so on\nUntil the cookies are done.\nDid you get all that?',
      cookingTime: Duration(hours: 1, minutes: 15),
      isFavorite: true,
      category: 'Dessert',
      numServings: 4,
    ),
    RecipeData(
      name: 'No bake cookies 420',
      ingredients: [
        Ingredient(
          itemName: 'milk',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'sugar',
          amount: 2,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'peanut butter',
          amount: .5,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'cocoa',
          amount: 3,
          measure: Measurement.tablespoon,
        ),
        Ingredient(
          itemName: 'quick oats',
          amount: 4,
          measure: Measurement.cup,
        ),
        Ingredient(
          itemName: 'butter',
          amount: 1,
          measure: Measurement.cube,
        ),
        Ingredient(
          itemName: 'vanilla',
          amount: 1,
          measure: Measurement.teaspoon,
        ),
        Ingredient(
          itemName: 'minced test ingredient',
          amount: 8,
          measure: Measurement.pound,
        ),
        Ingredient(
          itemName:
          'this is really just to see if someone had a really long ingredient name would this work',
          amount: 7,
          measure: Measurement.kilo,
        ),
      ],
      instructions:
      'First, do the first thing. \nSecond, do the next thing\nThen the next\nThen the next\nAnd so on\nAnd so on\nUntil the cookies are done.\nDid you get all that?',
      cookingTime: Duration(hours: 1, minutes: 15),
      isFavorite: true,
      category: 'other',
      numServings: 4,
    ),
  ];

}