import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_servex/data/model/cart_items/cart_items.dart';
import 'package:menu_servex/domain/entity/menu_items/items.dart';
import 'package:menu_servex/presentation/cart/bloc/cartItems/cart_items_cubit.dart';
import 'package:menu_servex/presentation/cart/widgets/cart_item_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key,this.items});

  final ItemsEntity? items;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.widthOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(onTap:() => Navigator.pop(context), child: Icon(Icons.arrow_back_ios_new)),
        title: Text("My Cart List"),
      ),
      body: Padding(
        padding:  EdgeInsets.all((screenWidth*0.03).clamp(12, 30)),
        child: BlocBuilder<CartItemsCubit,List<CartItemsModel>>(
          builder: (BuildContext context,cartItems) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(
              maxWidth: 650,
              // maxHeight: 200
            ),
                    child: ListView.separated(
                      itemCount: cartItems.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(height: 16,);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return CartItemCard(cartItems: cartItems[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}