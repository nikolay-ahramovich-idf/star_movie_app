import 'package:flutter/material.dart';
import 'package:presentation/const.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoaderWidget extends StatelessWidget {
  const ShimmerLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ShimmerLoaderWidgetColors.baseColor,
      highlightColor: ShimmerLoaderWidgetColors.hightlightColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
