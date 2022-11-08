import 'package:flutter/material.dart';

class AuthIconButtonWidget extends StatelessWidget {
  final String imagePath;
  final Color color;
  final double size;
  final VoidCallback? onPressAction;

  const AuthIconButtonWidget(
    this.imagePath, {
    super.key,
    required this.color,
    required this.size,
    this.onPressAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: IconButton(
        onPressed: onPressAction,
        icon: Center(child: Image.asset(imagePath)),
      ),
    );
  }
}
