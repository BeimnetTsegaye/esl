import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/widgets/table_with_yellow_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class TuitionPage extends StatefulWidget {
  const TuitionPage({super.key});

  @override
  State<TuitionPage> createState() => _TuitionPageState();
}

class _TuitionPageState extends State<TuitionPage> {
  Map<String, List<String>> tuitionData = {
    'Program': [
      'Marine Engineering',
      'Logistics and Supply Chain Management',
      'Seafarer Training',
      'Shipping and Logistics Management',
      'Marine Engineering Technology',
    ],
    'Duration': ['4 years', '4 years', '6 months', '1 year', '2 years'],
    'Tuition per Year (USD)': [
      '\$2,500',
      '\$2,000',
      '\$1,500',
      '\$1,800',
      '\$2,200',
    ],
    'Total Tuition (USD)': [
      '\$10,000',
      '\$8,000',
      '\$1,500',
      '\$1,800',
      '\$4,400',
    ],
  };
  Map<String, String> invoiceData = {
    'Invoice Number': 'BMLA-2025-0013',
    'Date Issued': 'May 22, 2025',
    'Due Date': 'May 22, 2025',
    'Student Name': 'Amanuel Teshome',
    'Student ID': 'BMLA2025-1034',
    'Program Enrolled': 'Marine Engineering',
    'Enrollment Term': '2025/2026-Semester I',
  };

  List<String> otherFeeInfo = [
    'Registration Fee (One-time): \$150',
    'Library & Technology Access: \$100/year',
    'Uniform & Safety Kit (First Year): \$250',
    'Graduation Fee (Final Year): \$200',
  ];

  Map<String, String> feeBreakDown = {
    'Tuition Fee': '\$1500.00',
    'Registration Fee': '\$150.00',
    'Library & IT Access': '\$100.00',
    'ID Card & Admin Processing': '\$50.00',
    'Health & Safety Service': '\$75.00',
    'Total': '\$1875.00',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tuition')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Tuition and Fees', style: boldTextStyle.copyWith(fontSize: 20)),
          const SizedBox(height: 16),
          const Text(
            'Our tuition structure is designed to offer world-class maritime and logistics education while remaining accessible and transparent.',
          ),
          const SizedBox(height: 16),
          TableWithYellowColumn(data: tuitionData),
          const SizedBox(height: 16.0),
          Text('Other Fees', style: boldTextStyle.copyWith(fontSize: 20)),
          const SizedBox(height: 10),
          ...otherFeeInfo.map((feeInfo) {
            return Row(
              spacing: 10,
              children: [
                const SizedBox(width: 5),
                const Icon(Icons.circle, size: 4),
                Text(feeInfo),
              ],
            );
          }),
          const SizedBox(height: 20),
          Text('Invoice', style: boldTextStyle.copyWith(fontSize: 20)),
          const SizedBox(height: 10),
          const Text(
            'Your Official Statement of Fees and Payments. Review, download, and track your tuition and service charges with complete transparency.',
          ),
          ...invoiceData.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: authGreyTextStyle.copyWith(fontSize: 14),
                      ),
                      Text(
                        entry.value,
                        style: authGreyTextStyle.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Fee Breakdown', style: boldTextStyle),
          const SizedBox(height: 8),
          Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Description'), Text('Amount(USD)')],
              ),
              const Divider(color: AppConstants.eslGreyText),
              ...feeBreakDown.entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry.key,
                            style: authGreyTextStyle.copyWith(fontSize: 14),
                          ),
                          Text(
                            entry.value,
                            style: authGreyTextStyle.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: AppConstants.eslGreyTint),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Payment Status', style: boldTextStyle),
                    Text('Pending', style: authGreyTextStyle),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const PaymentModal(),
                    );
                  },
                  child: const Text('Proceed to Payment'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Please ensure payment is made via bank transfer, online portal, or in person at the finance office. Late fees may apply after the due date.',
            style: TextStyle(color: AppConstants.eslRed),
          ),
        ],
      ),
    );
  }
}

class PaymentModal extends StatelessWidget {
  const PaymentModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppConstants.eslWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Choose Payment Option', style: boldTextStyle.copyWith(fontSize: 20)),
          const SizedBox(height: 16),
          _buildPaymentOption(
            icon: 'assets/wheel.png',
            text: 'ESL Payment Gateway',
            onTap: () {
              GoRouter.of(context).push(AppConstants.eslPaymentRoute);
            },
          ),
          const SizedBox(height: 10),
          _buildPaymentOption(
            text: 'Bank Deposit',
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const BankDepositModal(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({String? icon, required String text, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppConstants.eslGreyTint,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Image.asset(
                icon,
                width: 40,
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Text(text, style: boldTextStyle.copyWith(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class BankDepositModal extends StatelessWidget {
  const BankDepositModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bank Deposit',
            style: boldTextStyle.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Account Number', style: boldTextStyle.copyWith(fontSize: 16)),
              Row(
                children: [
                  const Text('100065432196845'),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(const ClipboardData(text: '100065432196845'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account number copied to clipboard')),
                      );
                    },
                    child: const Icon(Icons.copy, size: 18, color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Password', style: boldTextStyle.copyWith(fontSize: 16)),
              Row(
                children: [
                  const Text('65432'),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(const ClipboardData(text: '65432'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Password copied to clipboard')),
                      );
                    },
                    child: const Icon(Icons.copy, size: 18, color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
