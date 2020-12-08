import 'package:json_annotation/json_annotation.dart';

import 'measurements.dart';

part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient{
  String itemName;
  Measurement measure;
  double amount;

  Ingredient({
    this.itemName,
    this.measure,
    this.amount,
  });

  static Ingredient fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientToJson(this);


  @override
  bool operator ==(other){
    return ((this.itemName == other.itemName) && (this.measure == other.measure) && (this.amount == other.amount));
  }

}