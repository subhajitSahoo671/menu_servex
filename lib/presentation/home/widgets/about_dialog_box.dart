import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';

class AboutDialogBox extends StatelessWidget {
  const AboutDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "dialog",
      child: Dialog(
         insetAnimationCurve: Curves.bounceInOut,
        insetAnimationDuration: Duration(milliseconds: 300),
        surfaceTintColor: AppColors.textPrimary,
        shadowColor: AppColors.bg,
        elevation: 20,insetPadding: .symmetric(horizontal: 16),
        backgroundColor: AppColors.bg,
        child: Container(
           height: double.infinity,
          width: double.infinity,
          constraints: BoxConstraints(maxHeight: 500, maxWidth: 1200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.bg,
          ),
          child: Stack(
            children: [
               Align(
                alignment: AlignmentGeometry.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: CloseButton(color: AppColors.primary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
             child: DefaultTextStyle(
              style: TextStyle(color: AppColors.primary),
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: FaIcon(FontAwesomeIcons.clock, color: AppColors.primary,size: 17,),
                                ),
                            SizedBox(width: 12,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Opening hours Daily",style: TextStyle(fontSize: 16,fontWeight: .w400),),
                                  Text("11AM - 11PM"),
                                ],
                              ),
                            ),
                              ],
                            ),
                          ),
                          _buildList(FontAwesomeIcons.locationDot,"Unit-5, S.B. Road, rekha Mills, Near junior park, Parel, Mumbai, 400013"),
                          _buildList(FontAwesomeIcons.phone,"00 100 2000"),
                          _buildList(FontAwesomeIcons.globe,"serveX.com"),
                          _buildList(FontAwesomeIcons.instagram,"@serveX"),
                          _buildList(FontAwesomeIcons.facebook,"facebook.com/serveX"),
                          _buildList(FontAwesomeIcons.whatsapp,"900 200 0200"),
                          _buildList(FontAwesomeIcons.twitter,"x.com/serveX"),                       
                ],
               ),
             ),
              )
            ],
          ),
        ),
        
      ),
    );
  }

  Widget _buildList(FaIconData icon,String title){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FaIcon(icon, color: AppColors.primary,size: 17,),
                            SizedBox(width: 12,),
                            Expanded(
                              child: Text(title,style: TextStyle(fontSize: 16,fontWeight: .w400),),
                            ),
                              ],
                            ),
    );
  }
}