import 'package:esl/core/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  MobileScannerController controller = MobileScannerController();
  String? scannedData;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Scanner')),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: MobileScanner(
              controller: controller,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  setState(() {
                    scannedData = barcodes.first.rawValue;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  scannedData != null ? 'Data: $scannedData' : 'Scan a QR code',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    context.push(AppConstants.feedbackRoute);
                  },
                  child: const Text('View Scanned Data'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QRDataPage extends StatelessWidget {
  final String data;

  const QRDataPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scanned QR Data')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Scanned Data: $data',
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
