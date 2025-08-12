import 'package:shopping_app/core/constants/api_path.dart';
import 'package:shopping_app/data/api_client.dart';
import 'package:shopping_app/data/models/request_method.dart';
import 'package:shopping_app/modules/product/model/product_model_2.dart';

class ProductRepo {
  final ApiClient _apiClient = ApiClient();

  Future fetchLoadProducts() async{
    final res = await _apiClient.fetch(ApiPath.products, RequestMethod.get);
    ProductModel productModel = ProductModel.fromJson(res.json);
    print("Response from ProductRepo: ${productModel}");
  }
}