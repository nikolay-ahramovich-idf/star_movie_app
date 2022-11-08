import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/screens/home/home_bloc.dart';
import 'package:presentation/screens/home/widgets/home_screen_body_widget.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/styles.dart';

class MobileHomeWidget extends StatelessWidget {
  final HomeBloc bloc;
  final Widget? drawerWidget;

  const MobileHomeWidget({
    required this.bloc,
    this.drawerWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      drawer: drawerWidget,
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: AppSizes.size6),
          child: Text(
            appLocalizations.appNameLabel,
            style: AppStyles.appBarStyle,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(
              right: AppSizes.size10,
            ),
            child: Icon(
              Icons.search,
              size: HomeScreenSizes.searchIconSize,
              color: HomeScreenColors.searchIconButtonColor,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.screensHorizontalPadding,
        ),
        child: HomeScreenBodyWidget(
          bloc: bloc,
          isDesktop: false,
        ),
      ),
    );
  }
}
