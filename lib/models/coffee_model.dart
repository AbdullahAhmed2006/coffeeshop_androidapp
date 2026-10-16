class Coffee {
  final String id;
  final String name;
  final String type; // e.g., "With Oat Milk", "With Chocolate"
  final double price;
  final String image;
  final double rating;
  final int reviews;
  final String description;
  final String roasted; // e.g., "Medium Roasted"
  final List<String> sizes;
  final String category; // 'coffee' or 'bean'
  final String origin; // e.g., "From Africa" (for beans)
  final Map<String, double> sizePrices; // price per size
  int quantity;
  String selectedSize;

  Coffee({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.roasted,
    this.sizes = const ['S', 'M', 'L'],
    this.category = 'coffee',
    this.origin = '',
    this.sizePrices = const {},
    this.quantity = 1,
    this.selectedSize = 'S',
  });

  bool get isCoffee => category == 'coffee';
  bool get isBean => category == 'bean';

  double get priceForSelectedSize {
    if (sizePrices.containsKey(selectedSize)) {
      return sizePrices[selectedSize]!;
    }
    return price;
  }

  Coffee copyWith({
    String? id,
    String? name,
    String? type,
    double? price,
    String? image,
    double? rating,
    int? reviews,
    String? description,
    String? roasted,
    List<String>? sizes,
    String? category,
    String? origin,
    Map<String, double>? sizePrices,
    int? quantity,
    String? selectedSize,
  }) {
    return Coffee(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      description: description ?? this.description,
      roasted: roasted ?? this.roasted,
      sizes: sizes ?? this.sizes,
      category: category ?? this.category,
      origin: origin ?? this.origin,
      sizePrices: sizePrices ?? this.sizePrices,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }
}
