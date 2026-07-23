class CartItemsModel {
      final  String item;
  //  String? description;
   final String image;
  final  String diet;
  final int price;
  final  String variation;
   final int quantity;
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
}