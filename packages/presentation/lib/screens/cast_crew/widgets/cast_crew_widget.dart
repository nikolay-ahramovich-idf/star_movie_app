import 'package:domain/entities/movie_character_entity.dart';
import 'package:flutter/material.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/responsive.dart';
import 'package:presentation/utils/styles.dart';

class CastCrewWidget extends StatelessWidget {
  final List<MovieCharacterEntity> castAndCrew;

  const CastCrewWidget(this.castAndCrew, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: castAndCrew.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.rowsCountPerWidgetSize(context),
        crossAxisSpacing: AppSizes.size13,
        mainAxisExtent: AppSizes.size70,
      ),
      itemBuilder: (context, index) {
        final castAndCrewItem = castAndCrew[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  width: AppSizes.size50,
                  child: CircleAvatar(
                    backgroundImage: castAndCrewItem.posterPath != null
                        ? NetworkImage(castAndCrewItem.posterPath!)
                        : null,
                    radius: AppSizes.size49 / 2,
                  ),
                ),
                const SizedBox(width: AppSizes.size12),
                SizedBox(
                  width: AppSizes.size100,
                  child: Text(
                    castAndCrewItem.personName,
                    style: CastCrewWidgetStyles.movieDescriptionCastNameStyle,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: AppSizes.size20,
                  child: _getThreeDotsWidget(),
                ),
                const SizedBox(width: AppSizes.size24),
                SizedBox(
                  width: AppSizes.size100,
                  child: Text(
                    castAndCrewItem.roleName.toUpperCase(),
                    style: CastCrewWidgetStyles.movieDescriptionRoleNameStyle,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _getThreeDotsWidget() {
    const dotsNumber = 3;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int j = 0; j < dotsNumber; j++)
          Padding(
            padding: const EdgeInsets.only(
              right: AppSizes.size2,
            ),
            child: Container(
              width: AppSizes.size4,
              height: AppSizes.size4,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.transparentWhite50,
              ),
            ),
          )
      ],
    );
  }
}
