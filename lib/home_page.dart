import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/coffee_provider.dart';
import 'widgets/tile.dart';
import 'widgets/bean_tile.dart';
import 'utils/app_colors.dart';
import 'screens/settings_screen.dart';

class HomePage extends StatefulWidget {
  final VoidCallback? onOpenDrawer;
  const HomePage({super.key, this.onOpenDrawer});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _categoryIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> categories = [
    'All',
    'Cappuccino',
    'Espresso',
    'Americano',
    'Latte',
    'Macchiato',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.onOpenDrawer != null) {
                          widget.onOpenDrawer!();
                        } else {
                          Scaffold.of(context).openDrawer();
                        }
                      },
                      child: _headerIcon(Icons.apps_rounded),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                      child: _headerAvatar(),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // ── Title ──
                Text(
                  "Find the best\ncoffee for you",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary(context),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 25),

                // ── Search Bar ──
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.card(context),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColors.border(context),
                      width: 1,
                    ),
                    boxShadow: AppColors.isDark(context)
                        ? []
                        : [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(color: AppColors.textPrimary(context)),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.kGreyText,
                      ),
                      hintText: "Find Your Coffee...",
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary(context),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                              child: const Icon(
                                Icons.close,
                                color: AppColors.kGreyText,
                                size: 18,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // ── Categories ──
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final isSelected = _categoryIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => _categoryIndex = index),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 22.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                categories[index],
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.kPrimaryOrange
                                      : AppColors.textSecondary(context),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (isSelected)
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  height: 5,
                                  width: 5,
                                  decoration: const BoxDecoration(
                                    color: AppColors.kPrimaryOrange,
                                    shape: BoxShape.circle,
                                  ),
                                )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // ── Coffee List ──
                SizedBox(
                  height: 260,
                  child: Consumer<CoffeeProvider>(
                    builder: (context, provider, _) {
                      var filteredList = _categoryIndex == 0
                          ? provider.coffees
                          : provider.getItemsByCategory(
                              categories[_categoryIndex]);

                      // Apply search filter
                      if (_searchQuery.isNotEmpty) {
                        filteredList = filteredList
                            .where((item) =>
                                item.name
                                    .toLowerCase()
                                    .contains(_searchQuery) ||
                                item.type
                                    .toLowerCase()
                                    .contains(_searchQuery))
                            .toList();
                      }

                      if (filteredList.isEmpty) {
                        return Center(
                          child: Text(
                            "No coffees found",
                            style: TextStyle(
                              color: AppColors.textSecondary(context),
                              fontSize: 16,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: CoffeeTile(coffee: filteredList[index]),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 28),

                // ── Coffee Beans Section ──
                Text(
                  "Coffee beans",
                  style: TextStyle(
                    color: AppColors.textPrimary(context),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),

                // ── Bean List ──
                SizedBox(
                  height: 260,
                  child: Consumer<CoffeeProvider>(
                    builder: (context, provider, _) {
                      var beanList = provider.beans;

                      // Apply search filter to beans
                      if (_searchQuery.isNotEmpty) {
                        beanList = beanList
                            .where((item) =>
                                item.name
                                    .toLowerCase()
                                    .contains(_searchQuery) ||
                                item.type
                                    .toLowerCase()
                                    .contains(_searchQuery))
                            .toList();
                      }

                      if (beanList.isEmpty) {
                        return Center(
                          child: Text(
                            "No beans found",
                            style: TextStyle(
                              color: AppColors.textSecondary(context),
                              fontSize: 16,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: beanList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: BeanTile(bean: beanList[index]),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerIcon(IconData icon) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: AppColors.cardAlt(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border(context), width: 1),
      ),
      child: Icon(icon, color: AppColors.textSecondary(context), size: 20),
    );
  }

  Widget _headerAvatar() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border(context), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset('assets/me.png', fit: BoxFit.cover),
      ),
    );
  }
}
