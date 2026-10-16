import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/coffee_model.dart';
import '../providers/coffee_provider.dart';
import '../screens/details_screen.dart';
import '../utils/app_colors.dart';

class BeanTile extends StatelessWidget {
  final Coffee bean;
  const BeanTile({super.key, required this.bean});

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen(coffee: bean)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        width: 160,
        decoration: BoxDecoration(
          color: AppColors.card(context),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: AppColors.border(context),
            width: 1,
          ),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Rating
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    bean.image,
                    height: 132,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded,
                            color: AppColors.kStarGold, size: 13),
                        const SizedBox(width: 3),
                        Text(
                          bean.rating.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              bean.name,
              style: TextStyle(
                color: AppColors.textPrimary(context),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              bean.type,
              style: TextStyle(color: AppColors.textSecondary(context), fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "\$ ",
                        style: TextStyle(
                          color: AppColors.kPrimaryOrange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: bean.price.toStringAsFixed(2),
                        style: TextStyle(
                          color: AppColors.textPrimary(context),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final provider =
                        Provider.of<CoffeeProvider>(context, listen: false);
                    provider.addToCart(bean);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${bean.name} added to cart!"),
                        backgroundColor: AppColors.cardAlt(context),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryOrange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        const Icon(Icons.add, color: Colors.white, size: 18),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
