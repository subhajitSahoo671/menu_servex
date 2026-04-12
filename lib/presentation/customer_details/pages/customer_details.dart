import 'package:flutter/material.dart';
import 'package:menu_servex/core/configs/assets/app_images.dart';
import 'package:menu_servex/core/configs/theme/app_colors.dart';
import 'package:menu_servex/presentation/home/pages/home_page.dart';

class Customerdetails extends StatelessWidget {
  Customerdetails({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phNumberController = TextEditingController();
  final TextEditingController _tableNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
       color: Color(0xffF5F3E4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20,),
                Hero(
                  tag: 1,
                  child: Image(image: AssetImage(AppImages.logo,),
                  height: 180,
                  width: 180,
                  fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 60),
                _customerDetails(),
                SizedBox(height: 60),
                _continueButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customerDetails() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: 500
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppImages.customerDetailsBG),
          ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Color(0xff7A5741),
            blurRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_nameField(), SizedBox(height: 10), _numberField(), SizedBox(height: 10,),_tableNumber()],
        ),
      ),
    );
  }

  Widget _nameField() {
    return TextField(
      controller: _nameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        fillColor: Color(0xffF5F3E4),
        filled: true,
        contentPadding: EdgeInsets.all(20),
        label: Text("Name"),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget _numberField() {
    return TextField(
      controller: _phNumberController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        fillColor: Color(0xffF5F3E4),
        filled: true,
        contentPadding: EdgeInsets.all(20),
        label: Text("Phone Number"),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget _tableNumber(){
    return TextField(
      controller: _tableNumberController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        fillColor: Color(0xffF5F3E4),
        filled: true,
        contentPadding: EdgeInsets.all(20),
        label: Text("Table Number"),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget _continueButton(context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
      },
      child: Container(
        // height: 50,
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: 500
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
          child: Text("OPEN MENU",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffF5F3E4), fontSize: 20),
          ),
        ),
      ),
    );
  }
}
