class OrderItemsEntity {
    String? item;
    String? diet;
   int? price;
    String? variation;
    int? quantity;
  //  Map? variation;

   OrderItemsEntity({
    required this.item,
    // required this.description,
    required this.diet,
    required this.quantity,
    required this.price,
    required this.variation,
    // required this.variation,
  });
}