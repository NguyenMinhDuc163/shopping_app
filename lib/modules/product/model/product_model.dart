import 'package:flutter/material.dart';

class ColorModel {
  final int id;
  final String hex;
  final String name;

  ColorModel({required this.id, required this.hex, required this.name});

  Color get color => _hexToColor(hex);

  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }
}

class InventoryItem {
  final String size;
  final int colorId;
  final int quantity;

  InventoryItem({
    required this.size,
    required this.colorId,
    required this.quantity,
  });
}

class ProductModel {
  final String id;
  final String name;
  final String imagePath;
  final double price;
  final double? originalPrice;
  final int? discountPercentage;
  final String brand;
  final String subTitle;
  final String description;
  final List<String> sizes;
  final List<ColorModel> colors;
  final List<InventoryItem> inventory;

  late final Map<String, int> _quantityMap;

  ProductModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.price,
    this.originalPrice,
    this.discountPercentage,
    required this.brand,
    required this.description,
    required this.sizes,
    required this.colors,
    required this.inventory,
    required this.subTitle,
  }) {
    _quantityMap = {};
    for (final item in inventory) {
      final key = "${item.size}_${item.colorId}";
      _quantityMap[key] = item.quantity;
    }
  }

  int getQuantity(int sizeIndex, int colorIndex) {
    if (sizeIndex >= sizes.length || colorIndex >= colors.length) return 0;
    final size = sizes[sizeIndex];
    final colorId = colors[colorIndex].id;

    final key = "${size}_$colorId";
    return _quantityMap[key] ?? 0;
  }
}
