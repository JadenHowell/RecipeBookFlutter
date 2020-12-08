// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) {
  return Ingredient(
    itemName: json['itemName'] as String,
    measure: _$enumDecodeNullable(_$MeasurementEnumMap, json['measure']),
    amount: (json['amount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'measure': _$MeasurementEnumMap[instance.measure],
      'amount': instance.amount,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$MeasurementEnumMap = {
  Measurement.NA: 'NA',
  Measurement.teaspoon: 'teaspoon',
  Measurement.tablespoon: 'tablespoon',
  Measurement.cup: 'cup',
  Measurement.pint: 'pint',
  Measurement.quart: 'quart',
  Measurement.gallon: 'gallon',
  Measurement.litre: 'litre',
  Measurement.ounce: 'ounce',
  Measurement.pound: 'pound',
  Measurement.kilo: 'kilo',
  Measurement.cube: 'cube',
};
