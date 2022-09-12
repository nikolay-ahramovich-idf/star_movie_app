import 'package:flutter/material.dart';
import 'package:presentation/const.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  static const gridItemsCount = 4;

  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: gridItemsCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: HomeScreenSizes.gridChildAspecRatio,
          crossAxisSpacing: AppSizes.size13,
          mainAxisSpacing: HomeScreenSizes.gridViewMainAxisSpacing,
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
              AspectRatio(
                aspectRatio: 2 / 3,
                child: Shimmer.fromColors(
                  baseColor: ShimmerLoaderWidgetColors.baseColor,
                  highlightColor: ShimmerLoaderWidgetColors.hightlightColor,
                  child: Container(
                    color: ShimmerLoaderWidgetColors.fillColor,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(
                height: AppSizes.size10,
              ),
              Shimmer.fromColors(
                baseColor: ShimmerLoaderWidgetColors.baseColor,
                highlightColor: ShimmerLoaderWidgetColors.hightlightColor,
                child: Container(
                  color: ShimmerLoaderWidgetColors.fillColor,
                  height: RatingWidgetConfig.starSize,
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                height: AppSizes.size10,
              ),
              Shimmer.fromColors(
                baseColor: ShimmerLoaderWidgetColors.baseColor,
                highlightColor: ShimmerLoaderWidgetColors.hightlightColor,
                child: Container(
                  color: ShimmerLoaderWidgetColors.fillColor,
                  height: MovieCardWidgetStyles.movieNameTextStyle.fontSize,
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                height: AppSizes.size10,
              ),
              Shimmer.fromColors(
                baseColor: ShimmerLoaderWidgetColors.baseColor,
                highlightColor: ShimmerLoaderWidgetColors.hightlightColor,
                child: Container(
                  color: ShimmerLoaderWidgetColors.fillColor,
                  height:
                      MovieCardWidgetStyles.movieAdditionalInfoTextStyle.fontSize,
                  width: double.infinity,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
