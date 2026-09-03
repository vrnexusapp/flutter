import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_demo/features/products/data/models/product_model.dart';

void main() {
  group('ProductModel Tests', () {
    test('Product should serialize/deserialize correctly', () {
      final json = {
        'id': 1,
        'title': 'Test Product',
        'description': 'A product for testing',
        'price': 9.99,
        'discountPercentage': 10.0,
        'rating': 4.5,
        'stock': 100,
        'brand': 'TestBrand',
        'category': 'Tests',
        'thumbnail': 'https://example.com/thumb.jpg',
        'images': ['https://example.com/img1.jpg'],
      };

      final product = Product.fromJson(json);

      expect(product.id, 1);
      expect(product.title, 'Test Product');
      expect(product.price, 9.99);

      final convertedJson = product.toJson();
      expect(convertedJson['id'], 1);
      expect(convertedJson['title'], 'Test Product');
    });
  });
}
