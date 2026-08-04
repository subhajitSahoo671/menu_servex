import 'package:equatable/equatable.dart';

class CartItemsModel extends Equatable{
      final  String item;
  //  String? description;
   final String image;
  final  String diet;
  final int price;
  final  String variation;
    int quantity;
  //  Map? variation;

   CartItemsModel({
    required this.item,
    // required this.description,
    required this.image,
    required this.diet,
    required this.quantity,
    required this.price,
    required this.variation,
    // required this.variation,
  });

  Map<String, dynamic> toJson() {
    return {
      'item': item,
      // 'image': image,
      'diet': diet,
      'quantity': quantity,
      'price': price,
      'variation': variation,
    };
  }
  
  @override
  List<Object?> get props => [item, image, diet, price, variation];
}