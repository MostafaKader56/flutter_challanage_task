import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/error_handle/ui_error_handler.dart';
import 'package:task/core/utils/functions.dart';
import 'package:task/features/home/data/model/product_model.dart';
import 'package:task/features/products_page/presentation/manager/delete_product_cubit/delete_product_cubit.dart';
import 'package:task/features/products_page/presentation/manager/update_product_cubit/update_product_cubit.dart';
import 'package:task/features/products_page/presentation/view/widget/update_product_btm_sheet.dart';

import '../../../../../core/error_handle/error_type.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/get_products_cubit/get_products_cubit.dart';
import 'product_card.dart';

class ProductsPageBody extends StatefulWidget {
  const ProductsPageBody({super.key});

  @override
  State<ProductsPageBody> createState() => _ProductsPageBodyState();
}

class _ProductsPageBodyState extends State<ProductsPageBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetProductsCubit>(context).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateProductCubit, UpdateProductState>(
          listener: (context, state) {
            switch (state) {
              case UpdateProductInitial():
                break;
              case UpdateProductLoading():
                Functions.showLoadingDialog();
                break;
              case UpdateProductSuccess():
                Functions.showSnackBar(S.of(context).done);
                BlocProvider.of<GetProductsCubit>(context).getProducts();
                GoRouter.of(context).pop();
                break;
              case UpdateProductFailure():
                final MapEntry<String, ErrorType>? error =
                    state.exception.errorType.entries.isNotEmpty
                    ? state.exception.errorType.entries.first
                    : null;
                if (error != null) {
                  Functions.showSnackBar(
                    UIErrorHandler.getLocalizedMessage(error.value, context),
                  );
                }
                GoRouter.of(context).pop();
                break;
            }
          },
        ),
        BlocListener<DeleteProductCubit, DeleteProductState>(
          listener: (context, state) {
            switch (state) {
              case DeleteProductInitial():
                break;
              case DeleteProductLoading():
                Functions.showLoadingDialog();
                break;
              case DeleteProductSuccess():
                Functions.showSnackBar(S.of(context).done);
                BlocProvider.of<GetProductsCubit>(context).getProducts();
                GoRouter.of(context).pop();
                break;
              case DeleteProductFailure():
                final MapEntry<String, ErrorType>? error =
                    state.exception.errorType.entries.isNotEmpty
                    ? state.exception.errorType.entries.first
                    : null;
                if (error != null) {
                  Functions.showSnackBar(
                    UIErrorHandler.getLocalizedMessage(error.value, context),
                  );
                }
                GoRouter.of(context).pop();
                break;
            }
          },
        ),
      ],
      child: BlocBuilder<GetProductsCubit, GetProductsState>(
        builder: (context, state) {
          if (state is GetProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetProductsFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text(
                    UIErrorHandler.getLocalizedMessage(
                      state.exception.errorType.entries.first.value,
                      context,
                    ),
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GetProductsCubit>().getProducts();
                    },
                    child: Text(S.of(context).retry),
                  ),
                ],
              ),
            );
          }

          if (state is GetProductsSuccess) {
            if (state.items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      S.of(context).no_products_exist,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<GetProductsCubit>().getProducts();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final product = state.items[index];
                  return ProductCard(
                    product: product,
                    onUpdate: () async {
                      final ProductModel? updatedProduct =
                          await Functions.showCustomBottomSheet(
                            UpdateProductBottomSheet(product: product),
                          );
                      if (updatedProduct != null && context.mounted) {
                        BlocProvider.of<UpdateProductCubit>(
                          context,
                        ).updateProduct(updatedProduct);
                      }
                    },
                    onDelete: () {
                      BlocProvider.of<DeleteProductCubit>(
                        context,
                      ).deleteProduct(product);
                    },
                  );
                },
              ),
            );
          }

          return const Center(child: Text('Initialize products'));
        },
      ),
    );
  }
}
