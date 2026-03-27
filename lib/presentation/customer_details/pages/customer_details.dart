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
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppImages.customerDetailsBG),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _customerDetails(),
                  SizedBox(height: 30),
                  _continueButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customerDetails() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffF5F3E4),
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
        contentPadding: EdgeInsets.all(20),
        hint: Text("Name"),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget _numberField() {
    return TextField(
      controller: _phNumberController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hint: Text("Phone Number"),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget _tableNumber(){
    return TextField(
      controller: _tableNumberController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hint: Text("Table Number"),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget _continueButton(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
      },
      child: Container(
        // height: 50,
        // width: 80,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Text("Continue",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26),
          ),
        ),
      ),
    );
  }
}
