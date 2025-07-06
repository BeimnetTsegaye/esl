import 'package:esl/core/shared/constants.dart';
import 'package:flutter/material.dart';

class PaymentReceiptPage extends StatelessWidget {
  const PaymentReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt'),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildRecipientAndInvoiceInfo(),
                const SizedBox(height: 24),
                _buildInvoiceDate(),
                const SizedBox(height: 24),
                _buildServicesTable(),
                const Divider(),
                const SizedBox(height: 16),
                _buildTotals(),
                const SizedBox(height: 48),
                _buildFooter(),
                const SizedBox(height: 24),
                //finish
                const SizedBox(height: 24),
                _buildFinishButton(),
              ],
            ),
            Positioned.fill(
              child: Center(
                child: Transform.rotate(
                  angle: -0.5,
                  child: Text(
                    'Paid',
                    style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.eslGreen.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Image.asset(AppConstants.engHorizontalFullColor, height: 50),
    );
  }

  Widget _buildRecipientAndInvoiceInfo() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recipient',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text('Meron Ayele'),
            Text('STU001'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Invoice',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text('Invoice Number'),
            Text('1001234567'),
          ],
        ),
      ],
    );
  }

  Widget _buildInvoiceDate() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Invoice Date',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 8),
        Text('15 Dec 2025'),
      ],
    );
  }

  Widget _buildServicesTable() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Service', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              'Service Charge and Fee',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Divider(),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Marine Engineering'),
                Text('Semester 1', style: TextStyle(color: Colors.grey)),
              ],
            ),
            Text('1'),
            Text('12,000'),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTotals() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Subtotal'), Text('12,000')],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Tax (15%)'), Text('1,800')],
        ),
        SizedBox(height: 8),
        Divider(),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('13,800', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Column(
            children: [
              Icon(Icons.location_on, color: Color(0xff0E6F45)),
              SizedBox(height: 28),
              Icon(Icons.phone, color: Color(0xff0E6F45)),
              SizedBox(height: 8),
              Icon(Icons.email, color: Color(0xff0E6F45)),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ras Mekonen Street, Leghar behind Ethiopian Insurance Corporation H.Q. Addis Ababa, Ethiopia.',
                ),
                SizedBox(height: 16),
                Text('+251 900 000 000'),
                SizedBox(height: 16),
                Text('info@bmla.et'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinishButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.eslGreen,
          foregroundColor: Colors.white,
        ),
        child: const Text('Finish', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
