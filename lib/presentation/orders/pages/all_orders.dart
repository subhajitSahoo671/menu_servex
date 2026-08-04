import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_servex/core/configs/constants.dart';
import 'package:menu_servex/data/model/orderDetails/order_details.dart';
import 'package:menu_servex/domain/entity/orders/order_details.dart';
import 'package:menu_servex/domain/usecases/orders/get_user_orders.dart';
import 'package:menu_servex/presentation/auth/widgets/custom_snackbar.dart';
import 'package:menu_servex/presentation/orders/widgets/user_orders_card.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  Stream<QuerySnapshot>? streamData;

  @override
  void initState() {
    super.initState();
    _getUserOrders();
  }

  Future<void> _getUserOrders() async {
    var res = await GetUserOrdersUsecase().call();

    if (!mounted) return;

    res.fold(
      (l) {
        context.showSnackBar(message: l, backgroundColor: Colors.red);
      },
      (r) {
        if (mounted) {
          setState(() {
            streamData = r;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.widthOf(context);
    // final String displayTableNum = TableNum.tableNum;

    
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
        title: Text("My Orders"),
       
      ),
      body: Padding(padding: EdgeInsets.only(
          right: (screenWidth * 0.04).clamp(12, 90),
          left: (screenWidth * 0.04).clamp(12, 90),
          // top: (screenWidth * 0.04).clamp(12, 30),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: streamData,
          builder: (context, snapshot) {
            if (streamData == null || snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Center(child: Text('Unable to load orders')));
            }

            //user is logged in
            if (snapshot.hasData) {
        var allOrders = snapshot.data!.docs;
        return SingleChildScrollView(
          child: Column(
            children: [
                SizedBox(height: (screenWidth * 0.02).clamp(8, 16)),
              Container(
                  constraints: BoxConstraints(
              maxWidth: 650,
              // maxHeight: 200
            ),
                child: ListView.separated(
                  itemCount: allOrders.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 8,);
                  },
                  itemBuilder: (BuildContext context, int index) {
                     var orderData =  allOrders[index].data() as Map<String, dynamic>;
                      var orderDetailsModel = OrderDetailsModel.fromJson(orderData);
                       OrderDetailsEntity orderDeatails = orderDetailsModel.toEntity();
                     print("orderDeatails $orderDeatails");
                    return UserOrdersCard(orderDetails:orderDeatails);
                  },
                ),
              ),
            ],
          ),
        );
            }

            //user is not logged in
            return const Center(child: Text('No orders found'));
          },
        ),
        ),
    );
  }
}