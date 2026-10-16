import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../utils/app_colors.dart';
import '../screens/about_screen.dart';
import '../screens/contact_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/order_history_screen.dart';
import '../screens/rewards_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Drawer(
      backgroundColor: AppColors.background(context),
      child: SafeArea(
        child: Column(
          children: [
            // ── User Header Profile ──
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.card(context),
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.border(context),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 58,
                    width: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: AppColors.kPrimaryOrange,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset('assets/me.png', fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Abdullah',
                          style: TextStyle(
                            color: AppColors.textPrimary(context),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'abdullah@coffee.com',
                          style: TextStyle(
                            color: AppColors.textSecondary(context),
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryOrange.withValues(
                              alpha: 0.15,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.kPrimaryOrange.withValues(
                                alpha: 0.5,
                              ),
                              width: 0.8,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.workspace_premium,
                                color: AppColors.kPrimaryOrange,
                                size: 12,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'VIP Gold Member',
                                style: TextStyle(
                                  color: AppColors.kPrimaryOrange,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Quick Appearance Switcher ──
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.card(context),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border(context), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        isDark ? Icons.dark_mode : Icons.light_mode,
                        color: AppColors.kPrimaryOrange,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        isDark ? 'Dark Mode' : 'Light Mode',
                        style: TextStyle(
                          color: AppColors.textPrimary(context),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Switch.adaptive(
                    value: isDark,
                    activeTrackColor: AppColors.kPrimaryOrange,
                    onChanged: (val) {
                      themeProvider.toggleTheme(val);
                    },
                  ),
                ],
              ),
            ),

            // ── Drawer Menu Navigation ──
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _drawerTile(
                    context: context,
                    icon: Icons.home_rounded,
                    title: 'Home',
                    onTap: () => Navigator.pop(context),
                  ),
                  _drawerTile(
                    context: context,
                    icon: Icons.receipt_long_rounded,
                    title: 'Order History',
                    badge: 'Recent',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderHistoryScreen(),
                        ),
                      );
                    },
                  ),
                  _drawerTile(
                    context: context,
                    icon: Icons.card_giftcard_rounded,
                    title: 'Rewards & Offers',
                    badge: '350 pts',
                    badgeColor: AppColors.kPrimaryOrange,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RewardsScreen(),
                        ),
                      );
                    },
                  ),
                  _drawerTile(
                    context: context,
                    icon: Icons.settings_rounded,
                    title: 'App Settings',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(
                    height: 24,
                    thickness: 1,
                    indent: 8,
                    endIndent: 8,
                  ),
                  _drawerTile(
                    context: context,
                    icon: Icons.info_outline_rounded,
                    title: 'About Us',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutScreen(),
                        ),
                      );
                    },
                  ),
                  _drawerTile(
                    context: context,
                    icon: Icons.support_agent_rounded,
                    title: 'Contact & Support',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContactScreen(),
                        ),
                      );
                    },
                  ),
                  _drawerTile(
                    context: context,
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: () {
                      Navigator.pop(context);
                      _showPrivacyDialog(context);
                    },
                  ),
                ],
              ),
            ),

            // ── Footer ──
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.border(context), width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Coffee Shop v1.0.0',
                    style: TextStyle(
                      color: AppColors.textSecondary(context),
                      fontSize: 12,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Session active. Enjoy your coffee!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            size: 16,
                            color: AppColors.kFavoriteRed,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: AppColors.kFavoriteRed,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? badge,
    Color? badgeColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.cardAlt(context),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.kPrimaryOrange, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimary(context),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (badgeColor ?? AppColors.cardAlt(context)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: badgeColor != null
                        ? Colors.white
                        : AppColors.textSecondary(context),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: AppColors.textSecondary(context),
              ),
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.shield_outlined, color: AppColors.kPrimaryOrange),
            const SizedBox(width: 8),
            Text(
              'Privacy & Terms',
              style: TextStyle(
                color: AppColors.textPrimary(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(
            'We value your privacy and trust. At My Coffee Shop, we only collect essential data to fulfill your orders, provide loyalty rewards, and enhance your artisanal coffee experience. Your payment information is securely processed using bank-grade encryption.\n\nAll coffee beans and beverages are freshly prepared in compliance with international food safety standards.',
            style: TextStyle(
              color: AppColors.textSecondary(context),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Understood',
              style: TextStyle(
                color: AppColors.kPrimaryOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
