import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:esl/core/util/url_utils.dart';
import 'package:path_provider/path_provider.dart';

enum DownloadState {
  idle,
  downloading,
  completed,
  failed,
}

class DownloadProgress {
  final DownloadState state;
  final double? progress;
  final String? error;
  final String? filePath;

  DownloadProgress({
    required this.state,
    this.progress,
    this.error,
    this.filePath,
  });
}

class FileDownloader {
  final Dio dio;

  FileDownloader(this.dio);

  Future<String> downloadFile(String url) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${url.split('/').last}';
      log('FILEPATH: $filePath');

      final response = await dio.download(buildUrl(url), filePath);
      log('RESPONSE: ${response.statusCode}');
      if (response.statusCode == 200) {
        return filePath;
      } else {
        throw Exception('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error downloading file: $e');
    }
  }

  Future<void> downloadFileWithProgress(
    String url,
    void Function(DownloadProgress) onProgress,
  ) async {
    try {
      onProgress(DownloadProgress(state: DownloadState.downloading, progress: 0.0));
      
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${url.split('/').last}';
      log('FILEPATH: $filePath');

      await dio.download(
        buildUrl(url),
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            onProgress(DownloadProgress(
              state: DownloadState.downloading,
              progress: progress,
            ));
          }
        },
      );

      onProgress(DownloadProgress(
        state: DownloadState.completed,
        progress: 1.0,
        filePath: filePath,
      ));
    } catch (e) {
      log('Download error: $e');
      onProgress(DownloadProgress(
        state: DownloadState.failed,
        error: e.toString(),
      ));
    }
  }
}
