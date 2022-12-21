import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tely_challenge/VMs/product_vm.dart';
import 'package:tely_challenge/models/product_model.dart';

import '../edit_product_page.dart';

class ProductWidget extends ConsumerWidget {
  const ProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(product.name), Text("${product.price} OMR")],
      ),
      trailing: IconButton(
        onPressed: () => ref.read(productStates.notifier).deleteProduct(product),
        icon: const Icon(Icons.delete, color: Colors.red),
      ),
      subtitle: product.isAvailable
          ? Text("${product.noInStock} pice available in stock")
          : const Text("This product currently not available in stock"),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (_) => EditProductPage(product: product),
        ),
      ),
    );
  }
}
