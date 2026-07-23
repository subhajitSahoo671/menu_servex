import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/data/model/cart_items/cart_items.dart';
import 'package:menu_servex/domain/entity/menu_items/items.dart';
import 'package:menu_servex/presentation/cart/bloc/cartItems/cart_items_cubit.dart';
import 'package:menu_servex/presentation/cart/pages/cart_page.dart';
import 'package:svg_flutter/svg.dart';

class Addtocartmodal extends StatefulWidget {
  final ItemsEntity items;

  const Addtocartmodal({super.key, required this.items});

  @override
  State<Addtocartmodal> createState() => _AddtocartmodalState();
}

class _AddtocartmodalState extends State<Addtocartmodal> {
  late String? _selectedValue;
  int itemCount = 1;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.items.sortedVariations.keys.elementAt(0);
  }

  @override
  Widget build(BuildContext context) {

    int totalAmount=  widget.items.sortedVariations[_selectedValue]! * itemCount;

    return Container(
      padding: .all(12),
      height: MediaQuery.heightOf(context),
      width: MediaQuery.widthOf(context),
      child: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                pinned: true,
                toolbarHeight: kToolbarHeight,
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(9999),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20,sigmaY: 20),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.close,size: 28,),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverAppBar(
                expandedHeight: 350.0,
                backgroundColor: AppColors.bg,
                automaticallyImplyLeading: false,
                floating: false,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    // margin: const EdgeInsets.only(right: 12, left: 12, top: 12),
                    padding: .symmetric(horizontal: 12, vertical: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: NetworkImage(widget.items.image),
                        fit: BoxFit.cover,
                        // width: 350,
                        // height: 300,
                      ),
                    ),
                  ),
                ),
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                toolbarHeight: kToolbarHeight * 1.5,
                backgroundColor: Colors.white,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  padding: .only(left: 12,right: 12, bottom: 4,top: 4),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    crossAxisAlignment: .center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: .center,
                          crossAxisAlignment: .start,
                          children: [
                            // diet
                            Row(
                              crossAxisAlignment: .center,
                              children: [
                                SvgPicture.asset(
                                  widget.items.diet == "veg"
                                      ? AppImages.vegIcon
                                      : AppImages.nonVegIcon,
                                  height: 18,
                                  width: 18,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  widget.items.diet,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: .w400,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            //title
                            Text(
                              widget.items.item,
                              maxLines: 2,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8,),
                      //itemCount
                      Row(
                        children: [
                          IconButton.filledTonal(
                            onPressed: () {
                              setState(() {
                                if (itemCount > 1) {
                                  itemCount -= 1;
                                }
                              });
                            },
                            icon: Icon(Icons.remove),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "$itemCount",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: .w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(width: 4),
                          IconButton.filled(
                            onPressed: () {
                              setState(() {
                                if (itemCount < 20) {
                                  itemCount += 1;
                                }
                              });
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    //description
                    Container(
                      padding: .only(left: 12, right: 12, top: 4, bottom: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: Text(
                        widget.items.description,
                        style: TextStyle(
                          // overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    //size(variations)
                    Container(
                      padding: .symmetric(horizontal: 12, vertical: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            "Size",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                              // height: 1.1
                            ),
                          ),
                          SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.items.sortedVariations.length,
                            itemBuilder: (BuildContext context, int index) {
                            var variationName =  widget.items.sortedVariations.keys.elementAt(index);
                              return Material(
                                color: Colors.transparent,
                                child: RadioListTile<String>(
                                  title: Row(
                                    mainAxisAlignment: .spaceBetween,
                                    crossAxisAlignment: .center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          variationName,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: _selectedValue == variationName ? FontWeight.w600: .w400,
                                            color:  _selectedValue == variationName ? AppColors.textPrimary :AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "₹${widget.items.sortedVariations[variationName]}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: _selectedValue == variationName ? FontWeight.w600: .w400,
                                          color:  _selectedValue == variationName ? AppColors.textPrimary :AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  value: variationName,
                                  contentPadding: .symmetric(horizontal: 8),
                                  horizontalTitleGap: 0,
                                  groupValue: _selectedValue,
                                  controlAffinity: ListTileControlAffinity.trailing,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedValue = value;
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                SizedBox(height: 120,)
                
                  ],
                ),
              ),
            ],
          ),
       
       Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(height: 80,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 4),
      child: Container(
        // height: 50,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.textPrimary.withAlpha(50)),
        boxShadow: [
          BoxShadow(
            blurRadius: 7,
            spreadRadius: 0,
            offset: Offset(0, 2),
            color: AppColors.textPrimary.withAlpha(50)
          )
        ]
      ),
      child: Row(
        children: [
              //price 
              Expanded(child: Center(child: Text("₹${totalAmount.toStringAsFixed(2)}",style: TextStyle(fontSize: 16,fontWeight: .w600,color: AppColors.primary)))),
              // AddToCartButton
              Expanded(
                flex: 2,
                child: FilledButton(onPressed: () {
                  context.read<CartItemsCubit>().addCartItem(CartItemsModel(item: widget.items.item, image: widget.items.image, diet: widget.items.diet, quantity: itemCount, variation: _selectedValue!,price: widget.items.sortedVariations[_selectedValue]!));
                  //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  //  return  CartPage(items: widget.items);
                  //  },));
                }, child: Container(
                  decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .center,
                      children: [
                        Icon(Icons.shopping_cart_outlined,size: 18,color: AppColors.bg,),
                        SizedBox(width: 8,),
                        Text("Add To Cart",style: TextStyle(fontSize: 14,fontWeight: .w400,color: AppColors.bg),)
                      ],
                    ),
                  ),
                )),
              )
        ],
      ),
      ),
      ))
        ],
      ),
    );
  }
}
