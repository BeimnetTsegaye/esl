// ignore_for_file: inference_failure_on_function_invocation

import 'dart:developer';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:esl/core/error/exceptions.dart';
import 'package:esl/core/networks/api_endpoints.dart';
import 'package:esl/core/networks/api_response.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio _dio;
  late final PersistCookieJar _cookieJar;
  bool _isInitialized = false;
  Future<void>? _initFuture;

  DioClient._internal() {
    _dio = Dio();
    _initFuture = _initialize();
  }

  Future<void> _initialize() async {
    if (_isInitialized) return;

    await initCookieJar();
    _dio
      ..options.baseUrl = baseUrl
      ..options.headers = {
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
      }
      ..options.connectTimeout = const Duration(milliseconds: 15000)
      ..options.receiveTimeout = const Duration(milliseconds: 15000)
      ..options.responseType = ResponseType.json
      ..interceptors.addAll([
        CookieManager(_cookieJar),
        if (const bool.fromEnvironment('dart.vm.product') == false)
          PrettyDioLogger(
            compact: false,
            requestBody: true,
            logPrint: (object) => log(object.toString(), name: 'ESL API'),
          ),
        InterceptorsWrapper(
          onError: (DioException e, ErrorInterceptorHandler handler) async {
            if (e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.receiveTimeout) {
              try {
                final response = await _dio.request(
                  e.requestOptions.path,
                  data: e.requestOptions.data,
                  queryParameters: e.requestOptions.queryParameters,
                  options: Options(
                    method: e.requestOptions.method,
                    headers: e.requestOptions.headers,
                  ),
                );
                return handler.resolve(response);
              } catch (_) {
                return handler.reject(e);
              }
            }
            return handler.reject(e);
          },
        ),
      ]);
    _isInitialized = true;
  }

  Future<void> initCookieJar() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    _cookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage('$appDocPath/.cookies/'),
    );
  }

  Future<void> clearCookies() async {
    await _ensureInitialized();
    await _cookieJar.deleteAll();
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await _initFuture;
    }
  }

  Future<ApiResponse<T>> _handleRequest<T>(
    Future<Response<dynamic>> Function() request,
    T Function(dynamic)? fromJsonT,
  ) async {
    await _ensureInitialized();
    try {
      final response = await request();

      if (response.statusCode == 204) {
        return ApiResponse(success: true, message: 'Success');
      }

      if (response.data == null) {
        return ApiResponse(success: true, message: 'No content');
      }

      if (response.data is! Map<String, dynamic> && response.data is! List) {
        throw ServerException(
          'Response data is not in expected format: ${response.data.runtimeType}',
        );
      }

      if (response.data is Map<String, dynamic>) {
        return ApiResponse.fromJson(
          response.data as Map<String, dynamic>,
          fromJsonT ?? (_) => null as T,
        );
      }

      return ApiResponse.fromJson({
        'data': response.data,
      }, fromJsonT ?? (_) => null as T);
    } on DioException catch (e) {
      log('DioException occurred: ${e.message}', name: 'ESL API');
      log('DioException type: ${e.type}', name: 'ESL API');
      if (e.response != null) {
        log('Response data: ${e.response?.data}', name: 'ESL API');
        log('Response status code: ${e.response?.statusCode}', name: 'ESL API');

        if (e.response!.data is Map<String, dynamic>) {
          try {
            return ApiResponse.fromJson(
              e.response!.data as Map<String, dynamic>,
              (_) =>
                  throw ServerException('Failed to parse error response data'),
            );
          } catch (parseError) {
            log(
              'Failed to parse error response data: $parseError',
              name: 'ESL API',
            );
            throw ServerException(
              'Failed to parse server error response format.',
            );
          }
        } else {
          throw ServerException(
            'Server returned an error but data format is unexpected: ${e.response!.data.runtimeType}',
          );
        }
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw ServerException('Connection timed out. Please try again.');
        case DioExceptionType.receiveTimeout:
          throw ServerException(
            'Server took too long to respond. Please try again.',
          );
        case DioExceptionType.badResponse:
          throw ServerException(
            'Received an invalid response from the server: ${e.response?.statusCode ?? 'Unknown status'}',
          );
        case DioExceptionType.cancel:
          throw ServerException('Request was cancelled.');
        case DioExceptionType.unknown:
          if (e.error is SocketException) {
            throw ServerException(
              'Unable to connect to the server. Please check your internet connection.',
            );
          }
          throw ServerException('Network error occurred. Please try again.');
        default:
          if (e.error is SocketException) {
            throw ServerException(
              'Unable to connect to the server. Please check your internet connection.',
            );
          }
          throw ServerException(
            'An unexpected error occurred: ${e.message ?? "Unknown error"}',
          );
      }
    } on SocketException catch (e) {
      log('SocketException occurred: $e', name: 'ESL API');
      throw ServerException('Network error: Unable to connect to the server.');
    } on FormatException catch (e) {
      log('FormatException occurred: $e', name: 'ESL API');
      throw ServerException('Invalid response format from server.');
    } catch (e) {
      log('Unexpected error occurred: $e', name: 'ESL API');
      throw ServerException(
        'An unexpected error occurred during the request: $e',
      );
    }
  }

  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJsonT,
  }) async {
    return await _handleRequest(
      () => _dio.get(endpoint, queryParameters: queryParameters),
      fromJsonT,
    );
  }

  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? data,
    T Function(dynamic)? fromJsonT,
  }) async {
    return await _handleRequest(
      () => _dio.post(endpoint, data: data),
      fromJsonT,
    );
  }

  Future<ApiResponse<T>> postMultipart<T>(
    String endpoint, {
    FormData? data,
    T Function(dynamic)? fromJsonT,
  }) async {
    return await _handleRequest(
      () => _dio.post(endpoint, data: data),
      fromJsonT,
    );
  }

  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? data,
    T Function(dynamic)? fromJsonT,
  }) async {
    return await _handleRequest(
      () => _dio.put(
        endpoint,
        data: data,
        options: Options(
          responseType: ResponseType.json,
          validateStatus: (status) => status! < 500,
        ),
      ),
      fromJsonT,
    );
  }

  Future<ApiResponse<T>> patch<T>(
    String endpoint, {
    Map<String, dynamic>? data,
    T Function(dynamic)? fromJsonT,
  }) async {
    return await _handleRequest(
      () => _dio.patch(
        endpoint,
        data: data,
        options: Options(
          responseType: ResponseType.json,
          validateStatus: (status) => status! < 500,
        ),
      ),
      fromJsonT,
    );
  }

  Future<ApiResponse<void>> download(
    String url, {
    required String savePath,
    Map<String, dynamic>? queryParameters,
  }) async {
    await _ensureInitialized();
    try {
      final response = await _dio.download(
        url,
        savePath,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        return ApiResponse(
          success: true,
          message: 'File downloaded successfully',
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed to download file: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      log(
        'DioException occurred while downloading file: ${e.message}',
        name: 'ESL API',
      );
      throw ServerException('Failed to download file: ${e.message}');
    } catch (e) {
      log(
        'Unexpected error occurred while downloading file: $e',
        name: 'ESL API',
      );
      throw ServerException(
        'An unexpected error occurred while downloading the file.',
      );
    }
  }

  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    Map<String, dynamic>? data,
    T Function(dynamic)? fromJsonT,
  }) async {
    return await _handleRequest(
      () => _dio.delete(
        endpoint,
        data: data,
        options: Options(
          responseType: ResponseType.json,
          validateStatus: (status) => status! < 500,
        ),
      ),
      fromJsonT,
    );
  }
}
