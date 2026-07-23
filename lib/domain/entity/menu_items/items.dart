import 'dart:collection';

class ItemsEntity {
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
}
