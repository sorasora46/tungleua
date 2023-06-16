import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tungleua/models/product.dart';
import 'package:tungleua/services/product_service.dart';
import 'package:tungleua/styles/button_style.dart';
import 'package:tungleua/styles/text_form_style.dart';
import 'package:tungleua/widgets/rounded_image.dart';
import 'package:tungleua/widgets/show_dialog.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final editProductFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final amountController = TextEditingController();

  final ImagePicker imgPicker = ImagePicker();

  bool showClearName = false;
  bool showClearDescription = false;
  bool isEditable = false;
  bool isClickValidate = false;

  Product? product;
  String? imageBytes;
  File? image;

  void handleNameChange(value) {
    setState(() {
      showClearName = value.isNotEmpty;
    });
  }

  void handleDescriptionChange(value) {
    setState(() {
      showClearDescription = value.isNotEmpty;
    });
  }

  String? nameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your product name.';
    }
    return null;
  }

  String? descriptionValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your product description.';
    }
    return null;
  }

  String? priceValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter product price.';
    }
    if (!RegExp(r'^[1-9]\d*$').hasMatch(value)) {
      return 'Please enter a\nnon-zero number.';
    }
    return null;
  }

  String? amountValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter\nproduct amount.';
    }
    if (!RegExp(r'^[1-9]\d*$').hasMatch(value)) {
      return 'Please enter a\nnon-zero number.';
    }
    return null;
  }

  void handleEditable() {
    setState(() {
      if (isEditable) {
        isEditable = false;
      } else {
        isEditable = true;
      }
    });
  }

  Future<void> handleImagePicker() async {
    try {
      final image = await imgPicker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final file = File(image.path);
      final bytes = await file.readAsBytes();
      setState(() {
        this.image = file;
        imageBytes = base64Encode(bytes);
      });
    } catch (e) {
      debugPrint('Image picker error: $e');
      showCustomSnackBar(context, "Error picking image", SnackBarVariant.error);
    }
  }

  void handleRemoveImage() {
    setState(() {
      image = null;
      imageBytes = null;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ProductService()
        .getProductById(widget.productId)
        .then((product) => setState(() {
              this.product = product;
              nameController.text = product!.title;
              descriptionController.text = product.description;
              priceController.text = product.price.toString();
              amountController.text = product.amount.toString();
              imageBytes = product.image;
            }));
  }

  Future<void> handleSave() async {
    setState(() {
      isClickValidate = true;
    });

    if (editProductFormKey.currentState!.validate() && imageBytes != null) {
      showCustomSnackBar(
          context, "Updating your Product . . .", SnackBarVariant.info);

      setState(() {
        isEditable = false;
      });

      final Map<String, dynamic> updates = {
        'title': nameController.text,
        'description': descriptionController.text,
        'price': int.parse(priceController.text),
        'image': imageBytes!,
      };

      final isSuccess =
          await ProductService().updateProductById(product!.id, updates);

      if (isSuccess) {
        if (mounted) {
          showCustomSnackBar(
              context, "Update success!", SnackBarVariant.success);
        }
      } else {
        if (mounted) {
          showCustomSnackBar(context, "Update failed!", SnackBarVariant.error);
        }
      }
    }
  }

  Future<void> handleDelete() async {
    if (product?.id != null) {
      final isSuccess = await ProductService().deleteProductById(product!.id);
      if (isSuccess) {
        if (mounted) {
          showCustomSnackBar(
              context, "Delete success!", SnackBarVariant.success);
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          showCustomSnackBar(context, "Delete failed!", SnackBarVariant.error);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Product'),
          actions: <Widget>[
            IconButton(
              onPressed: handleEditable,
              icon: Icon(isEditable ? Icons.edit_off : Icons.edit),
            )
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Form(
                          key: editProductFormKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Product Name Field
                                const Text('Product Name'),
                                const SizedBox(height: 8),
                                TextFormField(
                                  enabled: isEditable,
                                  keyboardType: TextInputType.name,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                            child: const Icon(Icons.clear,
                                                size: 18),
                                          )
                                        : null,
                                    border: formBorder,
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Product Detail Field
                                const Text('Product Description'),
                                const SizedBox(height: 8),
                                TextFormField(
                                  enabled: isEditable,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: descriptionController,
                                  validator: descriptionValidator,
                                  onChanged: handleDescriptionChange,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(16),
                                    hintText: 'Description',
                                    suffixIcon: showClearDescription
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                descriptionController.clear();
                                                showClearDescription = false;
                                              });
                                            },
                                            child: const Icon(Icons.clear,
                                                size: 18),
                                          )
                                        : null,
                                    border: formBorder,
                                  ),
                                ),

                                const SizedBox(height: 20),

                                Row(children: <Widget>[
                                  // Product Price
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text('Price'),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: TextFormField(
                                                enabled: isEditable,
                                                keyboardType:
                                                    TextInputType.text,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                controller: priceController,
                                                validator: priceValidator,
                                                decoration: InputDecoration(
                                                    suffixIcon:
                                                        const Icon(Icons.sell),
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    hintText: 'Product Price',
                                                    border: formBorder)))
                                      ]),

                                  const SizedBox(width: 10),

                                  // Product Amount
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                        const Text('Amount'),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: TextFormField(
                                                enabled: isEditable,
                                                keyboardType:
                                                    TextInputType.text,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                controller: amountController,
                                                validator: amountValidator,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    hintText: 'Amount',
                                                    border: formBorder)))
                                      ])),
                                ]),

                                const SizedBox(height: 20),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                            'Upload a photo of your Product'),
                                        const SizedBox(height: 10),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(children: <Widget>[
                                            GestureDetector(
                                                onTap: isEditable
                                                    ? handleImagePicker
                                                    : null,
                                                child: DottedBorder(
                                                    color: isClickValidate &&
                                                            imageBytes == null
                                                        ? Colors.red
                                                        : Colors.black,
                                                    borderType:
                                                        BorderType.RRect,
                                                    radius:
                                                        const Radius.circular(
                                                            20),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child:
                                                            SizedBox.fromSize(
                                                                size: const Size
                                                                        .fromRadius(
                                                                    38), // Image radius
                                                                child: Center(
                                                                    child: Icon(
                                                                  Icons
                                                                      .cloud_download,
                                                                  color: isClickValidate &&
                                                                          imageBytes ==
                                                                              null
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .black,
                                                                )))))),
                                            if (imageBytes != null)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: RoundedImage(
                                                      image: base64Decode(
                                                          imageBytes!),
                                                      removeImage: isEditable
                                                          ? handleRemoveImage
                                                          : null))
                                          ]),
                                        ),
                                        const SizedBox(height: 10),
                                        isClickValidate && imageBytes == null
                                            ? const Text(
                                                'Please upload a picture of your Store.',
                                                style: TextStyle(
                                                    color: Colors.red))
                                            : Container(),
                                      ]),
                                ),

                                const Spacer(),

                                // Cancel or Confirm Button
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      // Cancel Button
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 30),
                                        height: 45,
                                        child: OutlinedButton(
                                            style: roundedOutlineButton,
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Cancel')),
                                      ),

                                      const SizedBox(width: 10),

                                      // Delete Button
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 30),
                                        height: 45,
                                        child: FilledButton(
                                            style: const ButtonStyle(
                                                foregroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.white),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.red)),
                                            onPressed: handleDelete,
                                            child: const Text('Delete')),
                                      ),

                                      const SizedBox(width: 10),

                                      // Save Button
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 30),
                                        height: 45,
                                        child: FilledButton(
                                            style: filledButton,
                                            onPressed:
                                                isEditable ? handleSave : null,
                                            child: const Text('Save')),
                                      ),
                                    ]),
                              ]),
                        ),
                      ),
                    ),
                  ));
            },
          ),
        ));
  }
}
