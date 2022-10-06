import 'package:flutter/material.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';

class TabBarWidget extends StatefulWidget {
  final VoidCallback _goToHomePage;
  final VoidCallback _goToLoginPage;

  const TabBarWidget(this._goToHomePage, this._goToLoginPage, {super.key});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  int _currentIndex = 0;

  set currentIndex(int index) => setState(() {
        if (_currentIndex != index) {
          _currentIndex = index;
        }
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
        onTap: (tabIconIndex) {
          currentIndex = tabIconIndex;
          switch (tabIconIndex) {
            case 0:
              widget._goToHomePage();
              break;
            case 3:
              widget._goToLoginPage();
          }
        },
      ),
    );
  }
}
