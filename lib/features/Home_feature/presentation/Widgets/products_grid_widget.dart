import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/product_item_widget.dart';
import 'package:flutter/material.dart';

class ProductsGridWidget extends StatefulWidget {
  final List<ProductModel> products;

  const ProductsGridWidget({Key? key, required this.products})
      : super(key: key);

  @override
  State<ProductsGridWidget> createState() => _ProductsGridWidgetState();
}

class _ProductsGridWidgetState extends State<ProductsGridWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.25),
        crossAxisSpacing: getWidgetWidth(8),
        mainAxisSpacing: getWidgetHeight(16),
      ),
      scrollDirection: Axis.vertical,
      itemBuilder: (itemCtx, itemPos) {
        return ProductItemWidget(
          model: widget.products[itemPos],
        );
      },
      itemCount: widget.products.length,
    );
  }
}
