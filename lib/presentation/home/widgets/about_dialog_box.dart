import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';

class AboutDialogBox extends StatelessWidget {
  const AboutDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.bounceInOut,
      insetAnimationDuration: Duration(milliseconds: 300),
      surfaceTintColor: AppColors.textPrimary,
      shadowColor: AppColors.textPrimary,
      elevation: 20,
      // backgroundColor: AppColors.bg,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: 600, maxWidth: 1200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primary,
        ),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: CloseButton(color: AppColors.bg),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: DefaultTextStyle.merge(
                style: TextStyle(color: AppColors.bg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: FaIcon(FontAwesomeIcons.clock, color: AppColors.bg,size: 17,),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: [
                            Text("Opening hours Daily"),
                            Text("11AM - 11PM"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
