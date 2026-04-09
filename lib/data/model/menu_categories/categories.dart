import 'package:menu_servex/domain/entity/menu_categories/categories.dart';

class CategoriesModel {
   String? category;
   String? banner;
   String? description;

  CategoriesModel({
    required this.category,
    required this.banner,
    required this.description,
  });

  CategoriesModel.fromJson(Map<String,dynamic> data){
    category = data["category"];
    banner = data["banner"];
    description = data["description"];
  }
}

extension CategoriesModelX on CategoriesModel {
  CategoriesEntity toEntity(){
    return CategoriesEntity(category: category!, banner: banner!, description: description!);
  }
}