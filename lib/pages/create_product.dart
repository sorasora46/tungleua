import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tungleua/services/api.dart';
import 'package:tungleua/styles/button_style.dart';
import 'package:tungleua/styles/text_form_style.dart';
import 'package:tungleua/widgets/rounded_image.dart';
import 'package:tungleua/widgets/show_dialog.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({Key? key, required this.storeId}) : super(key: key);
  final String storeId;

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final createProductFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final detailController = TextEditingController();
  final priceController = TextEditingController();
  final amountController = TextEditingController();

  final ImagePicker imgPicker = ImagePicker();

  bool showClearName = false;
  bool showClearDetail = false;
  bool isClickValidate = false;
  bool disableCreate = false;

  Uint8List? imageBytes;
  File? image;

  Future<void> handleImagePicker() async {
    try {
      final image = await imgPicker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final file = File(image.path);
      final fileBytes = await file.readAsBytes();
      setState(() {
        this.image = file;
        imageBytes = fileBytes;
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

  Future<void> handleSubmit() async {
    setState(() {
      isClickValidate = true;
    });
    if (createProductFormKey.currentState!.validate() && imageBytes != null) {
      setState(() {
        disableCreate = true;
      });
      final response = await Api().dio.post('/products/', data: {
        'title': nameController.text,
        'description': detailController.text,
        'price': int.parse(priceController.text),
        'store_id': widget.storeId,
        'image': base64Encode(imageBytes!),
        'amount': int.parse(amountController.text),
      });

      if (response.statusCode == 200) {
        if (mounted) {
          Navigator.pop(context, true); // return true if create success
        }
      } else {
        if (mounted) {
          showCustomSnackBar(
              context, "Error Creating Store", SnackBarVariant.error);
        }
      }
    } else {
      setState(() {
        disableCreate = false;
      });
    }
  }

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
        body: SafeArea(child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
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
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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

                          Row(children: <Widget>[
                            // Product Price
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text('Price'),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          controller: priceController,
                                          validator: priceValidator,
                                          decoration: InputDecoration(
                                              suffixIcon:
                                                  const Icon(Icons.sell),
                                              contentPadding:
                                                  const EdgeInsets.all(16),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          controller: amountController,
                                          validator: amountValidator,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(16),
                                              hintText: 'Amount',
                                              border: formBorder)))
                                ])),
                          ]),

                          const SizedBox(height: 20),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text('Upload photo of your Product'),
                                  const SizedBox(height: 10),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(children: <Widget>[
                                      GestureDetector(
                                          onTap: handleImagePicker,
                                          child: DottedBorder(
                                              color: isClickValidate &&
                                                      image == null
                                                  ? Colors.red
                                                  : Colors.black,
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(20),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: SizedBox.fromSize(
                                                      size: const Size
                                                              .fromRadius(
                                                          38), // Image radius
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.cloud_download,
                                                        color:
                                                            isClickValidate &&
                                                                    image ==
                                                                        null
                                                                ? Colors.red
                                                                : Colors.black,
                                                      )))))),
                                      if (imageBytes != null)
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: RoundedImage(
                                                image: imageBytes!,
                                                removeImage: handleRemoveImage))
                                    ]),
                                  ),
                                  const SizedBox(height: 10),
                                  isClickValidate && image == null
                                      ? const Text(
                                          'Please upload picture of your Product.',
                                          style: TextStyle(color: Colors.red))
                                      : Container(),
                                ]),
                          ),

                          const Spacer(),

                          // Confirm or Cancel Button
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
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel')),
                                ),

                                const SizedBox(width: 10),

                                // Confirm Button
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 30),
                                  height: 45,
                                  child: FilledButton(
                                      style: filledButton,
                                      onPressed:
                                          disableCreate ? null : handleSubmit,
                                      child: const Text('Confirm')),
                                ),
                              ]),
                        ]),
                  ),
                ),
              ),
            ),
          );
        })),
      ),
    );
  }
}
