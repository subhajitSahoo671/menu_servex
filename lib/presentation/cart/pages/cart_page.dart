import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_servex/core/configs/constants.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/data/model/cart_items/cart_items.dart';
import 'package:menu_servex/data/model/orderDetails/order_details.dart';
import 'package:menu_servex/domain/entity/menu_items/items.dart';
import 'package:menu_servex/domain/usecases/orders/confirm_orders_details.dart';
import 'package:menu_servex/common/custom_snackbar.dart';
import 'package:menu_servex/presentation/cart/bloc/cartItems/cart_items_cubit.dart';
import 'package:menu_servex/presentation/cart/widgets/cart_item_card.dart';
import 'package:menu_servex/presentation/landing/landing_page.dart';
import 'package:menu_servex/presentation/orders/pages/all_orders.dart';
import 'package:menu_servex/service_locator.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, this.items});

  final ItemsEntity? items;

  // final String? tableNum;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.widthOf(context);
    final String displayTableNum = TableNum.tableNum;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          overlayColor: .all(Colors.transparent),
          splashColor: Colors.transparent,
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text("My Cart List"),
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            label: Text(displayTableNum, style: TextStyle(fontSize: 16)),
            icon: Icon(Icons.table_bar, size: 20),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: (screenWidth * 0.04).clamp(12, 90),
          left: (screenWidth * 0.04).clamp(12, 90),
          // top: (screenWidth * 0.04).clamp(12, 30),
        ),
        child: BlocBuilder<CartItemsCubit, List<CartItemsModel>>(
          builder: (BuildContext context, cartItems) {
            var totalPrice = context.read<CartItemsCubit>().totalPrice();
            var tax = (totalPrice * 0.05).floorToDouble();
            return cartItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 100,
                          color: AppColors.textPrimary,
                        ),
                        SizedBox(height: 32),
                        Text(
                          "Your cart is empty!",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 16),
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Order now"),
                        ),
                      ],
                    ),
                  )
                : LayoutBuilder(
                    builder:
                        (BuildContext context2, BoxConstraints constraints) {
                          if (constraints.maxWidth > 1190) {
                            bool tabView = true;
                            return Row(
                              mainAxisAlignment: .center,
                              crossAxisAlignment: .start,
                              children: _buildChildren(
                                context,
                                displayTableNum,
                                cartItems,
                                screenWidth,
                                totalPrice,
                                tax,
                                tabView,
                              ),
                            );
                          } else {
                            bool tabView = false;
                            return Stack(
                              children: [
                                SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: .center,
                                    mainAxisAlignment: .start,
                                    children: _buildChildren(
                                      context,
                                      displayTableNum,
                                      cartItems,
                                      screenWidth,
                                      totalPrice,
                                      tax,
                                      tabView,
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  bottom: 0,
                                  // right: 0,
                                  // left: 0,
                                  child: Align(
                                    alignment: .bottomCenter,
                                    child: CheckoutButton(
                                      screenWidth: screenWidth,
                                      cartItems: cartItems,
                                      tableNum: displayTableNum,
                                      totalAmount: (totalPrice + tax),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                  );
          },
        ),
      ),
    );
  }

  List<Widget> _buildChildren(
    BuildContext context,
    String displayTableNum,
    List<CartItemsModel> cartItems,
    double screenWidth,
    double totalPrice,
    double tax,
    bool tabView,
  ) {
    return [
      SizedBox(height: (screenWidth * 0.04).clamp(12, 30)),
      //cart lists
      Align(
        alignment: AlignmentGeometry.topCenter,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 650,
            // maxHeight: 200
          ),
          child: ListView.separated(
            itemCount: cartItems.length,
            shrinkWrap: true,
            physics: tabView
                ? BouncingScrollPhysics()
                : NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 8);
            },
            itemBuilder: (BuildContext context, int index) {
              return CartItemCard(
                cartItem: cartItems[index],
                addCartItem: () {
                  context.read<CartItemsCubit>().addCartItem(
                    CartItemsModel(
                      item: cartItems[index].item,
                      image: cartItems[index].image,
                      diet: cartItems[index].diet,
                      quantity: cartItems[index].quantity,
                      price: cartItems[index].price,
                      variation: cartItems[index].variation,
                    ),
                  );
                },
                removeCartItem: () {
                  context.read<CartItemsCubit>().removeCartItem(
                    CartItemsModel(
                      item: cartItems[index].item,
                      image: cartItems[index].image,
                      diet: cartItems[index].diet,
                      quantity: cartItems[index].quantity,
                      price: cartItems[index].price,
                      variation: cartItems[index].variation,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      SizedBox(height: 30),
      SizedBox(width: 30),
      Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Price Details",
              style: TextStyle(
                // overflow: TextOverflow.ellipsis,
                fontSize: (screenWidth * 0.04).clamp(15, 20),
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                // height: 1.2,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: .center,
            children: [
              Card(
                color: Colors.white,
                elevation: 2,
                shadowColor: Colors.white,
                child: Container(
                  padding: .all((screenWidth * 0.02).clamp(14, 24)),
                  constraints: BoxConstraints(
                    maxWidth: 500,
                    // maxHeight: 200
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: .min,
                    mainAxisAlignment: .start,
                    children: [
                      //order amount
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Order Amount",
                              style: TextStyle(
                                // overflow: TextOverflow.ellipsis,
                                fontSize: (screenWidth * 0.04).clamp(15, 20),
                                fontWeight: FontWeight.w400,
                                color: AppColors.textPrimary,
                                // height: 1.2,
                              ),
                            ),
                          ),
                          Text(
                            "₹$totalPrice",
                            style: TextStyle(
                              // overflow: TextOverflow.ellipsis,
                              fontSize: (screenWidth * 0.04).clamp(16, 22),
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                              // height: 1.2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: (screenWidth * 0.007).clamp(10, 20)),
                      //tax
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Tax",
                              style: TextStyle(
                                // overflow: TextOverflow.ellipsis,
                                fontSize: (screenWidth * 0.04).clamp(15, 20),
                                fontWeight: FontWeight.w400,
                                color: AppColors.textPrimary,
                                // height: 1.2,
                              ),
                            ),
                          ),
                          Text(
                            "₹$tax",
                            style: TextStyle(
                              // overflow: TextOverflow.ellipsis,
                              fontSize: (screenWidth * 0.04).clamp(16, 22),
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                              // height: 1.2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: (screenWidth * 0.01).clamp(12, 22)),
                      Divider(
                        color: AppColors.primary,
                        radius: BorderRadius.circular(30),
                        thickness: 0.2,
                      ),
                      SizedBox(height: (screenWidth * 0.01).clamp(12, 22)),
                      //total amount
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Total Payment",
                              style: TextStyle(
                                // overflow: TextOverflow.ellipsis,
                                fontSize: (screenWidth * 0.04).clamp(16, 24),
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                                // height: 1.2,
                              ),
                            ),
                          ),
                          Text(
                            "₹${(totalPrice + tax)}",
                            style: TextStyle(
                              // overflow: TextOverflow.ellipsis,
                              fontSize: (screenWidth * 0.04).clamp(16, 24),
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                              // height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              if (tabView) ...[
                SizedBox(height: 70),
                CheckoutButton(
                  screenWidth: screenWidth,
                  cartItems: cartItems,
                  tableNum: displayTableNum,
                  totalAmount: (totalPrice + tax),
                ),
              ],
            ],
          ),
        ],
      ),

      SizedBox(height: 120),
    ];
  }
}

class CheckoutButton extends StatefulWidget {
  const CheckoutButton({
    super.key,
    required this.tableNum,
    required this.totalAmount,
    required this.cartItems,
    required this.screenWidth,
  });

  final String tableNum;
  final double screenWidth;
  final double totalAmount;
  final List<CartItemsModel> cartItems;

  @override
  State<CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  String selectedPaymentMethod = "Prepaid";
  Razorpay razorpay = Razorpay();

  @override
  void dispose() {
    razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  Future<void> confirmOrder(BuildContext context) async {
    final cartCubit = context.read<CartItemsCubit>();

    var res = await sl<ConfirmOrdersDetailsUsecase>()
        .call(
          param: OrderDetailsModel(
            userName: "dart",
            orderTotal: widget.totalAmount.toString(),
            tableNum: widget.tableNum,
            orderPaymentMethod: selectedPaymentMethod,
            orderItems: widget.cartItems,
          ),
        )
        .timeout(const Duration(seconds: 20));

      if (!mounted) return;

    res.fold(
      (l) {
        context.showSnackBar(
          message: l.toString(),
          backgroundColor: Colors.red,
        );
      },
      (r) {
        context.showSnackBar(
          message: r.toString(),
          backgroundColor: Colors.green,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AllOrdersScreen()),
        );

        cartCubit.clearCartItems();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (
      PaymentSuccessResponse response,
    ) {
      print("hhh ${response.data}");
      confirmOrder(context);
    });
    razorpay.on(
      Razorpay.EVENT_PAYMENT_ERROR,
      (PaymentFailureResponse response) => context.showSnackBar(
        message: response.message!.toString(),
        backgroundColor: Colors.red,
      ),
    );

    final double screenWidth = MediaQuery.widthOf(context);

    return Container(
      height: 80,
      constraints: BoxConstraints(maxWidth: 500),
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
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
              color: AppColors.textPrimary.withAlpha(50),
            ),
          ],
        ),
        child: Row(
          children: [
            //price
            Expanded(
              flex: 2,
              child: Center(
                // child: Text(
                //   "₹$totalAmount",
                //   style: TextStyle(
                //     fontSize: (screenWidth * 0.032).clamp(15, 20),
                //     fontWeight: .w600,
                //     color: AppColors.primary,
                //   ),
                // ),
                child: DropdownMenu<String>(
                  initialSelection: selectedPaymentMethod,
                  enableSearch: false,
                  textAlign: .center,

                  menuStyle: .new(
                    backgroundColor: .all(AppColors.bg),
                    elevation: .all(3),
                    maximumSize: .all(.fromWidth(500)),
                    alignment: .directional(-1, -5),
                  ),
                  textStyle: TextStyle(
                    fontSize: (screenWidth * 0.032).clamp(15, 20),
                    fontWeight: .w600,
                    color: AppColors.primary,
                  ),
                  decorationBuilder: (context, controller) {
                    return InputDecoration(
                      border: InputBorder.none,
                      contentPadding: .symmetric(horizontal: 24),
                      // disabledBorder: .none
                    );
                  },
                  onSelected: (String? value) {
                    setState(() {
                      selectedPaymentMethod = value!;
                    });
                  },
                  dropdownMenuEntries: [
                    _dropDownMenuEntry("COD", FontAwesomeIcons.moneyBillWave),
                    _dropDownMenuEntry("Prepaid", FontAwesomeIcons.creditCard),
                  ],
                ),
              ),
            ),
            // AddToCartButton
            Expanded(
              flex: 3,
              child: FilledButton(
                onPressed: () async {
                  if (selectedPaymentMethod == "COD") {
                    confirmOrder(context);
                  } else {
                    var options = {
                      'key': 'rzp_test_TSu36uUBt7CkyF',
                      'amount': widget.totalAmount * 100,
                      'name': 'serveX',
                      // 'description': 'Fine T-Shirt',
                      'prefill': {
                        'contact': '8888888888',
                        'email': 'dart@gmail.com',
                      },
                    };
                    razorpay.open(options);
                  }
                },

                child: Center(
                  child: Text(
                    selectedPaymentMethod == "COD"
                        ? "Confirm Order"
                        : "Checkout",
                    style: TextStyle(
                      fontSize: (screenWidth * 0.032).clamp(14, 18),
                      fontWeight: .w500,
                      color: AppColors.bg,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuEntry<String> _dropDownMenuEntry(String method, FaIconData icon) {
    return DropdownMenuEntry(
      value: method,
      label: method,
      leadingIcon: FaIcon(icon, size: 20),
      labelWidget: Text(
        method,
        style: TextStyle(
          fontSize: (widget.screenWidth * 0.032).clamp(15, 20),
          fontWeight: .w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
