import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/coffee_provider.dart';
import '../utils/app_colors.dart';

class PaymentScreen extends StatefulWidget {
  final double amount;
  const PaymentScreen({super.key, required this.amount});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedMethod = 0; // 0 = Credit Card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: AppColors.cardAlt(context),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border(context)),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.textSecondary(context),
                        size: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Payment",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textPrimary(context),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 36), // Balance the back button
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Credit Card Section
                    GestureDetector(
                      onTap: () => setState(() => _selectedMethod = 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.card(context),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: _selectedMethod == 0
                                ? AppColors.kPrimaryOrange
                                : AppColors.border(context),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Credit Card label
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                              child: Text(
                                "Credit Card",
                                style: TextStyle(
                                  color: _selectedMethod == 0
                                      ? AppColors.kPrimaryOrange
                                      : AppColors.textSecondary(context),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Credit Card UI
                            Container(
                              margin: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                              width: double.infinity,
                              height: 195,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF262B33),
                                    Color(0xFF141921),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white10),
                              ),
                              padding: const EdgeInsets.all(22),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Chip icon
                                      Container(
                                        width: 38,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: AppColors.kPrimaryOrange,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: const Icon(
                                          Icons.credit_card,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                      // Visa Logo
                                      const Text(
                                        "VISA",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    "3 8 9 7    8 9 2 3    6 7 4 5    4 6 3 8",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Card Holder Name",
                                            style: TextStyle(
                                              color: AppColors.kLightGrey,
                                              fontSize: 10,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          const Text(
                                            "Abdullah",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Expiry Date",
                                            style: TextStyle(
                                              color: AppColors.kLightGrey,
                                              fontSize: 10,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          const Text(
                                            "02/30",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Payment Methods
                    _paymentMethodTile(
                      icon: Icons.account_balance_wallet,
                      title: "Wallet",
                      subtitle: "\$ 100.50",
                      index: 1,
                    ),
                    _paymentMethodTile(
                      icon: Icons.g_mobiledata_rounded,
                      title: "Google Pay",
                      subtitle: "",
                      index: 2,
                      iconColor: Colors.blue,
                    ),
                    _paymentMethodTile(
                      icon: Icons.apple,
                      title: "Apple Pay",
                      subtitle: "",
                      index: 3,
                    ),
                    _paymentMethodTile(
                      icon: Icons.shopping_bag_outlined,
                      title: "Amazon Pay",
                      subtitle: "",
                      index: 4,
                      iconColor: AppColors.kPrimaryOrange,
                    ),
                  ],
                ),
              ),
            ),

            // Bottom: Price + Pay Button
            Container(
              padding: const EdgeInsets.fromLTRB(25, 15, 25, 28),
              decoration: BoxDecoration(
                color: AppColors.background(context),
                border: Border(
                  top: BorderSide(color: AppColors.border(context), width: 1),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Price",
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
                              text: widget.amount.toStringAsFixed(2),
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
                  const SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _processPayment(context),
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryOrange,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Center(
                          child: Text(
                            _getPayButtonText(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
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

  String _getPayButtonText() {
    switch (_selectedMethod) {
      case 0:
        return "Pay from Credit Card";
      case 1:
        return "Pay from Wallet";
      case 2:
        return "Pay with Google Pay";
      case 3:
        return "Pay with Apple Pay";
      case 4:
        return "Pay with Amazon Pay";
      default:
        return "Pay Now";
    }
  }

  void _processPayment(BuildContext context) {
    final provider = Provider.of<CoffeeProvider>(context, listen: false);
    provider.addOrderToHistory(widget.amount);
    provider.clearCart();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                color: AppColors.kPrimaryOrange,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 20),
            Text(
              "Payment Successful!",
              style: TextStyle(
                color: AppColors.textPrimary(context),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Your artisanal coffee is being brewed fresh.",
              style: TextStyle(
                color: AppColors.textSecondary(context),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () => Navigator.popUntil(ctx, (route) => route.isFirst),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryOrange,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    "Back to Home",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentMethodTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required int index,
    Color? iconColor,
  }) {
    final isSelected = _selectedMethod == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.card(context),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.kPrimaryOrange : AppColors.border(context),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor ?? AppColors.kPrimaryOrange, size: 24),
                const SizedBox(width: 15),
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textPrimary(context),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (subtitle.isNotEmpty)
              Text(
                subtitle,
                style: TextStyle(
                  color: AppColors.textSecondary(context),
                  fontSize: 14,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

