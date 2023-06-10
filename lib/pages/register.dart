import 'package:flutter/material.dart';
import 'package:tungleua/services/api.dart';
import 'package:tungleua/services/auth_service.dart';
import 'package:tungleua/styles/text_form_style.dart';
import 'package:tungleua/widgets/show_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registerFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  bool showClearName = false;
  bool showClearEmail = false;
  bool showClearPassword = false;
  bool showClearConfirmPassword = false;
  bool showClearPhone = false;

  void handleNameChange(value) {
    setState(() {
      showClearName = value.isNotEmpty;
    });
  }

  void handleEmailChange(value) {
    setState(() {
      showClearEmail = value.isNotEmpty;
    });
  }

  void handlePhoneChange(value) {
    setState(() {
      showClearPhone = value.isNotEmpty;
    });
  }

  void handleShowPassword() {
    setState(() {
      if (showClearPassword) {
        showClearPassword = false;
      } else {
        showClearPassword = true;
      }
    });
  }

  void handleShowConfirmPassword() {
    setState(() {
      if (showClearConfirmPassword) {
        showClearConfirmPassword = false;
      } else {
        showClearConfirmPassword = true;
      }
    });
  }

  String? nameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name.';
    }
    return null;
  }

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email.';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Please enter correct email format.';
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    }
    if (value.length < 8) {
      return 'Password should be atleast\n8 characters.';
    }
    return null;
  }

  String? confirmPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    }
    if (value.length < 8) {
      return 'Password should be atleast\n8 characters.';
    }
    if (value != passwordController.text) {
      return 'Your password doesn\'t matched\nwith each other.';
    }
    return null;
  }

  String? phoneValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number.';
    }
    if (!RegExp(r'^0(?!0)\d{1,2}\d{7,8}$').hasMatch(value)) {
      return 'Please enter a valid phone number.';
    }
    return null;
  }

  Future<void> handleRegister() async {
    if (registerFormKey.currentState!.validate()) {
      final name = nameController.text.toLowerCase();
      final email = emailController.text.toLowerCase();
      final password = passwordController.text;
      final phone = phoneController.text;

      final response = await Api().dio.get("/users/exist", data: {
        'name': name,
        'email': email,
        'phone': phone,
      });
      final isFound = response.data['isFound'];

      if (isFound) {
        if (mounted) {
          showCustomSnackBar(
              context, "User is already exist.", SnackBarVariant.error);
        }
        return;
      }

      final credit = await AuthService()
          .registerWithEmailAndPassword(email, password, name, phone);

      // error from firebase auth
      if (credit == null) {
        if (mounted) {
          showCustomSnackBar(
              context, "Firebase Authentication Error", SnackBarVariant.error);
        }
        return;
      }

      if (mounted) {
        showCustomSnackBar(context, "Registered", SnackBarVariant.success);
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Register to get started.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: registerFormKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Name Field
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
                                hintText: 'Name',
                                suffixIcon: showClearName
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            nameController.clear();
                                            showClearName = false;
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

                            // Email Field
                            const Text('Email'),
                            const SizedBox(height: 8),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: emailController,
                              validator: emailValidator,
                              onChanged: handleEmailChange,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(16),
                                hintText: 'your_email@mail.com',
                                suffixIcon: showClearEmail
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            emailController.clear();
                                            showClearEmail = false;
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

                            // Password Field
                            const Text('Password'),
                            const SizedBox(height: 8),
                            TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: passwordController,
                              validator: passwordValidator,
                              autocorrect: false,
                              obscureText: !showClearPassword,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(16),
                                suffixIcon: GestureDetector(
                                    onTap: handleShowPassword,
                                    child: showClearPassword
                                        ? const Icon(Icons.visibility, size: 18)
                                        : const Icon(Icons.visibility_off,
                                            size: 18)),
                                hintText: '*******',
                                border: formBorder,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Confirm Password Field
                            const Text('Confirm Password'),
                            const SizedBox(height: 8),
                            TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: confirmPasswordController,
                              validator: confirmPasswordValidator,
                              autocorrect: false,
                              obscureText: !showClearConfirmPassword,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(16),
                                suffixIcon: GestureDetector(
                                    onTap: handleShowConfirmPassword,
                                    child: showClearConfirmPassword
                                        ? const Icon(Icons.visibility, size: 18)
                                        : const Icon(Icons.visibility_off,
                                            size: 18)),
                                hintText: '*******',
                                border: formBorder,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Phone Field
                            const Text('Phone'),
                            const SizedBox(height: 8),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: phoneController,
                              validator: phoneValidator,
                              onChanged: handlePhoneChange,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(16),
                                hintText: 'Phone',
                                suffixIcon: showClearPhone
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            phoneController.clear();
                                            showClearPhone = false;
                                          });
                                        },
                                        child:
                                            const Icon(Icons.clear, size: 18),
                                      )
                                    : null,
                                border: formBorder,
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Register Button
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 30),
                                width: double.infinity,
                                height: 45,
                                child: FilledButton(
                                    onPressed: handleRegister,
                                    child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text('Register'),
                                          SizedBox(width: 16),
                                          Icon(Icons.arrow_forward_ios,
                                              size: 14)
                                        ]))),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
