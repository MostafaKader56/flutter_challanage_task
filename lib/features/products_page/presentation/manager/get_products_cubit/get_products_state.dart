part of 'get_products_cubit.dart';

@immutable
sealed class GetProductsState {}

final class GetProductsInitial extends GetProductsState {}

final class GetProductsLoading extends GetProductsState {}

final class GetProductsFailure extends GetProductsState {
  final AppException exception;

  GetProductsFailure({required this.exception});
}

final class GetProductsSuccess extends GetProductsState {
  final List<ProductModel> items;

  GetProductsSuccess({required this.items});
}
