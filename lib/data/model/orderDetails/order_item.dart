
import 'package:menu_servex/domain/entity/orders/order_items.dart';

class OrderItemModel {
        String? item;
    String? diet;
   int? price;
    String? variation;
    int? quantity;
  //  Map? variation;

   OrderItemModel({
    required this.item,
    // required this.description,
    required this.diet,
    required this.quantity,
    required this.price,
    required this.variation,
    // required this.variation,
  });

  OrderItemModel.fromJson(Map<String, dynamic> data) {
    item = data["item"];
    diet = data["diet"];
    price = data["price"];
    variation = data["variation"];
    quantity = data["quantity"];
  }
  
}
  
  extension OrderItemModelX on OrderItemModel {
  OrderItemsEntity toEntity() {
    return OrderItemsEntity(
      item: item,
      diet: diet,
      price: price,
      variation: variation,
      quantity: quantity,
    );
  }
}

    