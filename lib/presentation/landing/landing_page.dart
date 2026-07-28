import 'package:flutter/material.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/presentation/home/pages/home_page.dart';
import 'package:menu_servex/presentation/scanner/scanner.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFC46A14);
    return Scaffold(
        body: Stack(
          children: [
            SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset( AppImages.landingImg,fit:.cover)),
                Positioned(
                    top: 60,
                    left: 40,
                    child: Image.asset(AppImages.logo,height: 100,width: 100,color: Color.fromARGB(255, 189, 129, 32),)),
                Positioned.fill(
                        left: 16,
                        child: Align(
                        alignment: .centerLeft,
                        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: .min,
        children: [
          const Text(
            "Delicious food, easy ordering\nand a delightful dining\nexperience at your table.",
            style: TextStyle(
              color: AppColors.bg,
              fontSize: 14,
            //   height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),

          Divider(color: Color.fromARGB(255, 189, 129, 32),endIndent: 180,radius: BorderRadius.circular(30),),

          const SizedBox(height: 20),

          _featureTile(
            icon: Icons.room_service_outlined,
            title: "EXPLORE MENU",
            subtitle: "Wide variety of cuisine",
          ),

          const SizedBox(height: 20),

          _featureTile(
            icon: Icons.shopping_cart_outlined,
            title: "EASY ORDERING",
            subtitle: "Add to cart and place order",
          ),

          const SizedBox(height: 20),

          _featureTile(
            icon: Icons.location_on_outlined,
            title: "TRACK & ENJOY",
            subtitle: "Track your order in real-time",
          ),
          SizedBox(height:60)
        ],
      ),
  
                    ))
         ,Positioned(
            left: 50,
            right: 50,
            bottom: 75,
            child:   Column(
                crossAxisAlignment: .center,
                mainAxisSize: .min,
      children: [
        // START ORDERING BUTTON
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton.icon(
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScannerScreen(),));
            },
            icon: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: Color(0xFFF4D8B8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.room_service_outlined,
                color: primaryColor,
                size: 22,
              ),
            ),
            label: const Text(
              "START ORDERING",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.bg,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: AppColors.bg,
              elevation: 6,
              shadowColor: Colors.black54,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // I'M A WAITER BUTTON
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
            },
           
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: primaryColor,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
             child:  Text(
              "View Menu",
              style: TextStyle(
                color: primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    ))
          ],
        ),
    );
  }

   Widget _featureTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    const Color gold = Color(0xFFC58A2B);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: gold,
              width: 1.5,
            ),
          ),
          child:  Center(
            child: Icon(
              icon,
              color: gold,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.bg,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            //   const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
