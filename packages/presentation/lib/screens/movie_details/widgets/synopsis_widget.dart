import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/styles.dart';
import 'package:readmore/readmore.dart';

class SynopsisWidget extends StatelessWidget {
  final String? overview;
  final void Function(bool) handleShowMoreLessPressed;

  const SynopsisWidget(
    this.overview, {
    required this.handleShowMoreLessPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.synopsisHeaderLabel,
          style: MovieDetailsScreenStyles.movieDescriptionHeaderStyle,
        ),
        const SizedBox(height: AppSizes.size14),
        ReadMoreText(
          overview ?? '',
          style: MovieDetailsScreenStyles.movieDescriptionBodyStyle,
          trimLines: 4,
          trimMode: TrimMode.Line,
          trimCollapsedText: appLocalizations.showMoreButtonLabel,
          trimExpandedText: ' ${appLocalizations.showLessButtonLabel}',
          moreStyle: MovieDetailsScreenStyles.showMoreStyle,
          lessStyle: MovieDetailsScreenStyles.showMoreStyle,
          callback: handleShowMoreLessPressed,
        )
      ],
    );
  }
}
