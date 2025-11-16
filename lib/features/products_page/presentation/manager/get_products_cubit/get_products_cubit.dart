import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/error_handle/app_exception.dart';
import 'package:task/core/utils/git_it.dart';
import 'package:task/features/home/data/model/product_model.dart';
import 'package:task/features/home/data/repo/product_repo/product_repo.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit() : super(GetProductsInitial());

  final ProductRepo _productRepo = getIt<ProductRepo>();

  Future<void> getProducts() async {
    emit(GetProductsLoading());
    final result = await _productRepo.getProducts();
    result.fold(
      (l) {
        emit(GetProductsFailure(exception: l));
      },
      (r) {
        emit(GetProductsSuccess(items: r));
      },
    );
  }
}
