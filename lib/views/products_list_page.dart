import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tely_challenge/views/widgets/loading_widget.dart';

import '../VMs/product_vm.dart';
import 'widgets/product_widget.dart';
import 'widgets/products_search_widget.dart';

class ProductsListPage extends ConsumerStatefulWidget {
  const ProductsListPage({super.key});

  @override
  ProductsListState createState() => ProductsListState();
}

class ProductsListState extends ConsumerState<ProductsListPage> {
  bool loading = false;

  @override
  void initState() {
    super.initState();

    // Get the products
    intiProducts;
  }

  Future<void> get intiProducts async {
    setState(() => loading = true);
    await ref.read(productStates.notifier).init;
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productStates);
    final prodState = ref.read(productStates.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products List"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductsSearchWidget(),
              );
            },
          ),
        ],
      ),
      body: loading
          ? const LoadingWidget()
          : products.isEmpty
              ? const Center(child: Text("currently there are not products in the stock"))
              : SingleChildScrollView(
                  primary: false,
                  child: Column(
                    children: [
                      // display statics
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${products.length} products available",
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${prodState.availableInStack} in stack",
                                  style: const TextStyle(color: Colors.green),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${prodState.notAvailableInStack} currently not available in stack",
                                  style: const TextStyle(color: Colors.red),
                                ),
                                const Divider(),
                                const SizedBox(height: 5),
                                Text(
                                  "The average price is ${prodState.averagePrice.toStringAsFixed(2)} OMR",
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // display products list
                      for (final p in products) ProductWidget(product: p),
                    ],
                  ),
                ),
    );
  }
}
