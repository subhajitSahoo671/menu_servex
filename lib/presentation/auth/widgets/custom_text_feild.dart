import 'package:flutter/material.dart';

class CustomTextFeild extends StatefulWidget {
 final TextEditingController controller;
 final TextInputType keyboardType;
 final String label;
final  bool obscureText;
final IconData icon;
  const CustomTextFeild({super.key,required this.controller,required this.keyboardType ,required this.label,required this.obscureText,required this.icon});

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {

  bool obscure = true;
  @override
  Widget build(BuildContext context) {
     Color gold = Color(0xFFC58A2B);

    return TextField(
      
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText:  widget.obscureText ? obscure: widget.obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon,color: Color(0xFFC46A14),size: 22,),
        suffixIcon: widget.obscureText ? IconButton(onPressed: () {
          setState(() {
            obscure = !obscure;
          });
        }, icon: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,)):SizedBox.shrink(),
        fillColor: Color(0xffF5F3E4),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: gold),borderRadius: BorderRadius.circular(30)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: gold),borderRadius: BorderRadius.circular(30)),
        filled: true,
        contentPadding: EdgeInsets.all(20),
        label: Text(widget.label),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}

