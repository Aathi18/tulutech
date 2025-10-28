class Product {
  final int id;
  final String title;
  final double price;
  final double rating;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.thumbnail,
  });

  // Factory constructor to create a Product from a JSON map (API response)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      thumbnail: json['thumbnail'] as String,
    );
  }

  // Convert Product to JSON map (needed for Cart persistence)
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'rating': rating,
    'thumbnail': thumbnail,
  };
}