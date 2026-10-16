import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        backgroundColor: AppColors.background(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary(context),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Rewards & Offers',
          style: TextStyle(
            color: AppColors.textPrimary(context),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Loyalty Balance Card ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2E1C12), Color(0xFF141921)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.kPrimaryOrange.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'BEAN REWARDS CLUB',
                        style: TextStyle(
                          color: AppColors.kPrimaryOrange,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryOrange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'VIP TIER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '350',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'pts',
                        style: TextStyle(
                          color: AppColors.kPrimaryOrange,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Equivalent value: \$3.50 in discounts',
                    style: TextStyle(
                      color: AppColors.kLightGrey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // ── Stamp Card (Buy 8, Get 1 Free) ──
            Text(
              'COFFEE STAMP CARD',
              style: const TextStyle(
                color: AppColors.kPrimaryOrange,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.card(context),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border(context)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Buy 8 Cups, Get 1 Free',
                        style: TextStyle(
                          color: AppColors.textPrimary(context),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '5 / 8 Completed',
                        style: TextStyle(
                          color: AppColors.kPrimaryOrange,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(8, (index) {
                      final isStampEarned = index < 5;
                      final isRewardCup = index == 7;
                      return Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: isStampEarned
                              ? AppColors.kPrimaryOrange
                              : AppColors.cardAlt(context),
                          shape: BoxShape.circle,
                          border: isRewardCup
                              ? Border.all(
                                  color: AppColors.kPrimaryOrange,
                                  width: 2,
                                  style: BorderStyle.solid)
                              : null,
                        ),
                        child: Icon(
                          isRewardCup
                              ? Icons.card_giftcard_rounded
                              : Icons.coffee_rounded,
                          color: isStampEarned
                              ? Colors.white
                              : (isRewardCup
                                  ? AppColors.kPrimaryOrange
                                  : AppColors.textSecondary(context)),
                          size: 22,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // ── Redeemable Vouchers ──
            Text(
              'REDEEMABLE VOUCHERS',
              style: const TextStyle(
                color: AppColors.kPrimaryOrange,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _rewardTile(
              context: context,
              pts: '100 pts',
              title: 'Free Extra Espresso Shot',
              desc: 'Add an extra shot to any handcrafted beverage',
            ),
            const SizedBox(height: 10),
            _rewardTile(
              context: context,
              pts: '250 pts',
              title: '50% Off Any Pastry or Bean',
              desc: 'Get half off on freshly roasted Brazilian beans or croissant',
            ),
            const SizedBox(height: 10),
            _rewardTile(
              context: context,
              pts: '350 pts',
              title: 'Free Artisanal Cappuccino (Large)',
              desc: 'Redeem 1 free handcrafted Cappuccino with steamed milk',
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _rewardTile({
    required BuildContext context,
    required String pts,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card(context),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.kPrimaryOrange.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              pts,
              style: const TextStyle(
                color: AppColors.kPrimaryOrange,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textPrimary(context),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  desc,
                  style: TextStyle(
                    color: AppColors.textSecondary(context),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kPrimaryOrange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Voucher "$title" redeemed! Applied to your next order.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text(
              'Redeem',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
