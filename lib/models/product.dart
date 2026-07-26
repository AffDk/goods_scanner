class Product {
  final String? barcode;
  final String? name;
  final String? brand;
  final String? imageUrl;
  final String? category;
  final List<String> ingredientSources;
  final String? manufacturerCountry;
  final String? rawDescription;

  Product({
    this.barcode,
    this.name,
    this.brand,
    this.imageUrl,
    this.category,
    this.ingredientSources = const [],
    this.manufacturerCountry,
    this.rawDescription,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      barcode: json['barcode'] as String?,
      name: json['product_name'] as String?,
      brand: json['brands'] as String?,
      imageUrl: json['image_url'] as String?,
      category: json['categories'] as String?,
      ingredientSources: json['ingredient_sources'] != null
          ? List<String>.from(json['ingredient_sources'] as List)
          : [],
      manufacturerCountry: json['manufacturing_places'] as String?,
      rawDescription: json['raw_description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'barcode': barcode,
        'product_name': name,
        'brands': brand,
        'image_url': imageUrl,
        'categories': category,
        'ingredient_sources': ingredientSources,
        'manufacturing_places': manufacturerCountry,
        'raw_description': rawDescription,
      };

  @override
  String toString() => 'Product(name: $name, brand: $brand, barcode: $barcode)';
}
