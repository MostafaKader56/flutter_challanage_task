import 'package:flutter/material.dart';

import 'widget/products_page_body.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: ProductsPageBody()));
  }
}
