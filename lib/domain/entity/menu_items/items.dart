import 'dart:collection';

import 'package:equatable/equatable.dart';

class ItemsEntity extends Equatable {
  final String item;
  final String description;
  final String image;
  final String diet;
  // final List price;
  // final List variationName;
  final Map variations;

  ItemsEntity({
    required this.item,
    required this.description,
    required this.image,
    required this.diet,
    // required this.price,
    // required this.variationName,
    required this.variations,
  });

  Map<String,int> get sortedVariations {
    return SplayTreeMap<String, int>.from(
  variations, 
  (a, b) => variations[a]!.compareTo(variations[b]!)
);
  }

   // Convert User Object to Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'description': description,
      'image': image,
      'diet': diet,
      'variations': sortedVariations,
    };
  }

  @override
  List<Object?> get props => [item, description, diet,];
}
