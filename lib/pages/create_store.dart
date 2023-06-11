import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:tungleua/pages/pick_location.dart';
import 'package:tungleua/services/api.dart';
import 'package:tungleua/styles/button_style.dart';
import 'package:tungleua/styles/text_form_style.dart';
import 'package:tungleua/widgets/rounded_image.dart';
import 'package:tungleua/widgets/show_dialog.dart';

class CreateStore extends StatefulWidget {
  const CreateStore({Key? key}) : super(key: key);

  @override
  State<CreateStore> createState() => _CreateStoreState();
}

class _CreateStoreState extends State<CreateStore> {
  final createStoreFormKey = GlobalKey<FormState>();

  final storeNameControlller = TextEditingController();
  final contactController = TextEditingController(); // WTH is Browser???
  final timeOpenController = TextEditingController();
  final timeCloseController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  final ImagePicker imgPicker = ImagePicker();

  bool showClearStoreName = false;
  bool showClearContact = false;
  bool showClearLocation = false;
  bool showClearDescription = false;
  bool isClickValidate = false;
  bool disableCreate = false;

  List<String>? images = [];

  void handleSetLocation(LatLng position) {
    setState(() {
      // lat, long
      locationController.text = '${position.latitude}, ${position.longitude}';
    });
  }

  Future<void> handleImagePicker() async {
    try {
      final pickedImages = await imgPicker.pickMultiImage();
      if (pickedImages.isEmpty) return;

      if (images!.length + pickedImages.length > 4) {
        if (mounted) {
          showCustomSnackBar(
              context, "Maximum of 4 pictures", SnackBarVariant.error);
        }
        return;
      }

      final List<String> tempArr = [];
      for (var imgFile in pickedImages) {
        final file = File(imgFile.path);
        final imageBytes = await file.readAsBytes();
        tempArr.add(base64Encode(imageBytes));
      }

      setState(() {
        images!.addAll(tempArr);
      });
    } catch (e) {
      debugPrint('Image picker error: $e');
      showCustomSnackBar(
          context, "Error picking images", SnackBarVariant.error);
    }
  }

  void handleRemoveImage(int index) {
    setState(() {
      images!.removeAt(index);
    });
  }

  Future<void> handleOpenTime() async {
    final openTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.inputOnly,
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true,
            ),
            child: child!,
          );
        });
    if (openTime != null) {
      setState(() {
        timeOpenController.text = '${openTime.hour}:${openTime.minute}';
      });
    }
  }

  Future<void> handleCloseTime() async {
    final closeTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.inputOnly,
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true,
            ),
            child: child!,
          );
        });
    if (closeTime != null) {
      setState(() {
        timeCloseController.text = '${closeTime.hour}:${closeTime.minute}';
      });
    }
  }

  void handelStoreNameChange(value) {
    setState(() {
      showClearStoreName = value.isNotEmpty;
    });
  }

  String? storeNameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your store\'s name.';
    }
    return null;
  }

  void handleContactChange(value) {
    setState(() {
      showClearContact = value.isNotEmpty;
    });
  }

  String? contactValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your contact.';
    }
    return null;
  }

  void handleLocationChange(value) {
    setState(() {
      showClearLocation = value.isNotEmpty;
    });
  }

  String? locationValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your location.';
    }
    return null;
  }

  void handleDescriptionChange(value) {
    setState(() {
      showClearDescription = value.isNotEmpty;
    });
  }

  String? descriptionValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your description.';
    }
    return null;
  }

  String? timeOpenValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your\nopening time.';
    }
    return null;
  }

  String? timeCloseValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your\nclosing time.';
    }
    return null;
  }

  Future<void> handleSubmit() async {
    setState(() {
      isClickValidate = true;
    });
    if (createStoreFormKey.currentState!.validate() && images!.isNotEmpty) {
      setState(() {
        disableCreate = true;
      });
      final response = await Api().dio.post('/stores/', data: {
        'user_id': FirebaseAuth.instance.currentUser!.uid,
        'name': storeNameControlller.text,
        'contact': contactController.text,
        'time_open': timeOpenController.text,
        'time_close': timeCloseController.text,
        'latitude': double.parse(locationController.text.split(',')[0].trim()),
        'longitude': double.parse(locationController.text.split(',')[1].trim()),
        'description': descriptionController.text,
        'images': images,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Store'),
      ), // Don't remove AppBar
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Form(
                        key: createStoreFormKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Name Field
                              const Text('Store Name'),
                              const SizedBox(height: 8),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: storeNameControlller,
                                validator: storeNameValidator,
                                onChanged: handelStoreNameChange,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(16),
                                  hintText: 'Store Name',
                                  suffixIcon: showClearStoreName
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              storeNameControlller.clear();
                                              showClearStoreName = false;
                                            });
                                          },
                                          child:
                                              const Icon(Icons.clear, size: 18),
                                        )
                                      : null,
                                  border: formBorder,
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Contact Field
                              const Text('Contact'),
                              const SizedBox(height: 8),
                              TextFormField(
                                keyboardType: TextInputType.url,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: contactController,
                                validator: contactValidator,
                                onChanged: handleContactChange,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(16),
                                  hintText: 'Contact',
                                  suffixIcon: showClearContact
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              contactController.clear();
                                              showClearContact = false;
                                            });
                                          },
                                          child:
                                              const Icon(Icons.clear, size: 18),
                                        )
                                      : null,
                                  border: formBorder,
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Time close and open
                              Row(children: <Widget>[
                                // Time Open
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                      const Text('Open'),
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        validator: timeOpenValidator,
                                        readOnly: true,
                                        controller: timeOpenController,
                                        onTap: handleOpenTime,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(16),
                                          hintText: 'Open',
                                          border: formBorder,
                                        ),
                                      ),
                                    ])),

                                const SizedBox(width: 10),

                                // Time Close
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                      const Text('Close'),
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        validator: timeCloseValidator,
                                        readOnly: true,
                                        controller: timeCloseController,
                                        onTap: handleCloseTime,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(16),
                                          hintText: 'Close',
                                          border: formBorder,
                                        ),
                                      ),
                                    ])),
                              ]),

                              const SizedBox(height: 20),

                              // Location Field
                              const Text('Location'),
                              const SizedBox(height: 8),
                              TextFormField(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PickLocation(
                                              setPosition: handleSetLocation,
                                            ))),
                                readOnly: true,
                                keyboardType: TextInputType.streetAddress,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: locationController,
                                validator: locationValidator,
                                onChanged: handleLocationChange,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(16),
                                  hintText: 'Location',
                                  suffixIcon: showClearLocation
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              locationController.clear();
                                              showClearLocation = false;
                                            });
                                          },
                                          child:
                                              const Icon(Icons.clear, size: 18),
                                        )
                                      : null,
                                  border: formBorder,
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Location Field
                              const Text('Description'),
                              const SizedBox(height: 8),
                              TextFormField(
                                onTap: () {},
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
                                          child:
                                              const Icon(Icons.clear, size: 18),
                                        )
                                      : null,
                                  border: formBorder,
                                ),
                              ),

                              const SizedBox(height: 20),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                          'Upload photos (maximum of 4)'),
                                      const SizedBox(height: 10),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(children: <Widget>[
                                          GestureDetector(
                                              onTap: handleImagePicker,
                                              child: DottedBorder(
                                                  color: isClickValidate &&
                                                          images!.isEmpty
                                                      ? Colors.red
                                                      : Colors.black,
                                                  borderType: BorderType.RRect,
                                                  radius:
                                                      const Radius.circular(20),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: SizedBox.fromSize(
                                                          size: const Size
                                                                  .fromRadius(
                                                              38), // Image radius
                                                          child: Center(
                                                              child: Icon(
                                                            Icons
                                                                .cloud_download,
                                                            color: isClickValidate &&
                                                                    images!
                                                                        .isEmpty
                                                                ? Colors.red
                                                                : Colors.black,
                                                          )))))),
                                          Row(
                                              children: images!
                                                  .asMap()
                                                  .entries
                                                  .map((entry) {
                                            final int index = entry.key;
                                            final Uint8List image =
                                                base64Decode(entry.value);
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: RoundedImage(
                                                image: image,
                                                index: index,
                                                removeImage: handleRemoveImage,
                                              ),
                                            );
                                          }).toList()),
                                        ]),
                                      ),
                                      const SizedBox(height: 10),
                                      isClickValidate && images!.isEmpty
                                          ? const Text(
                                              'Please upload pictures of your Store.',
                                              style:
                                                  TextStyle(color: Colors.red))
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

                                    // Confirm Button
                                    // TODO: Implement Create Store
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 30),
                                      height: 45,
                                      child: FilledButton(
                                          style: filledButton,
                                          onPressed: disableCreate
                                              ? null
                                              : handleSubmit,
                                          child: const Text('Confirm')),
                                    ),
                                  ]),
                            ]),
                      ),
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
