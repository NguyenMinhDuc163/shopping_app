import 'package:flutter/material.dart';
import 'package:shopping_app/modules/cart/model/product_cart_model.dart';
import 'package:shopping_app/modules/payment/model/credit_card_model.dart';
import 'package:shopping_app/modules/product/model/product_model.dart';
import 'package:shopping_app/modules/reviews/model/review_model.dart';

import '../../init.dart';

class MockData {
  static const List<Map<String, dynamic>> brands = [
    {'icon': IconPath.iconAdidas, 'name': 'Adidas'},
    {'icon': IconPath.iconNike, 'name': 'Nike'},
    {'icon': IconPath.iconFila, 'name': 'Fila'},
    {'icon': IconPath.iconAdidas, 'name': 'Adidas'},
    {'icon': IconPath.iconNike, 'name': 'Nike'},
    {'icon': IconPath.iconFila, 'name': 'Fila'},
  ];

  static const products = [
    {
      'image': ImagePath.imgMock1,
      'name': 'Nike Sportswear Club Fleece',
      'price': '\$99',
    },
    {'image': ImagePath.imgMock2, 'name': '', 'price': ''},
    {'image': ImagePath.imgMock3, 'name': 'Nike Hoodie', 'price': '\$60'},
    {'image': ImagePath.imgMock4, 'name': 'Nike Sweater', 'price': '\$50'},
    {'image': ImagePath.imgMock4, 'name': 'Nike Sweater', 'price': '\$50'},
    {'image': ImagePath.imgMock4, 'name': 'Nike Sweater', 'price': '\$50'},
    {'image': ImagePath.imgMock4, 'name': 'Nike Sweater', 'price': '\$50'},
    {'image': ImagePath.imgMock4, 'name': 'Nike Sweater', 'price': '\$50'},
    {'image': ImagePath.imgMock4, 'name': 'Nike Sweater', 'price': '\$50'},
  ];

  static List<CreditCardModel> cards = [
    CreditCardModel(
      cardHolderFullName: 'Hemendra Mali',
      cardNumber: '5254123412347690',
      validThru: '10/24',
      cardType: 'Visa Classic',
      balance: 3763.87,
      backgroundColor: Colors.orange,
    ),
    CreditCardModel(
      cardHolderFullName: 'Nguyen Van A',
      cardNumber: '4111111111111111',
      validThru: '11/25',
      cardType: 'Visa Gold',
      balance: 1200.50,
      backgroundColor: Colors.blue,
    ),
    CreditCardModel(
      cardHolderFullName: 'Tran Thi B',
      cardNumber: '4000123412345678',
      validThru: '09/26',
      cardType: 'Visa Platinum',
      balance: 980.00,
      backgroundColor: Colors.black,
    ),
  ];

  static List<ProductCartModel> cartProduct = [
    ProductCartModel(
      name: "Men's Tie-Dye T-Shirt\nNike Sportswear",
      imagePath: 'assets/images/img_mock_1.png',
      price: 99,
      tax: 4.0,
    ),
    ProductCartModel(
      name: "Men's Tie-Dye T-Shirt\nNike Sportswear",
      imagePath: 'assets/images/img_mock_2.png',
      price: 45,
      tax: 4.0,
    ),
  ];

  static List<ReviewModel> reviews = [
    ReviewModel(
      name: "Jenny Wilson",
      avatarUrl: "",
      rating: 4.8,
      date: "13 Sep, 2020",
      content:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
    ),
    ReviewModel(
      name: "Jenny Wilson",
      avatarUrl: "",
      rating: 4.8,
      date: "13 Sep, 2020",
      content:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
    ),
    ReviewModel(
      name: "Jenny Wilson",
      avatarUrl: "",
      rating: 4.8,
      date: "13 Sep, 2020",
      content:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
    ),
    ReviewModel(
      name: "Jenny Wilson",
      avatarUrl: "",
      rating: 4.8,
      date: "13 Sep, 2020",
      content:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
    ),
  ];

  static ProductModel get mockProduct => ProductModel(
    id: '1',
    name: 'Nike Sportswear Club Fleece',
    imagePath: ImagePath.productDetail,
    price: 99.0,
    brand: 'Nike',
    description: 'Comfortable and stylish sportswear',
    sizes: ['S', 'M', 'L', 'XL', '2XL'],
    colors: [
      ColorModel(id: 1, hex: '#6786FE', name: 'Blue'),
      ColorModel(id: 2, hex: '#D8D8D8', name: 'Light Gray'),
      ColorModel(id: 3, hex: '#E9D4DD', name: 'Light Pink'),
      ColorModel(id: 4, hex: '#DEDEDE', name: 'Gray'),
      ColorModel(id: 5, hex: '#C2E3CF', name: 'Light Green'),
      ColorModel(id: 6, hex: '#000000', name: 'Black'),
    ],
    inventory: [
      InventoryItem(size: 'S', colorId: 1, quantity: 10),
      InventoryItem(size: 'S', colorId: 2, quantity: 10),
      InventoryItem(size: 'S', colorId: 3, quantity: 10),
      InventoryItem(size: 'S', colorId: 4, quantity: 10),
      InventoryItem(size: 'S', colorId: 5, quantity: 10),
      InventoryItem(size: 'S', colorId: 6, quantity: 10),

      InventoryItem(size: 'M', colorId: 1, quantity: 0),
      InventoryItem(size: 'M', colorId: 2, quantity: 8),
      InventoryItem(size: 'M', colorId: 3, quantity: 0),
      InventoryItem(size: 'M', colorId: 4, quantity: 8),
      InventoryItem(size: 'M', colorId: 5, quantity: 5),
      InventoryItem(size: 'M', colorId: 6, quantity: 8),

      InventoryItem(size: 'L', colorId: 1, quantity: 6),
      InventoryItem(size: 'L', colorId: 2, quantity: 6),
      InventoryItem(size: 'L', colorId: 3, quantity: 6),
      InventoryItem(size: 'L', colorId: 4, quantity: 6),
      InventoryItem(size: 'L', colorId: 5, quantity: 6),
      InventoryItem(size: 'L', colorId: 6, quantity: 6),

      InventoryItem(size: 'XL', colorId: 1, quantity: 4),
      InventoryItem(size: 'XL', colorId: 2, quantity: 4),
      InventoryItem(size: 'XL', colorId: 3, quantity: 4),
      InventoryItem(size: 'XL', colorId: 4, quantity: 4),
      InventoryItem(size: 'XL', colorId: 5, quantity: 4),
      InventoryItem(size: 'XL', colorId: 6, quantity: 4),

      InventoryItem(size: '2XL', colorId: 1, quantity: 0),
      InventoryItem(size: '2XL', colorId: 2, quantity: 2),
      InventoryItem(size: '2XL', colorId: 3, quantity: 2),
      InventoryItem(size: '2XL', colorId: 4, quantity: 2),
      InventoryItem(size: '2XL', colorId: 5, quantity: 2),
      InventoryItem(size: '2XL', colorId: 6, quantity: 2),
    ],
  );
}
