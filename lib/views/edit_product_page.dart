import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tely_challenge/VMs/product_vm.dart';
import 'package:tely_challenge/models/product_model.dart';

class EditProductPage extends ConsumerStatefulWidget {
  const EditProductPage({super.key, required this.product});
  final Product product;

  @override
  EditProductState createState() => EditProductState();
}

class EditProductState extends ConsumerState<EditProductPage> {
  late final TextEditingController nameController;
  late final TextEditingController priceController;
  late final TextEditingController noInStockController;
  late bool isAvailable;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    nameController.text = widget.product.name;

    priceController = TextEditingController();
    priceController.text = widget.product.price.toString();

    noInStockController = TextEditingController();
    noInStockController.text = widget.product.noInStock.toString();

    isAvailable = widget.product.isAvailable;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit ${widget.product.name}"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // name
            const Text("Product name"),
            TextField(controller: nameController),
            const SizedBox(height: 10),

            // price
            const Text("Product price"),
            TextField(controller: priceController, keyboardType: TextInputType.number),
            const SizedBox(height: 10),

            // number in stock
            const Text("Number in stock"),
            TextField(controller: noInStockController, keyboardType: TextInputType.number),
            const SizedBox(height: 10),

            // is product available
            const Text("Is product available in stock?"),
            Checkbox(value: isAvailable, onChanged: (v) => setState(() => isAvailable = v ?? isAvailable)),
            const SizedBox(height: 10),

            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  child: const Text("Update product"),
                  onPressed: () => updateProduct(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateProduct() {
    final updateProduct = widget.product.copyWith(
      name: nameController.text.trim(),
      price: double.parse(priceController.text.trim()),
      noInStock: int.parse(noInStockController.text.trim()),
      isAvailable: isAvailable,
    );
    ref.read(productStates.notifier).updateProduct(updateProduct);
    Navigator.pop(context);
  }
}
