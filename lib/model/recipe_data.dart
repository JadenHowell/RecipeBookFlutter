import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'ingredient.dart';

part 'recipe_data.g.dart';
@JsonSerializable()
class RecipeData {
  String name;
  //TODO: Figure out how to get pictures to be saved with the recipe. Should there be pictures? Optional final step.
  Duration cookingTime;
  String instructions;
  bool isFavorite;
  String category;
  List<Ingredient> ingredients;
  int numServings;

  RecipeData({
    @required this.name,
    @required this.ingredients,
    @required this.instructions,
    this.cookingTime,
    this.isFavorite = false,
    this.category = 'Other',
    this.numServings,
  });

  static RecipeData fromJson(Map<String, dynamic> json) => _$RecipeDataFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeDataToJson(this);

  @override
  bool operator ==(other){
    return ((this.name == other.name) && (this.cookingTime == other.cookingTime) && (this.instructions == other.instructions) &&
        (this.isFavorite == other.isFavorite) && (this.category == other.category) && (this.ingredients == other.ingredients) && (this.numServings == other.numServings));
  }

  @override
  int get hashCode => (name.hashCode + cookingTime.hashCode + instructions.hashCode + isFavorite.hashCode - category.hashCode - ingredients.hashCode + numServings.hashCode).abs();



}
