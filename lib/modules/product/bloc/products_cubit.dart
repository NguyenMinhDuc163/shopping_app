import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/product/bloc/products_state.dart';
import 'package:shopping_app/modules/product/repo/product_repo.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required this.repo}): super( ProductsInitial()) {
    load();
  }
  final ProductRepo repo;

  Future load() async{
    repo.fetchLoadProducts();
  }
}
