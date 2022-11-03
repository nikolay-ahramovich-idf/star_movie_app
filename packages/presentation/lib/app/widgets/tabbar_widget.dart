import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';

enum BottomNavigationItemType {
  home,
  event,
  alarm,
  login,
}

class TabBarWidget extends StatelessWidget {
  final int _currentIndex;
  final void Function(int index) loadPage;
  final bool isDesktop;

  const TabBarWidget(
    this._currentIndex, {
    required this.loadPage,
    required this.isDesktop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (isDesktop) {
      return NavigationRail(
        backgroundColor: AppColors.primaryColor,
        destinations: [
          NavigationRailDestination(
            icon: const Icon(
              Icons.support,
              size: HomeScreenSizes.bottomNavBarIconSize,
            ),
            label: Text(appLocalizations.menuMovieReelButtonLabel),
          ),
          NavigationRailDestination(
            icon: const Icon(
              Icons.airplane_ticket_rounded,
              size: HomeScreenSizes.bottomNavBarIconSize,
            ),
            label: Text(appLocalizations.menuEventTicketButtonLabel),
          ),
          NavigationRailDestination(
            icon: const Icon(
              Icons.notifications,
              size: HomeScreenSizes.bottomNavBarIconSize,
            ),
            label: Text(appLocalizations.menuAlarmButtonLabel),
          ),
          NavigationRailDestination(
            icon: const Icon(
              Icons.person,
              size: HomeScreenSizes.bottomNavBarIconSize,
            ),
            label: Text(appLocalizations.menuSingleButtonLabel),
          ),
        ],
        selectedIndex: _currentIndex,
        elevation: null,
        onDestinationSelected: loadPage,
        unselectedIconTheme: const IconThemeData(
          color: Colors.white,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.only(bottom: AppSizes.size15),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        border: Border(
          top: BorderSide(
            width: AppSizes.size1,
            color: AppColors.dividersColor,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.primaryColor,
        unselectedItemColor: HomeScreenColors.bottomNavBarIconColorInactive,
        elevation: AppSizes.size0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.support,
              size: HomeScreenSizes.bottomNavBarIconSize,
            ),
            label: appLocalizations.menuMovieReelButtonLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.airplane_ticket_rounded,
              size: HomeScreenSizes.bottomNavBarIconSize,
            ),
            label: appLocalizations.menuEventTicketButtonLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.notifications,
              size: HomeScreenSizes.bottomNavBarIconSize,
            ),
            label: appLocalizations.menuAlarmButtonLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.person,
              size: HomeScreenSizes.bottomNavBarIconSize,
            ),
            label: appLocalizations.menuSingleButtonLabel,
          ),
        ],
        onTap: loadPage,
      ),
    );
  }
}
