import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/coffee_provider.dart';
import '../utils/app_colors.dart';
import 'settings_screen.dart';

class NotificationsScreen extends StatelessWidget {
  final VoidCallback? onOpenDrawer;
  const NotificationsScreen({super.key, this.onOpenDrawer});

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (onOpenDrawer != null) {
                        onOpenDrawer!();
                      } else {
                        Scaffold.of(context).openDrawer();
                      }
                    },
                    child: _headerIcon(context, Icons.apps_rounded),
                  ),
                  Text(
                    "Notifications",
                    style: TextStyle(
                      color: AppColors.textPrimary(context),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
                    child: _headerAvatar(context),
                  ),
                ],
              ),
            ),

            // ── Notifications List ──
            Expanded(
              child: Consumer<CoffeeProvider>(
                builder: (context, provider, _) {
                  final notifications = provider.orderHistory.isNotEmpty
                      ? provider.orderHistory
                      : [
                          'Special Offer: 50% discount on Arabica Beans today! • 10m ago',
                          'Your morning Cappuccino is ready for pickup • 2h ago',
                          'Welcome to My Coffee Shop! You received 100 VIP beans points. • 1d ago',
                        ];

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notif = notifications[index];
                      final isOffer = notif.contains('Offer') || notif.contains('discount') || notif.contains('VIP');

                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.card(context),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.border(context), width: 1),
                          boxShadow: isDark
                              ? []
                              : [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.03),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                color: AppColors.kPrimaryOrange
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                isOffer
                                    ? Icons.discount_rounded
                                    : Icons.coffee_rounded,
                                color: AppColors.kPrimaryOrange,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isOffer ? "Special Promotion!" : "Order Update",
                                    style: TextStyle(
                                      color: AppColors.textPrimary(context),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notif,
                                    style: TextStyle(
                                      color: AppColors.textSecondary(context),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              isOffer
                                  ? Icons.star_rounded
                                  : Icons.check_circle_rounded,
                              color: isOffer ? AppColors.kStarGold : Colors.green,
                              size: 20,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerIcon(BuildContext context, IconData icon) {
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

  Widget _headerAvatar(BuildContext context) {
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
