import 'package:menu_servex/domain/entity/menu_items/items.dart';

class ItemsModel {
   String? item;
   String? description;
   String? image;
   String? diet;
  //  List? price;
  //  List? variationName;
   Map? variations;

  ItemsModel({
    required this.item,
    required this.description,
    required this.image,
    required this.diet,
    // required this.price,
    // required this.variationName,
    required this.variations,
  });

ItemsModel.fromJson(Map<String,dynamic> data){
    item = data["item"];
    description = data["description"];
    image = data["image"];
    diet = data["diet"];
    // price = data["price"];
    // variationName = data["variation name"];
    variations = data["variation"];
  }
}

extension ItemsModelX on ItemsModel {
  ItemsEntity toEntity(){
    return ItemsEntity(item: item!, description: description!,image: image!,diet: diet!,variations:variations!);
  }
}