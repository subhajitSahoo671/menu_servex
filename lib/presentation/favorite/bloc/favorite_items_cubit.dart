
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:menu_servex/domain/entity/menu_items/items.dart';

class FavoriteItemsCubit extends HydratedCubit<List<ItemsEntity>> {
  FavoriteItemsCubit() : super([]);

  void getFavoriteItemsList() {
    emit(List.from(state));
  }

  void addFavoriteItem(ItemsEntity favoriteItem) {
    emit([...state, favoriteItem]);
  }

  void removeFavoriteItem(ItemsEntity favoriteItem) {
    final updated = state.where((item) => item != favoriteItem).toList();
    emit(updated);
  }

  void clearFavoriteItems() {
    emit([]);
  }

  @override
  List<ItemsEntity>? fromJson(Map<String, dynamic> json) {
    final itemsJson = (json['favoriteItems'] as List<dynamic>? ?? const [])
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();

    return itemsJson
        .map(
          (item) => ItemsEntity(
            item: item['item'] ?? '',
            description: item['description'] ?? '',
            image: item['image'] ?? '',
            diet: item['diet'] ?? '',
            variations: item['variations'] is Map
                ? Map<String, dynamic>.from(item['variations'])
                : <String, dynamic>{},
          ),
        )
        .toList();
  }

  @override
  Map<String, dynamic>? toJson(List<ItemsEntity> favoriteItems) {
    return {
      'favoriteItems': favoriteItems.map((item) => item.toJson()).toList(),
    };
  }
}
