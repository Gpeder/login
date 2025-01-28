import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double width;
  const Botao(
      {super.key, this.onPressed, required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white
          ),
        ),
      ),
    );
  }
}
