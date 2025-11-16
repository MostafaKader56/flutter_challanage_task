import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/error_handle/app_exception.dart';

import '../../../../../core/utils/git_it.dart';
import '../../../../home/data/model/product_model.dart';
import '../../../../home/data/repo/product_repo/product_repo.dart';

part 'delete_product_state.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit() : super(DeleteProductInitial());

  final ProductRepo _productRepo = getIt<ProductRepo>();

  Future<void> deleteProduct(ProductModel product) async {
    emit(DeleteProductLoading());
    final result = await _productRepo.deleteProduct(product);
    result.fold(
      (l) {
        emit(DeleteProductFailure(exception: l));
      },
      (r) {
        emit(DeleteProductSuccess());
      },
    );
  }
}
