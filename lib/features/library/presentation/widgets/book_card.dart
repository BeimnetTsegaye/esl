import 'package:dio/dio.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/util/file_downloader.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class BookCard extends StatefulWidget {
  const BookCard({super.key, this.child, this.title, this.downloadUrl});
  final Widget? child;
  final String? title;
  final String? downloadUrl;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  DownloadState _downloadState = DownloadState.idle;
  double _downloadProgress = 0.0;
  String? _errorMessage;
  final FileDownloader _fileDownloader = FileDownloader(Dio());

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 200,
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              color: currentThemeNotifier.value == lightMode
                  ? AppConstants.eslGreyTint
                  : AppConstants.eslDarkGreyTint,
              child: Stack(
                children: [
                  Center(
                    child: widget.child ??
                        const Icon(
                          FluentIcons.document_pdf_24_regular,
                          color: AppConstants.eslGreen,
                        ),
                  ),
                  // Download progress overlay
                  if (_downloadState == DownloadState.downloading)
                    Positioned.fill(
                      child: ColoredBox(
                        color: Colors.black.withValues(alpha:0.3),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: _downloadProgress,
                                backgroundColor: Colors.white.withValues(alpha:0.3),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppConstants.eslGreen,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${(_downloadProgress * 100).toInt()}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  // Success overlay
                  if (_downloadState == DownloadState.completed)
                    Positioned.fill(
                      child: ColoredBox(
                        color: AppConstants.eslGreen.withValues(alpha:0.8),
                        child: const Center(
                          child: Icon(
                            FluentIcons.checkmark_circle_24_filled,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  // Error overlay
                  if (_downloadState == DownloadState.failed)
                    Positioned.fill(
                      child: ColoredBox(
                        color: AppConstants.eslRed.withValues(alpha:0.8),
                        child: const Center(
                          child: Icon(
                            FluentIcons.error_circle_24_filled,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title ?? 'No Title',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: _buildDownloadButton(),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: AppConstants.eslRed,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadButton() {
    switch (_downloadState) {
      case DownloadState.idle:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: widget.downloadUrl != null ? _startDownload : null,
            icon: const Icon(FluentIcons.arrow_download_16_regular, size: 16),
            label: const Text('Download', style: TextStyle(fontSize: 12),),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.eslGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              minimumSize: const Size(0, 36),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: const RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );

      case DownloadState.downloading:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: null,
            icon: const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            label: const Text('Downloading...', style: TextStyle(fontSize: 12),),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.eslGreen,
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );

      case DownloadState.completed:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _resetDownload,
            icon: const Icon(FluentIcons.checkmark_24_regular, size: 16),
            label: const Text('Downloaded', style: TextStyle(fontSize: 12),),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.eslGreen,
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );

      case DownloadState.failed:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _retryDownload,
            icon: const Icon(FluentIcons.arrow_clockwise_24_regular, size: 16),
            label: const Text('Retry', style: TextStyle(fontSize: 12),),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.eslRed,
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
    }
  }

  void _startDownload() {
    if (widget.downloadUrl == null) return;

    setState(() {
      _downloadState = DownloadState.downloading;
      _downloadProgress = 0.0;
      _errorMessage = null;
    });

    _fileDownloader.downloadFileWithProgress(
      widget.downloadUrl!,
      (progress) {
        setState(() {
          _downloadState = progress.state;
          _downloadProgress = progress.progress ?? 0.0;
          _errorMessage = progress.error;
        });
      },
    );
  }

  void _retryDownload() {
    _startDownload();
  }

  void _resetDownload() {
    setState(() {
      _downloadState = DownloadState.idle;
      _downloadProgress = 0.0;
      _errorMessage = null;
    });
  }
}
