import 'package:flutter/material.dart';
import 'package:tungleua/styles/button_style.dart';
import 'package:tungleua/styles/text_form_style.dart';

class DepositForm extends StatefulWidget {
  const DepositForm({Key? key}) : super(key: key);

  @override
  State<DepositForm> createState() => _DepositFormState();
}

class _DepositFormState extends State<DepositForm> {
  final depositFormKey = GlobalKey<FormState>();
  final amountController = TextEditingController();

  Future<void> handleConfirmDeposit() async {
    if (depositFormKey.currentState!.validate()) {}
  }

  String? amountValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the amount of money.';
    }
    if (!RegExp(r'^[1-9]\d*$').hasMatch(value)) {
      return 'Please enter a\nnon-zero number.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: depositFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Enter amount',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: amountController,
                  validator: amountValidator,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    hintText: 'Enter Balance',
                    border: formBorder,
                  ),
                ),
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
                            onPressed: handleConfirmDeposit,
                            child: const Text('Confirm')),
                      ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
