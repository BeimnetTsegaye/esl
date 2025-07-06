import 'package:esl/core/networks/api_endpoints.dart';

String get baseUrlWithoutApi => baseUrl.replaceFirst('/api', '');

String buildUrl(String? url) {
  if (url == null || url.isEmpty) {
    return '';
  }

  if (url.startsWith('http://') || url.startsWith('https://')) {
    return url;
  }

  return '$baseUrlWithoutApi$url';
}

bool isAbsoluteUrl(String url) {
  return url.startsWith('http://') || url.startsWith('https://');
}

bool isRelativeUrl(String url) {
  return !isAbsoluteUrl(url);
}
