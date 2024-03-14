import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product/product_bloc.dart';

class YourSearchInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        onChanged: (value) {
          if (value.length > 3) {
            context.read<ProductBloc>().add(ProductEvent.searchProduct(value));
          }
          if (value.isEmpty) {
            context
                .read<ProductBloc>()
                .add(const ProductEvent.fetchAllFromState());
          }
        },
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
