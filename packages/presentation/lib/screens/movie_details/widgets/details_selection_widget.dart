import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/styles.dart';

class DetailsSelectionWidget extends StatelessWidget {
  const DetailsSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      height: AppSizes.size45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          HomeScreenSizes.selectionBorderRadiusSize,
        ),
        border: Border.all(
          width: HomeScreenSizes.selectionBorderWidth,
          color: HomeScreenColors.selectionBorderColor,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.size4,
                AppSizes.size4,
                AppSizes.size0,
                AppSizes.size4,
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: HomeScreenColors.selectionActiveColor,
                  borderRadius: BorderRadius.circular(
                    HomeScreenSizes.selectionBorderRadiusSize,
                  ),
                ),
                child: Text(
                  appLocalizations.detailCategoryLabel,
                  style: SelectionButtonStyles.activeButtonTextStyle,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(
                AppSizes.size4,
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    HomeScreenSizes.selectionBorderRadiusSize,
                  ),
                ),
                child: Text(
                  appLocalizations.reviewsCategoryLabel,
                  style: SelectionButtonStyles.inactiveButtonTextStyle,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                AppSizes.size4,
                AppSizes.size4,
                AppSizes.size4,
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    HomeScreenSizes.selectionBorderRadiusSize,
                  ),
                ),
                child: Text(
                  appLocalizations.showtimeCategoryLabel,
                  style: SelectionButtonStyles.inactiveButtonTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
