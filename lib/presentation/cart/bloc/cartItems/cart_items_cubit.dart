
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_servex/data/model/cart_items/cart_items.dart';

class CartItemsCubit extends Cubit<List<CartItemsModel>> {
  CartItemsCubit(): super([]);

  final List<CartItemsModel> cartItemsList = [];

  void getCartItemsList() {
    emit(List.from(cartItemsList));
  }

  void addCartItem(CartItemsModel cartItem) {
    final existingIndex = cartItemsList.indexWhere((item) => item == cartItem);

    if (existingIndex != -1) {
      cartItemsList[existingIndex].quantity += 1;
    } else {
      cartItemsList.add(cartItem);
    }

    emit(List.from(cartItemsList));
  }

  void removeCartItem(CartItemsModel cartItem) {
    final existingIndex = cartItemsList.indexWhere((item) => item == cartItem);

    if (existingIndex != -1) {
      if (cartItemsList[existingIndex].quantity > 1) {
        cartItemsList[existingIndex].quantity -= 1;
      } else {
        cartItemsList.removeAt(existingIndex);
      }
    }

    emit(List.from(cartItemsList));
  }

  void clearCartItems() {
    cartItemsList.clear();
    emit(List.from(cartItemsList));
  }

  double totalPrice(){
    double total = 0.0;

 for (var item in cartItemsList) {
    total += (item.price * item.quantity);
 }    

    return total;
  }
}