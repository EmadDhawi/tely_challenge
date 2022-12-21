class Product {
  final int id;
  final String name;
  final double price;
  final bool isAvailable;

  /// numbers of items available in stock
  final int noInStock;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.noInStock,
    required this.isAvailable,
  });

  /// Create new ProductModel object from Map | json format.
  /// This function throw an exception if the data not available or data type not match.
  factory Product.fromJSON(Map json) {
    try {
      return Product(
        id: json["id"] as int,
        name: json["name"] as String,
        price: (json["price"] as num).toDouble(),
        noInStock: json["noInStock"] as int,
        isAvailable: json["isAvailable"] as bool,
      );
    } catch (e) {
      throw "Error on creating product | $e";
    }
  }

  Product copyWith({String? name, double? price, int? noInStock, bool? isAvailable}) => Product(
        id: id,
        name: name ?? this.name,
        price: price ?? this.price,
        noInStock: noInStock ?? this.noInStock,
        isAvailable: isAvailable ?? this.isAvailable,
      );
}
