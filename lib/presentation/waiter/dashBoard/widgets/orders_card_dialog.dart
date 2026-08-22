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
import 'package:menu_servex/domain/usecases/waiter/orders/update_status.dart';
import 'package:menu_servex/service_locator.dart';
import 'package:svg_flutter/svg_flutter.dart';

class OrdersCardDialog extends StatelessWidget {
  const OrdersCardDialog({super.key, required this.orderDetails});

  final OrderDetailsEntity orderDetails;

  String _formatDate(DateTime time) {
    return DateFormat.yMMMEd().format(time);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.widthOf(context);

    var orderItems = orderDetails.orderItems;
    final totalItems = orderItems!.fold<int>(0, (total, item) {
      if (item is Map<String, dynamic>) {
        final quantity = item['quantity'];
        if (quantity is int) {
          return total + quantity;
        }
      }
      return total;
    });

    return Column(
      mainAxisSize: .min,
      children: [
        Card(
          borderOnForeground: true,
          color: Colors.grey.shade900,
          elevation: 3,
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
                  Padding(
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
                              orderDetails.tableNum.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.gold,
                                fontWeight: .w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${orderDetails.orderStatus}",
                          maxLines: 1,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: (screenWidth * 0.02).clamp(18, 22),
                            fontWeight: FontWeight.w500,
                            color: orderDetails.orderStatus == "Pending"
                                ? Colors.deepOrange
                                : orderDetails.orderStatus == "Accepted"
                                ? Colors.teal
                                : orderDetails.orderStatus == "Preparing"
                                ? Colors.orange
                                : orderDetails.orderStatus == "Ready"
                                ? Colors.green
                                : orderDetails.orderStatus == "Delivered"
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
                    radius: BorderRadius.circular(30),
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
                        var orderItemData = orderItems[index];
                        var itemsModel = OrderItemModel.fromJson(orderItemData);
                        OrderItemsEntity orderItem = itemsModel.toEntity();
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
                  Divider(
                    color: AppColors.bg.withAlpha(150),
                    height: 30,
                    radius: BorderRadius.circular(30),
                    thickness: 0.3,
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          if (orderDetails.orderStatus == "Ready") ...[
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
                          ],
                          Text(
                            _formatDate(orderDetails.orderTime!.toDate()),
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
                          if (orderDetails.orderStatus == "Pending") ...[
                            SizedBox(height: 4),
                            Text(
                              orderDetails.orderPaymentMethod.toString(),
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,

                                fontSize: (screenWidth * 0.02).clamp(15, 18),
                                fontWeight: FontWeight.w400,
                                color: AppColors.bg.withAlpha(150),
                                // height: 1.2,
                                // letterSpacing: 1
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        "₹${orderDetails.orderTotal}",
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: (screenWidth * 0.02).clamp(15, 18),
                          fontWeight: FontWeight.w500,
                          color: AppColors.bg,
                          // height: 1.2,
                          // letterSpacing: 1
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColors.bg.withAlpha(150),
                    height: 30,
                    radius: BorderRadius.circular(30),
                    thickness: 0.3,
                  ),

                  orderDetails.orderStatus == "Pending"
                      // accept or reject
                      ? Row(
                          crossAxisAlignment: .center,
                          // mainAxisSize: .min,
                          mainAxisAlignment: .end,
                          children: [
                            // reject button
                            OutlinedButton(
                              onPressed: () async {
                                final messenger = ScaffoldMessenger.of(context);
                                Navigator.pop(context);

                                var res = await sl<UpdateStatusUsecase>()
                                    .call(
                                      param: UpdateStatusModel(
                                        orderId: orderDetails.orderId!,
                                        userId: orderDetails.userId!,
                                        status: "Rejected",
                                      ),
                                    )
                                    .timeout(const Duration(seconds: 20));
                                res.fold(
                                  (l) => messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        l.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  ),
                                  (r) => messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        r.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 12,
                                ),
                                side: BorderSide(color: Colors.red, width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),

                              child: Text(
                                "Reject",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            // accept BUTTON
                            ElevatedButton(
                              onPressed: () async {
                                final messenger = ScaffoldMessenger.of(context);
                                Navigator.pop(context);

                                var res = await sl<UpdateStatusUsecase>()
                                    .call(
                                      param: UpdateStatusModel(
                                        orderId: orderDetails.orderId!,
                                        userId: orderDetails.userId!,
                                        status: "Accepted",
                                      ),
                                    )
                                    .timeout(const Duration(seconds: 20));
                                res.fold(
                                  (l) => messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        l.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  ),
                                  (r) => messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        r.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 12,
                                ),
                                backgroundColor: AppColors.primaryOrange,
                                foregroundColor: AppColors.bg,
                                elevation: 6,
                                shadowColor: Colors.black54,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Accept",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.bg,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: .start,
                          children: [
                            const SizedBox(width: 16),
                            Text(
                              "Note: ",
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,

                                fontSize: (screenWidth * 0.02).clamp(16, 18),
                                fontWeight: FontWeight.w400,
                                color: Colors.orange,
                                // height: 1.2,
                                // letterSpacing: 1
                              ),
                            ),
                            Text(
                              "Please serve hot",
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,

                                fontSize: (screenWidth * 0.02).clamp(16, 18),
                                fontWeight: FontWeight.w500,
                                color: AppColors.bg.withAlpha(150),
                                // height: 1.2,
                                // letterSpacing: 1
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
        if (orderDetails.orderStatus == "Ready") ...[
          SizedBox(height: 30),
          // served BUTTON
          SizedBox(
            // padding: EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                Navigator.pop(context);
            
                var res = await sl<UpdateStatusUsecase>()
                    .call(
                      param: UpdateStatusModel(
                        orderId: orderDetails.orderId!,
                        userId: orderDetails.userId!,
                        status: "Delivered",
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
                  (r) => messenger.showSnackBar(
                    SnackBar(
                      content: Text(
                        r.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12,
                ),
                backgroundColor: AppColors.primaryOrange,
                foregroundColor: AppColors.bg,
                elevation: 6,
                shadowColor: Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Mark as Served",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.bg,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          //bill button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                // final messenger = ScaffoldMessenger.of(context);
                // Navigator.pop(context);
            
                // var res = await sl<UpdateStatusUsecase>()
                //     .call(
                //       param: UpdateStatusModel(
                //         orderId: orderDetails.orderId!,
                //         userId: orderDetails.userId!,
                //         status: "Rejected",
                //       ),
                //     )
                //     .timeout(const Duration(seconds: 20));
                // res.fold(
                //   (l) => messenger.showSnackBar(
                //     SnackBar(
                //       content: Text(
                //         l.toString(),
                //         style: const TextStyle(color: Colors.white),
                //       ),
                //       backgroundColor: Colors.red,
                //       behavior: SnackBarBehavior.floating,
                //     ),
                //   ),
                //   (r) => messenger.showSnackBar(
                //     SnackBar(
                //       content: Text(
                //         r.toString(),
                //         style: const TextStyle(color: Colors.white),
                //       ),
                //       backgroundColor: Colors.green,
                //       behavior: SnackBarBehavior.floating,
                //     ),
                //   ),
                // );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12,
                ),
                side: BorderSide(color: AppColors.gold, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            
              child: Text(
                "Generate Bill",
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
