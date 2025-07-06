import 'dart:io';

import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileChoosingWidget extends StatefulWidget {
  const FileChoosingWidget({
    super.key,
    required this.selectedFile,
    required this.title,
    required this.onFilePicked,
  });

  final String selectedFile;
  final String title;
  final ValueChanged<String> onFilePicked;

  @override
  State<FileChoosingWidget> createState() => _FileChoosingWidgetState();
}

class _FileChoosingWidgetState extends State<FileChoosingWidget> {
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _checkAndSetFilePath(widget.selectedFile);
  }

  @override
  void didUpdateWidget(covariant FileChoosingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedFile != oldWidget.selectedFile) {
      _checkAndSetFilePath(widget.selectedFile);
    }
  }

  void _checkAndSetFilePath(String path) {
    if (path.isNotEmpty) {
      try {
        final file = File(path);
        if (file.existsSync()) {
          setState(() {
            _filePath = path;
          });
        } else {
          setState(() {
            _filePath = null;
          });
          // Show warning if file doesn't exist
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File not found: ${_getDisplayFileName()}'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      } catch (e) {
        setState(() {
          _filePath = null;
        });
        // Show error for invalid file path
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid file path: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      setState(() {
        _filePath = null;
      });
    }
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        
      );
      
      if (result != null && result.files.isNotEmpty) {
        final newPath = result.files.single.path;
        if (newPath != null) {
          // Validate file extension
          if (!_isValidFileExtension(newPath)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid file type. Please select a PDF, DOC, DOCX, JPG, PNG, or TXT file.'),
                backgroundColor: Colors.orange,
              ),
            );
            return;
          }
          
          setState(() {
            _filePath = newPath;
          });
          widget.onFilePicked(newPath);
          
          // Show success message with file info
          final fileSize = _getFileSize(newPath);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File selected: ${_getDisplayFileName()} ($fileSize)'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Method to create test files for iOS simulator
  Future<void> _createTestFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      
      // Sanitize the title to create a valid filename
      final sanitizedTitle = _sanitizeFileName(widget.title);
      final testFileName = 'test_${sanitizedTitle.toLowerCase()}.pdf';
      final testFile = File('${directory.path}/$testFileName');
      
      // Create a simple PDF-like content (this is just for testing)
      await testFile.writeAsString('Test file content for ${widget.title}');
      
      setState(() {
        _filePath = testFile.path;
      });
      widget.onFilePicked(testFile.path);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Test file created: $testFileName')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating test file: $e')),
      );
    }
  }

  // Sanitize filename to remove/replace invalid characters
  String _sanitizeFileName(String fileName) {
    // Replace spaces and special characters with underscores
    return fileName
        .replaceAll(RegExp(r'[^\w\s-]'), '') // Remove special characters except letters, numbers, spaces, and hyphens
        .replaceAll(RegExp(r'[-\s]+'), '_') // Replace spaces and hyphens with underscores
        .replaceAll(RegExp('_+'), '_') // Replace multiple underscores with single underscore
        .trim(); // Remove leading/trailing whitespace
  }

  // Validate file extension
  bool _isValidFileExtension(String filePath) {
    final allowedExtensions = ['.pdf', '.doc', '.docx', '.jpg', '.jpeg', '.png', '.txt'];
    final fileExtension = filePath.toLowerCase().substring(filePath.lastIndexOf('.'));
    return allowedExtensions.contains(fileExtension);
  }

  // Get file size in human readable format
  String _getFileSize(String filePath) {
    try {
      final file = File(filePath);
      final bytes = file.lengthSync();
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
      if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    } catch (e) {
      return 'Unknown size';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        const SizedBox(height: 10),
        Text(widget.title),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: _getDisplayFileName(),
            prefixIcon: Container(
              color: AppConstants.eslGreyText,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: ElevatedButton(
                onPressed: _pickFile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: const RoundedRectangleBorder(),
                  textStyle: authGreyTextStyle,
                ),
                child: const Text('Choose File'),
              ),
            ),
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.url,
        ),
        // Add test file creation button for iOS simulator
        if (Platform.isIOS)
          TextButton.icon(
            onPressed: _createTestFile,
            icon: const Icon(Icons.add_circle_outline),
            label: const Text('Create Test File (iOS Simulator)'),
          ),
      ],
    );
  }

  // Get a user-friendly display name for the file
  String _getDisplayFileName() {
    if (_filePath == null || _filePath!.isEmpty) {
      return 'No file selected';
    }
    
    try {
      final file = File(_filePath!);
      final fileName = file.path.split('/').last;
      
      // If the filename is too long, truncate it
      if (fileName.length > 30) {
        final extension = fileName.split('.').last;
        final nameWithoutExtension = fileName.substring(0, fileName.lastIndexOf('.'));
        return '${nameWithoutExtension.substring(0, 25)}...$extension';
      }
      
      return fileName;
    } catch (e) {
      return 'Invalid file path';
    }
  }
}
