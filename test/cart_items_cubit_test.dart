import 'package:flutter_test/flutter_test.dart';
import 'package:menu_servex/data/model/cart_items/cart_items.dart';
import 'package:menu_servex/presentation/cart/bloc/cartItems/cart_items_cubit.dart';

void main() {
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
}
