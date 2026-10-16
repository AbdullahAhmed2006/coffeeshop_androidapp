import 'package:flutter/material.dart';
import '../models/coffee_model.dart';

class CoffeeProvider with ChangeNotifier {
  // Catalog of items
  final List<Coffee> _items = [
    // ── Coffee Drinks ──
    Coffee(
      id: 'c1',
      name: 'Cappuccino',
      type: 'With Steamed Milk',
      price: 4.20,
      image: 'assets/coffee_cappuccino_latteart.jpg',
      rating: 4.5,
      reviews: 6879,
      roasted: 'Medium Roasted',
      category: 'coffee',
      sizes: ['S', 'M', 'L'],
      selectedSize: 'S',
      sizePrices: {'S': 4.20, 'M': 5.20, 'L': 6.20},
      description:
          'Cappuccino is a classic Italian coffee drink made with equal parts espresso, steamed milk, and silky smooth milk foam, finished with intricate latte art.',
    ),
    Coffee(
      id: 'c2',
      name: 'Cappuccino',
      type: 'With Extra Foam',
      price: 4.20,
      image: 'assets/coffee_cappuccino.jpg',
      rating: 4.2,
      reviews: 4521,
      roasted: 'Medium Roasted',
      category: 'coffee',
      sizes: ['S', 'M', 'L'],
      selectedSize: 'S',
      sizePrices: {'S': 4.20, 'M': 5.20, 'L': 6.20},
      description:
          'A rich cappuccino topped with a generous layer of velvety foam, delivering a smooth, aromatic, and creamy coffee experience.',
    ),
    Coffee(
      id: 'c3',
      name: 'Espresso',
      type: 'Strong & Bold',
      price: 3.50,
      image: 'assets/coffee_espresso.jpg',
      rating: 4.8,
      reviews: 1200,
      roasted: 'Dark Roasted',
      category: 'coffee',
      sizes: ['S', 'M', 'L'],
      selectedSize: 'S',
      sizePrices: {'S': 3.50, 'M': 4.50, 'L': 5.50},
      description:
          'A pure espresso shot with a rich golden crema, made from finely ground dark roasted beans for an intense and robust flavor.',
    ),
    Coffee(
      id: 'c4',
      name: 'Americano',
      type: 'With Hot Water',
      price: 3.80,
      image: 'assets/coffee_americano_hot.jpg',
      rating: 4.3,
      reviews: 2340,
      roasted: 'Medium Roasted',
      category: 'coffee',
      sizes: ['S', 'M', 'L'],
      selectedSize: 'S',
      sizePrices: {'S': 3.80, 'M': 4.80, 'L': 5.80},
      description:
          'An Americano is prepared by pulling a rich shot of espresso and topping it with hot water, giving an exceptionally clean, smooth cup.',
    ),
    Coffee(
      id: 'c5',
      name: 'Latte',
      type: 'With Steamed Milk',
      price: 4.50,
      image: 'assets/coffee_latte.jpg',
      rating: 4.6,
      reviews: 3400,
      roasted: 'Medium Roasted',
      category: 'coffee',
      sizes: ['S', 'M', 'L'],
      selectedSize: 'S',
      sizePrices: {'S': 4.50, 'M': 5.50, 'L': 6.50},
      description:
          'Classic caffe latte prepared with smooth steamed micro-foam milk, harmoniously balanced with a single shot of rich espresso.',
    ),
    Coffee(
      id: 'c6',
      name: 'Macchiato',
      type: 'With Milk Foam & Caramel',
      price: 4.00,
      image: 'assets/coffee_macchiato_layer.jpg',
      rating: 4.4,
      reviews: 1890,
      roasted: 'Medium Roasted',
      category: 'coffee',
      sizes: ['S', 'M', 'L'],
      selectedSize: 'S',
      sizePrices: {'S': 4.00, 'M': 5.00, 'L': 6.00},
      description:
          'Fresh espresso gently marked with dense foamed milk and a touch of caramel drizzle, offering a bold yet delightfully balanced taste.',
    ),

    // ── Coffee Beans ──
    Coffee(
      id: 'b1',
      name: 'Robusta Beans',
      type: 'From Africa',
      price: 4.20,
      image: 'assets/beans_robusta.jpg',
      rating: 4.5,
      reviews: 6879,
      roasted: 'Dark Roasted',
      category: 'bean',
      origin: 'Africa',
      sizes: ['250gm', '500gm', '1000gm'],
      selectedSize: '250gm',
      sizePrices: {'250gm': 4.20, '500gm': 8.50, '1000gm': 10.50},
      description:
          'High-altitude African Robusta beans known for their deep body, intense chocolatey undertones, and elevated caffeine profile. Excellent for dense crema.',
    ),
    Coffee(
      id: 'b2',
      name: 'Arabica Blend',
      type: 'From Brazil',
      price: 4.80,
      image: 'assets/beans_arabica_blend.jpg',
      rating: 4.9,
      reviews: 5120,
      roasted: 'Medium Roasted',
      category: 'bean',
      origin: 'Brazil',
      sizes: ['250gm', '500gm', '1000gm'],
      selectedSize: '250gm',
      sizePrices: {'250gm': 4.80, '500gm': 9.00, '1000gm': 14.00},
      description:
          'Single-estate 100% Brazilian Arabica beans with tasting notes of honey, toasted almonds, and sweet milk chocolate with a smooth finish.',
    ),
    Coffee(
      id: 'b3',
      name: 'Excelsa Beans',
      type: 'From Southeast Asia',
      price: 5.50,
      image: 'assets/beans_excelsa_roast.jpg',
      rating: 4.7,
      reviews: 980,
      roasted: 'Artisanal Dark Roasted',
      category: 'bean',
      origin: 'Southeast Asia',
      sizes: ['250gm', '500gm', '1000gm'],
      selectedSize: '250gm',
      sizePrices: {'250gm': 5.50, '500gm': 10.00, '1000gm': 15.00},
      description:
          'Excelsa beans are an exotic, rare variety grown in Southeast Asia. They feature a unique tart, fruity, and dark roast profile with complex aromatics.',
    ),
  ];

  final List<Coffee> _cart = [];
  final Set<String> _favorites = {};
  final List<String> _orderHistory = [];

  List<Coffee> get items => [..._items];
  List<Coffee> get cart => [..._cart];
  Set<String> get favorites => _favorites;
  List<String> get orderHistory => [..._orderHistory];

  List<Coffee> get coffees =>
      _items.where((item) => item.category == 'coffee').toList();
  List<Coffee> get beans =>
      _items.where((item) => item.category == 'bean').toList();

  List<Coffee> getItemsByCategory(String category) {
    if (category == 'All') return coffees;
    return coffees.where((item) => item.name == category).toList();
  }

  double get totalAmount {
    var total = 0.0;
    for (var item in _cart) {
      total += item.priceForSelectedSize * item.quantity;
    }
    return total;
  }

  int get cartItemCount {
    int count = 0;
    for (var item in _cart) {
      count += item.quantity;
    }
    return count;
  }

  void addToCart(Coffee coffee) {
    // Check if item with same id AND same selectedSize already in cart
    final index = _cart.indexWhere(
        (item) => item.id == coffee.id && item.selectedSize == coffee.selectedSize);
    if (index >= 0) {
      _cart[index].quantity += 1;
    } else {
      _cart.add(coffee.copyWith(quantity: 1));
    }
    notifyListeners();
  }

  void removeFromCart(String id, {String? size}) {
    if (size != null) {
      _cart.removeWhere((item) => item.id == id && item.selectedSize == size);
    } else {
      _cart.removeWhere((item) => item.id == id);
    }
    notifyListeners();
  }

  void updateQuantity(String id, String size, int delta) {
    final index = _cart.indexWhere(
        (item) => item.id == id && item.selectedSize == size);
    if (index >= 0) {
      _cart[index].quantity += delta;
      if (_cart[index].quantity <= 0) {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }

  void toggleFavorite(String id) {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    notifyListeners();
  }

  bool isFavorite(String id) => _favorites.contains(id);

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void addOrderToHistory(double amount) {
    final now = DateTime.now();
    _orderHistory.insert(0,
        'Order \$${amount.toStringAsFixed(2)} - ${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}');
    notifyListeners();
  }

  Coffee? getItemById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }
}
