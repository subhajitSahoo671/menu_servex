import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/data/model/orderDetails/order_details.dart';
import 'package:menu_servex/domain/entity/orders/order_details.dart';
import 'package:menu_servex/domain/usecases/waiter/orders/get_orders.dart';
import 'package:menu_servex/common/custom_snackbar.dart';
import 'package:menu_servex/presentation/auth/pages/sign_in.dart';
import 'package:menu_servex/presentation/waiter/dashBoard/widgets/orders_card.dart';

class WaiterDashboard extends StatefulWidget {
  const WaiterDashboard({super.key});

  @override
  State<WaiterDashboard> createState() => _WaiterDashboardState();
}

class _WaiterDashboardState extends State<WaiterDashboard> {

  Stream<QuerySnapshot>? streamData;

  @override
  void initState() {
    super.initState();
    _getOrders();
  }

  Future<void> _getOrders() async {
    var res = await GetOrdersUsecase().call();

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

     Future<void> signedOut() async{
   try {
    await FirebaseAuth.instance.signOut(); 
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignIn(),));
    print("User successfully signed out");
  } catch (e) {
    print("Error signing out: $e");
  }
  }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text("Waiter DashBoard",style: TextStyle(fontSize: 24,fontWeight: .w600,color: AppColors.bg),),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () { signedOut(); },)
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: streamData,
        builder: (context, snapshot) {
          
           if (streamData == null || snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Center(child: Text('Unable to load orders')));
            }
    if (snapshot.hasData) {
      
    List<OrderDetailsEntity> newOrders = [];
    List<OrderDetailsEntity> preparingOrders = [];
    List<OrderDetailsEntity> readyOrders = [];

        var allOrders = snapshot.data!.docs;

        for (var order in allOrders) {
          var orderData = order.data() as Map<String, dynamic>;
          var orderDetailsModel = OrderDetailsModel.fromJson(orderData);
          OrderDetailsEntity orderDeatails = orderDetailsModel.toEntity();
          if (orderDeatails.orderStatus == "Pending") {
            newOrders.add(orderDeatails);
          }else if(orderDeatails.orderStatus == "Preparing" || orderDeatails.orderStatus == "Accepted"){
            preparingOrders.add(orderDeatails);
            
          }
          else if(orderDeatails.orderStatus == "Ready"){
            readyOrders.add(orderDeatails);

          }
        }
        
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DefaultTabController(
              length: 3,
              child: Column(
                // crossAxisAlignment: .start,
                children: [
                  // Text("Hii, Pinku 👋",style: TextStyle(fontSize: 16,fontWeight: .w400,color: AppColors.bg)),
                  TabBar(
                    dividerColor: AppColors.gold.withAlpha(40),
                    indicatorColor: AppColors.gold,
                    indicatorSize: .label,
                    labelColor: AppColors.gold,
                    overlayColor: .all(Colors.transparent),
                    isScrollable: true,
                    tabAlignment: .center,
                    unselectedLabelColor: AppColors.bg.withAlpha(150),
                      tabs: [
                        Tab(child: Text("New (${newOrders.length})",style: TextStyle(fontSize: 17,fontWeight: .w500)),),
                        Tab(child: Text("Preparing (${preparingOrders.length})",style: TextStyle(fontSize: 17,fontWeight: .w500)),),
                        Tab(child: Text("Ready (${readyOrders.length})",style: TextStyle(fontSize: 17,fontWeight: .w500)),),
                      ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildCards(newOrders),
                        _buildCards(preparingOrders),
                        _buildCards(readyOrders)
                      ],
                    ),
                  ),
                ],
                
              ),
            ),
          );
          }
               return const Center(child: Text('No orders found'));
        }
      ),
    );
  }

  Widget _buildCards(List<OrderDetailsEntity> orders){
    return ListView.builder(
      itemCount: orders.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
                     print("orderDeatails $orders");
        return OrdersCard(orderDetails: orders[index]);
      },
    );
  }
}