// ignore_for_file: inference_failure_on_function_invocation, avoid_dynamic_calls

import 'package:esl/core/error/exceptions.dart';
import 'package:esl/core/networks/api_endpoints.dart';
import 'package:esl/core/networks/dio_client.dart';
import 'package:esl/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Calls the login endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> login(String email, String password, bool rememberMe);

  

  /// Calls the register endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> signUp(String email, String password, String phoneNumber, String firstName, String lastName);

  /// Calls the logout endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> logOut();

  /// Calls the check auth endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> checkAuth();

  /// Calls the refresh token endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<bool> refreshToken();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;
  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<UserModel> login(
    String email,
    String password,
    bool rememberMe,
  ) async {
    try {
      final response = await dioClient.post(
        loginEndpoint,
        data: {'email': email, 'password': password, 'rememberMe': rememberMe},
        fromJsonT: (json) {
          if (json['user'] == null) {
            throw ServerException('User data not found in response');
          }
          return UserModel.fromJson(json['user'] as Map<String, dynamic>);
        },
      );
      if (!response.success) {
        throw ServerException(response.message, response.error);
      }
      return response.data!;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUp(
    String email,
    String password,
    String phoneNumber,
    String firstName,
    String lastName,
  ) async {
    try {
      final response = await dioClient.post<UserModel>(
        signUpEndpoint,
        data: {
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
          'firstName': firstName,
          'lastName': lastName,
        },
        fromJsonT: (json) => UserModel.fromJson(json as Map<String, dynamic>),
      );
      if (response.success) {
        return response.data!;
      } else {
        throw ServerException(response.message, response.error);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logOut() async {
    try {
      final response = await dioClient.post<void>(
        logoutEndpoint,
        fromJsonT: (_) =>
            throw Exception('No data expected for logout response'),
      );
      if (!response.success) {
        throw ServerException(response.message, response.error);
      }
      return;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> checkAuth() async {
    try {
      final response = await dioClient.get(
        checkAuthEndpoint,
        fromJsonT: (json) {
          if (json == null) {
            throw ServerException('User data not found in response');
          }
          return UserModel.fromJson(json as Map<String, dynamic>);
        },
      );
      if (!response.success) {
        throw ServerException(response.message, response.error);
      }
      return response.data!;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> refreshToken() async {
    try {
      final response = await dioClient.post<bool>(
        refreshTokenEndpoint,
        fromJsonT: (json) => json['success'] as bool,
      );
      if (!response.success) {
        throw ServerException(response.message, response.error);
      }
      return response.data!;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
