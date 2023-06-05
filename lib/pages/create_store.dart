import 'package:flutter/material.dart';
import 'package:tungleua/styles/button_style.dart';
import 'package:tungleua/styles/text_form_style.dart';

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

  bool showClearStoreName = false;
  bool showClearContact = false;
  bool showClearLocation = false;

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
                              // TODO: Implement Time Picker
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
                              // TODO: Implement Location picker
                              const Text('Location'),
                              const SizedBox(height: 8),
                              TextFormField(
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

                              // TODO: Implement image picker

                              const Spacer(),

                              // Cancel or Confirm Button
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
                                    // TODO: Implement Create Store
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
                ));
          },
        ),
      ),
    );
  }
}
