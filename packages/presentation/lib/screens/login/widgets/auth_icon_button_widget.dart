import 'package:flutter/material.dart';
import 'package:presentation/utils/dimensions.dart';

class AuthIconButtonWidget extends StatelessWidget {
  final String imagePath;
  final Color color;
  final VoidCallback? onPressAction;

  const AuthIconButtonWidget(
    this.imagePath, {
    super.key,
    required this.color,
    this.onPressAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.size44,
      height: AppSizes.size44,
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
