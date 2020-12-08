// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeData _$RecipeDataFromJson(Map<String, dynamic> json) {
  return RecipeData(
    name: json['name'] as String,
    ingredients: (json['ingredients'] as List)
        ?.map((e) =>
            e == null ? null : Ingredient.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    instructions: json['instructions'] as String,
    cookingTime: json['cookingTime'] == null
        ? null
        : Duration(microseconds: json['cookingTime'] as int),
    isFavorite: json['isFavorite'] as bool,
    category: json['category'] as String,
    numServings: json['numServings'] as int,
  );
}

Map<String, dynamic> _$RecipeDataToJson(RecipeData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'cookingTime': instance.cookingTime?.inMicroseconds,
      'instructions': instance.instructions,
      'isFavorite': instance.isFavorite,
      'category': instance.category,
      'ingredients': instance.ingredients,
      'numServings': instance.numServings,
    };
