import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/data/model/orderDetails/order_details.dart';
import 'package:menu_servex/data/model/orderDetails/order_item.dart';
import 'package:menu_servex/domain/entity/orders/order_details.dart';
import 'package:menu_servex/domain/entity/orders/order_items.dart';
import 'package:svg_flutter/svg_flutter.dart';

class UserOrdersCard extends StatelessWidget {
  const UserOrdersCard({super.key, required this.orderDetails});

  final OrderDetailsEntity orderDetails;

  String _formatDate(DateTime time) {
    return DateFormat.yMMMEd().format(time);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.widthOf(context);

    var orderItems = orderDetails.orderItems;

    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.white,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 650,
          // maxHeight: 400
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        width: MediaQuery.widthOf(context),
        // height: MediaQuery.widthOf(context)*0.40,
        padding: .all((screenWidth * 0.02).clamp(12, 20)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.table_bar, size: 26, color: AppColors.primary),
                SizedBox(width: 4),
                Text(
                  orderDetails.tableNum.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                    fontWeight: .w500,
                  ),
                ),
              ],
            ),
            Divider(
              color: AppColors.primary,
              height: 20,
              radius: BorderRadius.circular(30),
              thickness: 0.3,
            ),
            SizedBox(height: 4),
            //cart items list
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
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
                              fontSize: (screenWidth * 0.02).clamp(15, 18),
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondary,
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

                              fontSize: (screenWidth * 0.02).clamp(14, 18),
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary,
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
            Divider(
              color: AppColors.primary,
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
                    Text(
                      _formatDate(orderDetails.orderTime!.toDate()),
                      maxLines: 1,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,

                        fontSize: (screenWidth * 0.02).clamp(14, 18),
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                        // height: 1.2,
                        // letterSpacing: 1
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      orderDetails.orderPaymentMethod.toString(),
                      maxLines: 1,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,

                        fontSize: (screenWidth * 0.02).clamp(15, 18),
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                        // height: 1.2,
                        // letterSpacing: 1
                      ),
                    ),
                  ],
                ),
                Text(
                  "₹${orderDetails.orderTotal}",
                  maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: (screenWidth * 0.02).clamp(15, 18),
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                    // height: 1.2,
                    // letterSpacing: 1
                  ),
                ),
              ],
            ),
            Divider(
              color: AppColors.primary,
              height: 30,
              radius: BorderRadius.circular(30),
              thickness: 0.3,
            ),
            Row(
              mainAxisAlignment: .end,
              children: [
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
          ],
        ),
      ),
    );
  }
}
