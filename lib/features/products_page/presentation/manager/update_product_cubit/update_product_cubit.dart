import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/error_handle/app_exception.dart';
import 'package:task/features/home/data/model/product_model.dart';
import 'package:task/features/home/data/repo/product_repo/product_repo.dart';

import '../../../../../core/utils/git_it.dart';

part 'update_product_state.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {
  UpdateProductCubit() : super(UpdateProductInitial());

  final ProductRepo _productRepo = getIt<ProductRepo>();

  Future<void> updateProduct(ProductModel product) async {
    emit(UpdateProductLoading());
    final result = await _productRepo.updateProduct(product);
    result.fold(
      (l) {
        emit(UpdateProductFailure(exception: l));
      },
      (r) {
        emit(UpdateProductSuccess());
      },
    );
  }
}
