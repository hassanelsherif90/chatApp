// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({super.key, required this.title, required this.onTap});

  final String title;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        height: 50,
        width: double.infinity,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }
}
