import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tely_challenge/models/product_model.dart';

import '../services/product_service.dart';

final productStates = StateNotifierProvider<ProductState, List<Product>>((ref) => ProductState(ref));

class ProductState extends StateNotifier<List<Product>> {
  final Ref ref;
  ProductState(this.ref) : super([]);

  /// Get list of products
  /// products will be saved in the state
  Future<void> get init async {
    try {
      if (state.isNotEmpty) return;

      final json = await ProductService.getProducts();
      for (final Map product in json) {
        try {
          state.add(Product.fromJSON(product));
        } catch (e) {
          debugPrint("$e");
          continue;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  void deleteProduct(Product prod) => state = state.where((p) => p.id != prod.id).toList();

  void updateProduct(Product prod) => state = state.map((p) => p.id == prod.id ? prod : p).toList();

  int get availableInStack {
    if (state.isEmpty) return 0;
    int available = 0;
    for (var p in state) {
      if (p.isAvailable) available++;
    }
    return available;
  }

  int get notAvailableInStack {
    if (state.isEmpty) return 0;
    int notAvailable = 0;
    for (var p in state) {
      if (!p.isAvailable) notAvailable++;
    }
    return notAvailable;
  }

  double get averagePrice {
    if (state.isEmpty) return 0;
    double average = 0;
    for (var p in state) {
      average += p.price;
    }
    return average / state.length;
  }
}
