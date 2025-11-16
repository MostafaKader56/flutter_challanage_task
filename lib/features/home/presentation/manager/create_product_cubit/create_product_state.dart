part of 'create_product_cubit.dart';

@immutable
sealed class CreateProductState {}

final class CreateProductInitial extends CreateProductState {}

final class CreateProductLoading extends CreateProductState {}

final class CreateProductFailure extends CreateProductState {
  final AppException exception;

  CreateProductFailure({required this.exception});
}

final class CreateProductSuccess extends CreateProductState {}
