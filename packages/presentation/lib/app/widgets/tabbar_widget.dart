import 'package:flutter/material.dart';
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

  const TabBarWidget(
    this._currentIndex, {
    required this.loadPage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.support,
              size: HomeScreenSizes.bottomNavBarIconSize,
            ),
            label: 'Movie Reel',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.airplane_ticket_rounded,
              size: HomeScreenSizes.bottomNavBarIconSize,
            ),
            label: 'Event Ticket',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: HomeScreenSizes.bottomNavBarIconSize,
            ),
            label: 'Alarm',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: HomeScreenSizes.bottomNavBarIconSize,
            ),
            label: 'Single',
          ),
        ],
        onTap: loadPage,
      ),
    );
  }
}
