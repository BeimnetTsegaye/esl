import 'dart:io';

import 'package:esl/core/networks/dio_client.dart';
import 'package:flutter/material.dart';

class DocumentPreviewCard extends StatefulWidget {
  final String url;

  const DocumentPreviewCard({super.key, required this.url});

  @override
  _DocumentPreviewCardState createState() => _DocumentPreviewCardState();
}

class _DocumentPreviewCardState extends State<DocumentPreviewCard> {
  ImageProvider? _firstPageImage;
  final DioClient _dio = DioClient();

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      // Download PDF using Dio
      final tempDir = Directory.systemTemp;
      final tempFile = File(
        '${tempDir.path}/temp_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      await _dio.download(widget.url, savePath: tempFile.path);

      // // Load PDF document
      // final pdfDoc = await PdfDocument.openFile(tempFile.path);
      // final page = await pdfDoc.getPage(1); // Get first page
      // final pageImage = await page.render(); // Render page to image
      // final image = MemoryImage(
      //   pageImage.createImageIfNotAvailable().then(
      //         (image) => image.toByteData(format: ImageByteFormat.png),
      //       )
      //       as Uint8List,
      // );

      // setState(() {
      //   _pdfDocument = pdfDoc;
      //   _firstPageImage = image;
      // });

      // Clean up
      await tempFile.delete();
    } catch (e) {
      // print('Error loading PDF: $e');
    }
  }

  @override
  void dispose() {
    // _pdfDocument?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150,
        child: _firstPageImage != null
            ? Image(image: _firstPageImage!, fit: BoxFit.cover)
            : const Center(child: Icon(Icons.picture_as_pdf, size: 50)),
      ),
    );
  }
}
