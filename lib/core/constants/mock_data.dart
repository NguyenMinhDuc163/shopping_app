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
    {
      'image': ImagePath.imgMock2,
      'name': 'Trail Running Jacket Nike Windrunner',
      'price': '\$80',
    },
    {'image': ImagePath.imgMock3, 'name': 'Nike Hoodie', 'price': '\$60'},
    {'image': ImagePath.imgMock4, 'name': 'Nike Sweater', 'price': '\$50'},
  ];
}