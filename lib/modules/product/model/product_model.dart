import 'package:flutter/material.dart';

class ColorModel {
  final int id;
  final String hex;
  final String name;

  ColorModel({required this.id, required this.hex, required this.name});

  Color get color => _hexToColor(hex);

  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    return Color(int.parse('FF${hex}', radix: 16));
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
  final String brand;
  final String description;
  final List<String> sizes;
  final List<ColorModel> colors;
  final List<InventoryItem> inventory;

  ProductModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.brand,
    required this.description,
    required this.sizes,
    required this.colors,
    required this.inventory,
  });

  int getQuantityForSizeAndColor(String size, int colorId) {
    final item = inventory.firstWhere(
      (item) => item.size == size && item.colorId == colorId,
      orElse: () => InventoryItem(size: size, colorId: colorId, quantity: 0),
    );
    return item.quantity;
  }

  int getQuantityForSizeAndColorIndex(int sizeIndex, int colorIndex) {
    if (sizeIndex >= sizes.length || colorIndex >= colors.length) return 0;
    final size = sizes[sizeIndex];
    final colorId = colors[colorIndex].id;
    return getQuantityForSizeAndColor(size, colorId);
  }


}
