import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:menu_servex/common/custom_snackbar.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/data/model/orderDetails/order_details.dart';
import 'package:menu_servex/data/model/orderDetails/order_item.dart';
import 'package:menu_servex/data/model/updateStatus/update_status.dart';
import 'package:menu_servex/domain/entity/orders/order_details.dart';
import 'package:menu_servex/domain/entity/orders/order_items.dart';
import 'package:menu_servex/domain/usecases/cook/orders/update_status.dart';
import 'package:menu_servex/domain/usecases/waiter/orders/update_status.dart';
import 'package:menu_servex/service_locator.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CookOrdersCardDialog extends StatefulWidget {
  const CookOrdersCardDialog({
    super.key,
    required this.orderDetails,
    this.status,
  });

  final OrderDetailsEntity orderDetails;
  final String? status;

  @override
  State<CookOrdersCardDialog> createState() => _CookOrdersCardDialogState();
}

class _CookOrdersCardDialogState extends State<CookOrdersCardDialog> {

  Widget _showOrderDetailsDialog(BuildContext context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: .blur(sigmaX: 15, sigmaY: 15),
              child: Dialog(
                backgroundColor: Colors.transparent,
                alignment: Alignment.center,
                // clipBehavior:  Clip.antiAlias,
                constraints: BoxConstraints(maxWidth: 500),
                elevation: 10,
                insetPadding: EdgeInsets.only(
                  bottom: 60,
                  top: 20,
                  right: 16,
                  left: 16,
                ),

                child: CookOrdersCardDialog(
                  orderDetails: widget.orderDetails,
                  status: "Preparing",
                ),
              ),
            ),
            Positioned.fill(
              bottom: 10,
              child: Align(
                alignment: .bottomCenter,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: AppColors.gold,
                  iconSize: 28,
                ),
              ),
            ),
          ],
        );
      
  }

  String _formatDate(DateTime time) {
    return DateFormat.yMMMEd().format(time);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.widthOf(context);

    final orderItems = widget.orderDetails.orderItems ?? const [];
    final totalItems = orderItems.fold<int>(0, (total, item) {
      if (item is Map<String, dynamic>) {
        final quantity = item['quantity'];
        if (quantity is int) {
          return total + quantity;
        }
      }
      return total;
    });

    final String buttonLabel =
    widget.orderDetails.orderStatus == "Preparing" ||
              widget.status == "Preparing"
        ? "Mark as Ready"
     : widget.orderDetails.orderStatus == "Accepted"
        ? "Start Cooking"
        
        : "";

    return Hero(
      tag: widget.orderDetails.orderId ?? "",
      child: Column(
        mainAxisSize: .min,
        children: [
          //preparing widget
        if(widget.status == "Preparing" || widget.orderDetails.orderStatus == "Preparing") 
         Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border(top: BorderSide(color: AppColors.gold)),
              ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
                  child: Row(
                      children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                               color: Colors.transparent,
                                borderRadius: BorderRadius.circular(9999),
                                border: Border.all(color: AppColors.gold,width: 1.5)
                            ),
                           
                            child: Icon(Icons.soup_kitchen,color: AppColors.gold,size: 12,)),
                            SizedBox(width: 8,),
                           Text(
                                    "Preparing",
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: (screenWidth * 0.02).clamp(
                                        17,
                                        18,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.gold,
                                      // height: 1.2,
                                      // letterSpacing: 1
                                    ),
                                  ),
                      ]
                  ),
                ),
          Card(
            borderOnForeground: true,
            color: Colors.grey.shade900,
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.grey.shade800, width: 1.5),
            ),
            shadowColor: Colors.white,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 700,
                maxHeight: 900,
                // minHeight: widget.status == null ? 300 : 500
                // minHeight: 400
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(),
              ),
              width: MediaQuery.widthOf(context),
              // height: MediaQuery.widthOf(context)*0.40,
              padding: .all((screenWidth * 0.02).clamp(12, 20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                  widget.status == "Preparing" || widget.orderDetails.orderStatus == "Preparing" 
                  ?  Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.table_bar,
                                size: 26,
                                color: AppColors.bg,
                              ),
                              SizedBox(width: 4),
                              Text(
                              widget.orderDetails.tableNum.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.bg,
                                  fontWeight: .w500,
                                ),
                              ),
                              
                            ],
                          ),
                          Text(
                              _formatDate(widget.orderDetails.orderTime!.toDate()),
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
          
                                fontSize: (screenWidth * 0.02).clamp(14, 18),
                                fontWeight: FontWeight.w400,
                                color: AppColors.bg.withAlpha(150),
                                // height: 1.2,
                                // letterSpacing: 1
                              ),
                            ),
                        ],
                      )
                   : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.table_bar,
                                size: 26,
                                color: AppColors.gold,
                              ),
                              SizedBox(width: 4),
                              Text(
                                widget.orderDetails.tableNum.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.gold,
                                  fontWeight: .w500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${widget.status ?? widget.orderDetails.orderStatus}",
                            maxLines: 1,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: (screenWidth * 0.02).clamp(18, 22),
                              fontWeight: FontWeight.w500,
                              color:
                              widget.status == "Preparing" ?  Colors.orange 
                              : widget.orderDetails.orderStatus == "Pending"
                                  ? Colors.deepOrange
                                  : widget.orderDetails.orderStatus == "Accepted"
                                  ? Colors.teal
                                  : widget.orderDetails.orderStatus == "Preparing"
                                  ? Colors.orange
                                  : widget.orderDetails.orderStatus == "Ready"
                                  ? Colors.green
                                  : widget.orderDetails.orderStatus == "Delivered"
                                  ? Colors.grey
                                  : Colors.red,
                              // height: 1.2,
                              // letterSpacing: 1
                            ),
                          ),
                        ],
                      ),
                    ),
          
                    Divider(
                      color: AppColors.bg.withAlpha(150),
                      height: 20,
                      radius: BorderRadius.circular(20),
                      thickness: 0.3,
                    ),
                    SizedBox(height: 4),
                    //cart items list
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 200, minHeight: 50),
                      child: ListView.separated(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: orderItems!.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 10);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final orderItemData = orderItems[index];
                          final itemsModel = OrderItemModel.fromJson(orderItemData);
                          final OrderItemsEntity orderItem = itemsModel.toEntity();
          
                          return Row(
                            crossAxisAlignment: .start,
                            children: [
                              Container(
                                margin: .only(top: 4),
                                child: SvgPicture.asset(
                                  orderItem.diet == "veg"
                                      ? AppImages.vegIcon
                                      : AppImages.nonVegIcon,
                                  height: (screenWidth * 0.02).clamp(14, 18),
                                  width: (screenWidth * 0.04).clamp(14, 18),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: .start,
                                  mainAxisAlignment: .start,
                                  children: [
                                    Text(
                                      "${orderItem.quantity} x ${orderItem.item}",
                                      maxLines: 1,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: (screenWidth * 0.02).clamp(
                                          15,
                                          18,
                                        ),
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.bg,
                                        // height: 1.2,
                                        // letterSpacing: 1
                                      ),
                                    ),
                                    // SizedBox(height: 2,),
                                    Text(
                                      "${orderItem.variation}",
                                      maxLines: 1,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
          
                                        fontSize: (screenWidth * 0.02).clamp(
                                          14,
                                          18,
                                        ),
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.bg.withAlpha(150),
                                        // height: 1.2,
                                        // letterSpacing: 1
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  if( widget.status == null && widget.orderDetails.orderStatus == "Accepted")
                   ...[ Divider(
                      color: AppColors.bg.withAlpha(150),
                      height: 30,
                      radius: BorderRadius.circular(20),
                      thickness: 0.3,
                    ),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              "Total items: $totalItems",
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
          
                                fontSize: (screenWidth * 0.02).clamp(15, 18),
                                fontWeight: FontWeight.w600,
                                color: AppColors.bg.withAlpha(150),
                                // height: 1.2,
                                // letterSpacing: 1
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              _formatDate(widget.orderDetails.orderTime!.toDate()),
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
          
                                fontSize: (screenWidth * 0.02).clamp(14, 18),
                                fontWeight: FontWeight.w400,
                                color: AppColors.bg.withAlpha(150),
                                // height: 1.2,
                                // letterSpacing: 1
                              ),
                            ),
                            // SizedBox(height: 4),
                            // Text(
                            //   orderDetails.orderPaymentMethod.toString(),
                            //   maxLines: 1,
                            //   style: TextStyle(
                            //     overflow: TextOverflow.ellipsis,
          
                            //     fontSize: (screenWidth * 0.02).clamp(15, 18),
                            //     fontWeight: FontWeight.w400,
                            //     color: AppColors.bg.withAlpha(150),
                            //     // height: 1.2,
                            //     // letterSpacing: 1
                            //   ),
                            // ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final messenger = ScaffoldMessenger.of(context);
                             if(widget.status == "Preparing" ) Navigator.pop(context);
          
                            var res = await sl<UpdateCookStatusUsecase>()
                                .call(
                                  param: UpdateStatusModel(
                                    orderId: widget.orderDetails.orderId!,
                                    userId: widget.orderDetails.userId!,
                                    status: widget.status == "Preparing" 
                                    ? "Ready"
                                    : widget.orderDetails.orderStatus == "Accepted" 
                                    ? "Preparing"
                                    : widget.orderDetails.orderStatus == "Preparing" 
                                    ? "Ready"
                                    : " "
                                  ),
                                )
                                .timeout(const Duration(seconds: 20));
          
                            res.fold(
                              (l) => messenger.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    l.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              ),
                              (r) {
                                if (widget.orderDetails.orderStatus ==
                                        "Preparing" ||
                                    widget.status == "Preparing") {
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        r.toString(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                } else {
                                   Navigator.pushReplacement(context, DialogRoute(context: context, builder: (context) {
                                     return _showOrderDetailsDialog(context);
                                   },));
                                  // _showOrderDetailsDialog(context);
                                }
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                              vertical: 12,
                            ),
                            backgroundColor:  widget.status == "Preparing"
                                ? Colors.green
                                : widget.orderDetails.orderStatus == "Accepted"
                                ? AppColors.primaryOrange
                                : widget.orderDetails.orderStatus == "Preparing" 
                                ? Colors.green
                                : Colors.grey,
                            foregroundColor: AppColors.bg,
                            elevation: 6,
                            shadowColor: Colors.black54,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            buttonLabel,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.bg,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),]
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 30,),
          // ready botton
           if( widget.status == "Preparing" || widget.orderDetails.orderStatus == "Preparing")
           Card(
               borderOnForeground: true,
                       color: Colors.grey.shade900,
                       elevation: 1,
                       clipBehavior: Clip.antiAlias,
                       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(20),
           side: BorderSide(color: Colors.grey.shade800, width: 1.5),
                       ),
                       shadowColor: Colors.white,  
             child: Row(
               children: [
                 //price
                 Expanded(
                   // flex: 4,
                   child: Center(
                     child:  Text(
                              "Total items: $totalItems",
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
          
                                fontSize: (screenWidth * 0.02).clamp(16, 18),
                                fontWeight: FontWeight.w600,
                                color: AppColors.bg.withAlpha(150),
                                // height: 1.2,
                                // letterSpacing: 1
                              ),
                            ),
                   ),
                 ),
                 // AddToCartButton
                 Padding(
                   padding: const EdgeInsets.all(8),
                   child: ElevatedButton(
                       onPressed: () async {
                         final messenger = ScaffoldMessenger.of(context);
                          if(widget.status == "Preparing" ) Navigator.pop(context);
                             
                         var res = await sl<UpdateCookStatusUsecase>()
                             .call(
                               param: UpdateStatusModel(
                                 orderId: widget.orderDetails.orderId!,
                                 userId: widget.orderDetails.userId!,
                                 status: widget.status == "Preparing" 
                                 ? "Ready"
                                 : widget.orderDetails.orderStatus == "Accepted" 
                                 ? "Preparing"
                                 : widget.orderDetails.orderStatus == "Preparing" 
                                 ? "Ready"
                                 : " "
                               ),
                             )
                             .timeout(const Duration(seconds: 20));
                             
                         res.fold(
                           (l) => messenger.showSnackBar(
                             SnackBar(
                               content: Text(
                                 l.toString(),
                                 style: const TextStyle(color: Colors.white),
                               ),
                               backgroundColor: Colors.red,
                               behavior: SnackBarBehavior.floating,
                             ),
                           ),
                           (r) {
                             if (widget.orderDetails.orderStatus ==
                                     "Preparing" ||
                                 widget.status == "Preparing") {
                               messenger.showSnackBar(
                                 SnackBar(
                                   content: Text(
                                     r.toString(),
                                     style: const TextStyle(color: Colors.white),
                                   ),
                                   backgroundColor: Colors.green,
                                   behavior: SnackBarBehavior.floating,
                                 ),
                               );
                             } else {
                                Navigator.pushReplacement(context, DialogRoute(context: context, builder: (context) {
                                  return _showOrderDetailsDialog(context);
                                },));
                               // _showOrderDetailsDialog(context);
                             }
                           },
                         );
                       },
                       style: ElevatedButton.styleFrom(
                         padding: const EdgeInsets.symmetric(
                           horizontal: 16.0,
                           vertical: 12,
                         ),
                         backgroundColor:  widget.status == "Preparing"
                             ? Colors.green
                             : widget.orderDetails.orderStatus == "Accepted"
                             ? AppColors.primaryOrange
                             : widget.orderDetails.orderStatus == "Preparing" 
                             ? Colors.green
                             : Colors.grey,
                         foregroundColor: AppColors.bg,
                         elevation: 6,
                         shadowColor: Colors.black54,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(20),
                         ),
                       ),
                       child: Text(
                         buttonLabel,
                         style: TextStyle(
                           fontSize: 16,
                           color: AppColors.bg,
                           fontWeight: FontWeight.w600,
                           letterSpacing: 0.2,
                         ),
                       ),
                     ),
                 ),
               ],
             ),
           ),
        
        ],
      ),
    );
  }
}
