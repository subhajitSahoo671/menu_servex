import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:menu_servex/data/model/cart_items/cart_items.dart';
import 'package:menu_servex/domain/entity/menu_items/items.dart';
import 'package:menu_servex/presentation/cart/bloc/cartItems/cart_items_cubit.dart';
import 'package:menu_servex/presentation/favorite/bloc/favorite_items_cubit.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  group('CartItemsCubit', () {
    test('increments quantity for an existing cart item', () {
      final cubit = CartItemsCubit();
      final firstItem = CartItemsModel(
        item: 'Burger',
        image: 'burger.png',
        diet: 'veg',
        quantity: 1,
        price: 120,
        variation: 'small',
      );

      cubit.addCartItem(firstItem);
      cubit.addCartItem(
        CartItemsModel(
          item: 'Burger',
          image: 'burger.png',
          diet: 'veg',
          quantity: 1,
          price: 120,
          variation: 'small',
        ),
      );

      expect(cubit.state.length, 1);
      expect(cubit.state.first.quantity, 2);
    });
  });

  group('FavoriteItemsCubit', () {
    test('serializes and restores favorite items from json', () {
      final cubit = FavoriteItemsCubit();
      final item = ItemsEntity(
        item: 'Burger',
        description: 'Tasty burger',
        image: 'burger.png',
        diet: 'veg',
        variations: {'small': 120, 'large': 180},
      );

      cubit.emit([item]);
      final json = cubit.toJson(cubit.state);
      final restored = cubit.fromJson(json!);

      expect(restored, isNotNull);
      expect(restored!.length, 1);
      expect(restored.first.item, 'Burger');
      expect(restored.first.variations['large'], 180);
    });
  });
}
