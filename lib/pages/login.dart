import 'package:flutter/material.dart';
import 'package:tungleua/pages/register.dart';
import 'package:tungleua/services/auth_service.dart';
import 'package:tungleua/styles/text_form_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  

  bool isShowPassword = false;
  bool isShowClearIcon = false;

  // TODO: Don't forget to change this
  final logoURL =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWxsMeGWR5TFjpbKK6ajHfuA_JAsJlAxTuxAvN5wni4Q&s';

  void handleEmailChange(value) {
    setState(() {
      isShowClearIcon = value.isNotEmpty;
    });
  }

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Please enter correct email format';
    }
    return null;
  }

  void handleShowPassword() {
    setState(() {
      if (isShowPassword) {
        isShowPassword = false;
      } else {
        isShowPassword = true;
      }
    });
  }

  String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraint) {
              return Form(
                key: loginFormKey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Tung Leua Logo
                              const Center(
                                child: Image(
                                    width: 174,
                                    height: 147,
                                    image: AssetImage(
                                        'assets/images/tungleua_logo.png')),
                              ),

                              const SizedBox(height: 32),

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
                                  suffixIcon: isShowClearIcon
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              emailController.clear();
                                              isShowClearIcon = false;
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
                                obscureText: !isShowPassword,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(16),
                                  suffixIcon: GestureDetector(
                                      onTap: handleShowPassword,
                                      child: isShowPassword
                                          ? const Icon(Icons.visibility,
                                              size: 18)
                                          : const Icon(Icons.visibility_off,
                                              size: 18)),
                                  hintText: '*******',
                                  border: formBorder,
                                ),
                              ),

                              const SizedBox(height: 30),

                              // Login Button
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 30),
                                  width: double.infinity,
                                  height: 45,
                                  child: FilledButton(
                                      onPressed: () {
                                        if (loginFormKey.currentState!
                                            .validate()) {
                                          AuthService()
                                              .signInWithEmailAndPassword(
                                                  emailController.text,
                                                  passwordController.text);
                                        }
                                      },
                                      child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text('Login'),
                                            SizedBox(width: 16),
                                            Icon(Icons.arrow_forward_ios,
                                                size: 14)
                                          ]))),

                              const Spacer(), // https://www.appsloveworld.com/flutter/100/14/how-to-use-spacer-inside-a-column-that-is-wrapped-with-singlechildscrollview

                              // Don't have an account?
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text('You don\'t have an account ? ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14)),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const RegisterPage()));
                                        },
                                        child: const Text('Sign up',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            )))
                                  ]),
                            ]),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}