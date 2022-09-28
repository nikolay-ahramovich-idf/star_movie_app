import 'package:flutter/material.dart';
import 'package:presentation/const.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/styles.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  static const gridItemsCount = 4;

  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: ShimmerLoaderWidgetColors.baseColor,
          highlightColor: ShimmerLoaderWidgetColors.hightlightColor,
          child: Container(
            decoration: BoxDecoration(
              color: ShimmerLoaderWidgetColors.fillColor,
              borderRadius: BorderRadius.circular(
                HomeScreenSizes.selectionBorderRadiusSize,
              ),
            ),
            width: double.infinity,
            height: AppSizes.size50,
          ),
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Expanded(
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
                  Container(
                    color: ShimmerLoaderWidgetColors.fillColor,
                    height: HomeScreenSizes.ratingStarSize,
                    width: double.infinity,
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
                      height: MovieCardWidgetStyles
                          .movieAdditionalInfoTextStyle.fontSize,
                      width: double.infinity,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
