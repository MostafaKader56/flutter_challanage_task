part of 'update_product_cubit.dart';

@immutable
sealed class UpdateProductState {}

final class UpdateProductInitial extends UpdateProductState {}

final class UpdateProductLoading extends UpdateProductState {}

final class UpdateProductFailure extends UpdateProductState {
  final AppException exception;

  UpdateProductFailure({required this.exception});
}

final class UpdateProductSuccess extends UpdateProductState {}
