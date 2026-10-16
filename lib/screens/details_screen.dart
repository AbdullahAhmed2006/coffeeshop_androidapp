import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/coffee_model.dart';
import '../providers/coffee_provider.dart';
import '../utils/app_colors.dart';

class DetailsScreen extends StatefulWidget {
  final Coffee coffee;
  const DetailsScreen({super.key, required this.coffee});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late String selectedSize;
  bool _isDescExpanded = false;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.coffee.sizes.first;
  }

  double get currentPrice {
    if (widget.coffee.sizePrices.containsKey(selectedSize)) {
      return widget.coffee.sizePrices[selectedSize]!;
    }
    return widget.coffee.price;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CoffeeProvider>(context, listen: false);
    final isBean = widget.coffee.isBean;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Image Header ──
                  Stack(
                    children: [
                      // Full-bleed image
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.52,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: Image.asset(
                            widget.coffee.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Gradient at bottom of image
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.8),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Back & Favorite buttons
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 10,
                        left: 20,
                        right: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _circleButton(
                              Icons.arrow_back_ios_new,
                              () => Navigator.pop(context),
                              color: Colors.white,
                            ),
                            Consumer<CoffeeProvider>(
                              builder: (context, p, _) => _circleButton(
                                p.isFavorite(widget.coffee.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                () => p.toggleFavorite(widget.coffee.id),
                                color: p.isFavorite(widget.coffee.id)
                                    ? AppColors.kFavoriteRed
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Info overlay at bottom of image
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.55),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Left: Name, Type
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.coffee.name,
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          widget.coffee.type,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColors.kLightGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Right: Badges
                                  Row(
                                    children: [
                                      _infoBadge(
                                        isBean
                                            ? Icons.coffee
                                            : Icons.coffee,
                                        isBean ? 'Bean' : 'Coffee',
                                      ),
                                      const SizedBox(width: 10),
                                      _infoBadge(
                                        isBean
                                            ? Icons.location_on
                                            : Icons.water_drop,
                                        isBean
                                            ? widget.coffee.origin
                                            : 'Milk',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Rating
                                  Row(
                                    children: [
                                      const Icon(Icons.star_rounded,
                                          color: AppColors.kStarGold,
                                          size: 22),
                                      const SizedBox(width: 5),
                                      Text(
                                        widget.coffee.rating.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "(${widget.coffee.reviews.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')})",
                                        style: const TextStyle(
                                          color: AppColors.kLightGrey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Roasted badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.6),
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      widget.coffee.roasted,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ── Description ──
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                            color: AppColors.textPrimary(context),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isDescExpanded = !_isDescExpanded;
                            });
                          },
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: AppColors.textSecondary(context),
                                fontSize: 13,
                                height: 1.7,
                              ),
                              children: [
                                TextSpan(
                                  text: _isDescExpanded
                                      ? widget.coffee.description
                                      : (widget.coffee.description.length >
                                              120
                                          ? '${widget.coffee.description.substring(0, 120)}...'
                                          : widget.coffee.description),
                                ),
                                if (!_isDescExpanded &&
                                    widget.coffee.description.length > 120)
                                  const TextSpan(
                                    text: ' Read More',
                                    style: TextStyle(
                                      color: AppColors.kPrimaryOrange,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ── Size Selector ──
                        Text(
                          "Size",
                          style: TextStyle(
                            color: AppColors.textPrimary(context),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: widget.coffee.sizes
                              .map((size) => Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: size !=
                                                widget.coffee.sizes.last
                                            ? 12
                                            : 0,
                                      ),
                                      child: _sizeOption(size),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // ── Bottom Bar ──
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
            decoration: BoxDecoration(
              color: AppColors.background(context),
              border: Border(
                top: BorderSide(
                  color: AppColors.border(context),
                  width: 1,
                ),
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
                            text: currentPrice.toStringAsFixed(2),
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
                const SizedBox(width: 30),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final coffeeToAdd = widget.coffee.copyWith(
                        selectedSize: selectedSize,
                        price: currentPrice,
                      );
                      provider.addToCart(coffeeToAdd);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "${widget.coffee.name} ($selectedSize) added to cart!"),
                          backgroundColor: AppColors.cardAlt(context),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryOrange,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Center(
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
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
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap,
      {Color color = Colors.white}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        width: 38,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }

  Widget _infoBadge(IconData icon, String label) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.kPrimaryOrange, size: 20),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 9),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _sizeOption(String size) {
    bool isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () => setState(() => selectedSize = size),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.kPrimaryOrange.withValues(alpha: 0.15)
              : AppColors.card(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.kPrimaryOrange : AppColors.border(context),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              color: isSelected
                  ? AppColors.kPrimaryOrange
                  : AppColors.textSecondary(context),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
