import 'package:flutter/material.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/domain/entity/orders/order_details.dart';
import 'package:menu_servex/presentation/cook/dashBoard/widgets/orders_card_dialog.dart';
import 'package:menu_servex/presentation/orders/widgets/user_orders_card.dart';
import 'package:menu_servex/presentation/waiter/dashBoard/widgets/orders_card_dialog.dart';

class CookOrdersCard extends StatelessWidget {
  const CookOrdersCard({super.key, required this.orderDetails});

  final OrderDetailsEntity orderDetails;

  void _showOrderDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
     barrierColor: Colors.transparent,
    //  fullscreenDialog: false,
      barrierDismissible: true, 
      builder: (BuildContext context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: .blur(sigmaX: 15,sigmaY: 15),
              child: Dialog(
                backgroundColor: Colors.transparent,
                alignment: Alignment.center,
                // clipBehavior:  Clip.antiAlias,
                constraints: BoxConstraints(maxWidth: 500),
                elevation: 10,
                insetPadding: EdgeInsets.only(bottom: 60,top: 20,right: 16,left: 16),
              
                child: CookOrdersCardDialog(orderDetails: orderDetails,),
                // actions: [
                //   TextButton(
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
                //     child: Text('Close'),
                //   ),
                // ],
              ),
            ),
            Positioned.fill(  
              bottom: 10,
              child: Align(
                alignment: .bottomCenter,
                child: IconButton(icon: Icon(Icons.close,),onPressed: () {
                  Navigator.pop(context);
                },color: AppColors.gold,iconSize: 28,)
                )
                )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 700),
        child: InkWell(
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          overlayColor: .all(Colors.transparent),
          splashColor: Colors.transparent,
          onTap: () {
            if (orderDetails.orderStatus == "Preparing") {
              _showOrderDetailsDialog(context);
            }
          },
          child: Card(
            margin: EdgeInsets.only(top: 16),
            borderOnForeground: true,
             color: Colors.grey.shade900,
             elevation: 3,
              clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(20),
             side: BorderSide( color: Colors.grey.shade800,
              width: 1.5)
            ), 
            child: Container(
              padding: .all(16),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text("Table ${orderDetails.tableNum}",style: TextStyle(fontSize: 18,fontWeight: .w600,color: AppColors.bg),),
                      SizedBox(height: 2,),
                      Text("${orderDetails.orderItems!.length} orders",style: TextStyle(fontSize: 16,fontWeight: .w400,color: AppColors.bg),),
                    ],
                  ),
          
                  orderDetails.orderStatus != "Accepted" 
                 ? Center(child: Text("${orderDetails.orderStatus}",style: TextStyle(color:  orderDetails.orderStatus == "Pending"
                          ? Colors.deepOrange
                          : orderDetails.orderStatus == "Accepted"
                          ? Colors.teal
                          : orderDetails.orderStatus == "Preparing"
                          ? Colors.orange
                          : orderDetails.orderStatus == "Ready"
                          ? Colors.green
                          : orderDetails.orderStatus == "Delivered"
                          ? Colors.grey
                          : Colors.red,)))
          
                   //view buton
                : OutlinedButton(
                  
                  onPressed: () {
                    _showOrderDetailsDialog(context);
                  },
                 
                  
                  style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    side: BorderSide(
                      color: AppColors.gold,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  
                   child:  Text(
                    "View",
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      // letterSpacing: 0.5,
                    ),
                  ),
                ) 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}