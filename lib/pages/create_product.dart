import 'package:flutter/material.dart';
import 'package:tungleua/styles/button_style.dart';
import 'package:tungleua/styles/text_form_style.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({Key? key}) : super(key: key);

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final createProductFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final detailController = TextEditingController();
  final priceController = TextEditingController();

  bool showClearName = false;
  bool showClearDetail = false;

  String? nameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter product name.';
    }
    return null;
  }

  void handleNameChange(value) {
    setState(() {
      showClearName = value.isNotEmpty;
    });
  }

  String? detailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter product detail.';
    }
    return null;
  }

  void handleDetailChange(value) {
    setState(() {
      showClearDetail = value.isNotEmpty;
    });
  }

  String? priceValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter product price.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Product'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: createProductFormKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),

                    // Product Name
                    const Text('Name'),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: nameController,
                      validator: nameValidator,
                      onChanged: handleNameChange,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16),
                        hintText: 'Product Name',
                        suffixIcon: showClearName
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    nameController.clear();
                                    showClearName = false;
                                  });
                                },
                                child: const Icon(Icons.clear, size: 18),
                              )
                            : null,
                        border: formBorder,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Product Detail
                    const Text('Detail'),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: detailController,
                      validator: detailValidator,
                      onChanged: handleDetailChange,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16),
                        hintText: 'Product Detail',
                        suffixIcon: showClearDetail
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    detailController.clear();
                                    showClearDetail = false;
                                  });
                                },
                                child: const Icon(Icons.clear, size: 18),
                              )
                            : null,
                        border: formBorder,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Product Price
                    const Text('Price'),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: priceController,
                        validator: priceValidator,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(16),
                          hintText: 'Product Price',
                          border: formBorder,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // TODO: Implement Image Picker

                    const Spacer(),

                    // Confirm or Cancel Button
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Cancel Button
                          // TODO: pop navigation stack
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 30),
                            height: 45,
                            child: OutlinedButton(
                                style: roundedOutlineButton,
                                onPressed: () {},
                                child: const Text('Cancel')),
                          ),

                          const SizedBox(width: 10),

                          // Confirm Button
                          // TODO: Implement Create Product
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 30),
                            height: 45,
                            child: FilledButton(
                                style: filledButton,
                                onPressed: () {},
                                child: const Text('Confirm')),
                          ),
                        ]),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
