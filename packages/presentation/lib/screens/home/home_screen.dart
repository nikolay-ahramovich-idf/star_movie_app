import 'package:flutter/material.dart';
import 'package:presentation/bloc/base/bloc_screen.dart';
import 'package:presentation/const.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screens/home/home_bloc.dart';
import 'package:presentation/screens/home/widgets/movie_card.dart';
import 'package:presentation/screens/home/widgets/rating.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const _routeName = '/HomeScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (_) => const HomeScreen(),
      );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BlocScreenState<HomeScreen, HomeBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeScreenColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HomeScreenColors.primaryColor,
        centerTitle: false,
        title: const Text(
          'Star Movie',
          style: HomeScreenStyles.appBarStyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: AppSizes.size10,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: HomeScreenSizes.searchIconSize,
              ),
              color: HomeScreenColors.searchIconButtonColor,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: HomeScreenSizes.horizontalPaddingSize,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: AppSizes.size24,
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  HomeScreenSizes.selectionBorderRadiusSize,
                ),
                border: Border.all(
                  width: HomeScreenSizes.selectionBorderWidth,
                  color: HomeScreenColors.selectionBorderColor,
                ),
              ),
            ),
            const SizedBox(
              height: AppSizes.size24,
            ),
            StreamBuilder(
              stream: bloc.stream,
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (data != null) {
                  return Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 2.15,
                        crossAxisSpacing: AppSizes.size13,
                        mainAxisSpacing: 30,
                      ),
                      itemBuilder: (context, index) {
                        return const MovieCard();
                      },
                    ),
                  );
                } else {
                  return const CircularProgressIndicator(); // TODO possible remove
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 15),
        decoration: const BoxDecoration(
          color: HomeScreenColors.primaryColor,
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
          backgroundColor: HomeScreenColors.primaryColor,
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
          onTap: null,
        ),
      ),
    );
  }
}
