import 'package:esl/core/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EslPaymentPage extends StatefulWidget {
  const EslPaymentPage({super.key});

  @override
  State<EslPaymentPage> createState() => _EslPaymentPageState();
}

class _EslPaymentPageState extends State<EslPaymentPage> {
  String _selectedPaymentMethod = 'telebirr';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Logo in the header
          Container(
            color: AppConstants.eslGreyText,
            width: double.infinity,
            height: 150,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16,),
                  child: Image.asset(
                    AppConstants.engHorizontalFullColor,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          // White content area starting lower down
          Container(
            margin: const EdgeInsets.only(top: 150),
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _buildPhoneNumberInput(),
                  const SizedBox(height: 24),
                  _buildPaymentMethodSelector(),
                  const SizedBox(height: 48),
                  _buildMakePaymentButton(),
                ],
              ),
            ),
          ),
          // Amount card positioned to overlap
          Positioned(
            top: 100,
            left: 24,
            right: 24,
            child: _buildAmountCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Amount to pay',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '1,875.00 USD',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberInput() {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppConstants.eslGreyTint),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppConstants.eslGreyTint),
        ),
      ),
      keyboardType: TextInputType.phone,
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Column(
      children: [
        _buildPaymentOption(
          icon: 'assets/koket.png', // Placeholder
          text: 'Commercial Bank of Ethiopia',
          value: 'cbe',
        ),
        const SizedBox(height: 16),
        _buildPaymentOption(
          icon: 'assets/logo.png', // Placeholder
          text: 'Tele Birr',
          value: 'telebirr',
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
      {required String icon, required String text, required String value}) {
    final isSelected = _selectedPaymentMethod == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xff0E6F45).withOpacity(0.1)
              : AppConstants.eslGreyTint,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xff0E6F45) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Image.asset(icon, height: 30, width: 30),
            const SizedBox(width: 16),
            Text(text,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildMakePaymentButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          GoRouter.of(context).push(AppConstants.paymentReceiptRoute);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff0E6F45),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Make Payment',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
