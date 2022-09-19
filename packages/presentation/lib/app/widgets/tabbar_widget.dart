import 'package:flutter/material.dart';
import 'package:presentation/const.dart';

class TabBarWidget extends StatelessWidget {
  final VoidCallback _pop;

  const TabBarWidget(this._pop, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.primaryColor,
        unselectedItemColor: HomeScreenColors.bottomNavBarIconColorInactive,
        elevation: 0,
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
          if (tabIconIndex == 0) {
            _pop();
          }
        },
      ),
    );
  }
}
