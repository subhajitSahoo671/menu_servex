import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_servex/data/model/cart_items/cart_items.dart';

class CartItemsCubit extends Cubit<List<CartItemsModel>>{
  CartItemsCubit(): super([]);

  List<CartItemsModel> cartItemsList = [];


  void getCartItemsList(){
    emit(cartItemsList);
  }

  void addCartItem(CartItemsModel cartItem){
    cartItemsList.add(cartItem);
    emit(cartItemsList);
  }

  void removeCartItem(CartItemsModel cartItem){
    cartItemsList.remove(cartItem);
    emit(cartItemsList);
  }
}