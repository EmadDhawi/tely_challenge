import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tely_challenge/VMs/product_vm.dart';
import 'package:tely_challenge/views/widgets/product_widget.dart';

class ProductsSearchWidget extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _listOfProductWidget;

  @override
  Widget buildSuggestions(BuildContext context) => _listOfProductWidget;

  Widget get _listOfProductWidget {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final products = ref.watch(productStates);

        if (query == "") return ListView(children: products.map((p) => ProductWidget(product: p)).toList());

        return ListView(
          children: products
              .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
              .map((p) => ProductWidget(product: p))
              .toList(),
        );
      },
    );
  }
}
