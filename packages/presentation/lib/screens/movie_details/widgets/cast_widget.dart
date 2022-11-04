import 'package:domain/entities/movie_character_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/styles.dart';

class CastWidget extends StatelessWidget {
  final List<MovieCharacterEntity>? cast;

  const CastWidget(
    this.cast, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appLocalizations.castAndCrewHeaderLabel,
              style: MovieDetailsScreenStyles.movieDescriptionHeaderStyle,
            ),
            Text(
              appLocalizations.viewAllButtonLabel,
              style: MovieDetailsScreenStyles.showMoreStyle,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.size24),
        Table(
          // defaultColumnWidth: const IntrinsicColumnWidth(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FixedColumnWidth(AppSizes.size49),
            1: FixedColumnWidth(AppSizes.size12),
            2: FlexColumnWidth(),
            3: FixedColumnWidth(AppSizes.size20),
            4: FixedColumnWidth(AppSizes.size24),
          },
          children: [
            for (final castItem in cast ?? [])
              TableRow(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: castItem.posterPath != null
                            ? NetworkImage(
                                castItem.posterPath!,
                              )
                            : null,
                        radius: AppSizes.size49 / 2,
                      ),
                      const SizedBox(height: AppSizes.size18),
                    ],
                  ),
                  const SizedBox(width: AppSizes.size12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        castItem.actorName,
                        style: MovieDetailsScreenStyles
                            .movieDescriptionCastNameStyle,
                      ),
                      const SizedBox(
                        height: AppSizes.size18,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      _getThreeDotsWidget(),
                      const SizedBox(height: AppSizes.size18)
                    ],
                  ),
                  const SizedBox(width: AppSizes.size24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        castItem.characterName.toUpperCase(),
                        style: MovieDetailsScreenStyles
                            .movieDescriptionRoleNameStyle,
                      ),
                      const SizedBox(height: AppSizes.size18),
                    ],
                  ),
                ],
              ),
          ],
        )
      ],
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
