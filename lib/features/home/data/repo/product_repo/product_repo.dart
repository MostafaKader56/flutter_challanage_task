import 'package:dartz/dartz.dart';
import 'package:task/core/error_handle/app_exception.dart';
import 'package:task/features/home/data/model/product_model.dart';

abstract class ProductRepo {
  Future<Either<AppException, ProductModel>> createProduct(
    ProductModel product,
  );
  Future<Either<AppException, List<ProductModel>>> getProducts();
  Future<Either<AppException, void>> updateProduct(ProductModel product);
  Future<Either<AppException, void>> deleteProduct(ProductModel product);
}
