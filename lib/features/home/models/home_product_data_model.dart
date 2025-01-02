class ProductDataModel {
  String? id;
  String? name;
  String? description;
  int? quantity;
  double? price;
  String? imageUrl;
  bool? isFavorite;

  ProductDataModel({
    this.id,
    this.name,
    this.description,
    this.quantity,
    this.price,
    this.isFavorite,
    this.imageUrl,
  });

  // Increment quantity
  void incrementQuantity() {
    quantity = (quantity ?? 0) + 1;
  }

  // Decrement quantity
  void decrementQuantity() {
    quantity = (quantity ?? 0) - 1;
  }

  // Set a specific quantity
  void setQuantity(int newQuantity) {
    quantity = newQuantity;
  }

  // Get the current quantity
  int? getQuantity() {
    return quantity;
  }

  // Factory constructor for deserializing JSON to ProductDataModel
  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      price: (json['price'] as num?)?.toDouble(), // Handle both int and double
      imageUrl: json['imageUrl'],
      isFavorite: json['isFavorite'] ?? false, // Default to false if null
    );
  }

  // Method for serializing ProductDataModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }
}
