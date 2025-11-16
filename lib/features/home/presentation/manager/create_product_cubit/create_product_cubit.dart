import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/error_handle/app_exception.dart';
import 'package:task/features/home/data/model/product_model.dart';
import 'package:task/features/home/data/repo/product_repo/product_repo.dart';

import '../../../../../core/utils/git_it.dart';

part 'create_product_state.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  CreateProductCubit() : super(CreateProductInitial());
  final ProductRepo _productRepo = getIt<ProductRepo>();

  Future<void> createProduct(ProductModel product) async {
    emit(CreateProductLoading());
    final result = await _productRepo.createProduct(product);
    result.fold(
      (left) {
        emit(CreateProductFailure(exception: left));
      },
      (right) {
        emit(CreateProductSuccess());
      },
    );
  }
}
