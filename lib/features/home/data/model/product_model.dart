// product_model.dart (example)
class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String imagePath;
  final String creator;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imagePath,
    required this.creator,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] is num)
          ? (json['price'] as num).toDouble()
          : double.tryParse('${json['price']}') ?? 0.0,
      quantity: (json['quantity'] is int)
          ? json['quantity'] as int
          : int.tryParse('${json['quantity']}') ?? 0,
      imagePath: json['imagePath'] as String? ?? '',
      creator: json['creator'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'imagePath': imagePath,
      "creator": creator,
    };
  }
}
