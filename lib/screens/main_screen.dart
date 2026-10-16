import 'package:flutter/material.dart';
import '../home_page.dart';
import '../utils/app_colors.dart';
import '../widgets/app_drawer.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'notifications_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomePage(onOpenDrawer: _openDrawer),
      CartScreen(onOpenDrawer: _openDrawer),
      FavoritesScreen(onOpenDrawer: _openDrawer),
      NotificationsScreen(onOpenDrawer: _openDrawer),
    ];

    final isDark = AppColors.isDark(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      backgroundColor: AppColors.background(context),
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.background(context),
          border: Border(
            top: BorderSide(
              color: AppColors.border(context),
              width: 0.5,
            ),
          ),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.background(context),
          selectedItemColor: AppColors.kPrimaryOrange,
          unselectedItemColor: AppColors.textSecondary(context),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
                size: 26,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 1
                    ? Icons.shopping_bag_rounded
                    : Icons.shopping_bag_outlined,
                size: 26,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 2
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                size: 26,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 3
                    ? Icons.notifications_rounded
                    : Icons.notifications_none_rounded,
                size: 26,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
