import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/coffee_provider.dart';
import '../utils/app_colors.dart';
import 'payment_screen.dart';
import 'settings_screen.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback? onOpenDrawer;
  const CartScreen({super.key, this.onOpenDrawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        child: Consumer<CoffeeProvider>(
          builder: (context, provider, _) {
            return Column(
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
                        "Cart",
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

                // ── Cart Items ──
                Expanded(
                  child: provider.cart.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart_outlined,
                                  color: AppColors.textSecondary(context), size: 60),
                              const SizedBox(height: 15),
                              Text(
                                "Your cart is empty",
                                style: TextStyle(
                                    color: AppColors.textPrimary(context),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Add some coffee to get started!",
                                style: TextStyle(
                                    color: AppColors.textSecondary(context), fontSize: 13),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          itemCount: provider.cart.length,
                          itemBuilder: (context, index) {
                            final item = provider.cart[index];
                            return _cartItemCard(context, provider, item);
                          },
                        ),
                ),

                // ── Bottom Checkout Bar ──
                if (provider.cart.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 25),
                    decoration: BoxDecoration(
                      color: AppColors.background(context),
                      border: Border(
                        top: BorderSide(
                          color: AppColors.border(context),
                          width: 0.8,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Total Price",
                              style: TextStyle(
                                  color: AppColors.textSecondary(context), fontSize: 13),
                            ),
                            const SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "\$ ",
                                    style: TextStyle(
                                      color: AppColors.kPrimaryOrange,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: provider.totalAmount
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                      color: AppColors.textPrimary(context),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                    amount: provider.totalAmount),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 16),
                            decoration: BoxDecoration(
                              color: AppColors.kPrimaryOrange,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Text(
                              "Pay",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _cartItemCard(
      BuildContext context, CoffeeProvider provider, dynamic item) {
    final isDark = AppColors.isDark(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card(context),
        borderRadius: BorderRadius.circular(22),
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
      child: Column(
        children: [
          // Top row: Image + Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  item.image,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        color: AppColors.textPrimary(context),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.type,
                      style: TextStyle(
                        color: AppColors.textSecondary(context),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Size + Price row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.cardAlt(context),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.selectedSize,
                            style: TextStyle(
                              color: AppColors.textPrimary(context),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "\$ ",
                                style: TextStyle(
                                  color: AppColors.kPrimaryOrange,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: item.priceForSelectedSize
                                    .toStringAsFixed(2),
                                style: TextStyle(
                                  color: AppColors.textPrimary(context),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Bottom: Quantity controls
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _qtyBtn(Icons.remove, () {
                provider.updateQuantity(item.id, item.selectedSize, -1);
              }),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.cardAlt(context),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.kPrimaryOrange, width: 1),
                ),
                child: Text(
                  "${item.quantity}",
                  style: TextStyle(
                    color: AppColors.textPrimary(context),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _qtyBtn(Icons.add, () {
                provider.updateQuantity(item.id, item.selectedSize, 1);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryOrange,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
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
