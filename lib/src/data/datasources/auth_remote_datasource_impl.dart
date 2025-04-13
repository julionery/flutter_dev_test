import 'dart:convert';

import 'package:flutter_dev_test/generated/l10n.dart';
import 'package:flutter_dev_test/src/core/utils/constants/api_constants.dart';
import 'package:flutter_dev_test/src/core/utils/exceptions/app_exceptions.dart';
import 'package:flutter_dev_test/src/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_dev_test/src/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AuthRemoteDataSourceImpl({
    required this.client,
    this.baseUrl = ApiConstants.baseUrl,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl${ApiConstants.loginEndpoint}'),
        headers: ApiConstants.headers,
        body: jsonEncode({
          'username': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return UserModel.fromJson(jsonData);
      } else {
        final Map<String, dynamic> errorData = {};

        if (response.body.isNotEmpty) {
          errorData.addAll(jsonDecode(response.body));
        }

        final String errorMessage = errorData['message'] ?? S.current.errorUnknownError;
        final String? errorCode = errorData['errorCode'];

        if (response.statusCode == 401) {
          throw UnauthorizedException(errorMessage, errorCode: errorCode);
        } else if (response.statusCode == 404) {
          throw NotFoundException(errorMessage, errorCode: errorCode);
        } else {
          throw ServerException(errorMessage);
        }
      }
    } catch (e) {
      if (e is UnauthorizedException || e is NotFoundException || e is ServerException) {
        rethrow;
      }
      throw ServerException(S.current.errorFailedToConnectToServer);
    }
  }

  @override
  Future<void> logout() async {
    return;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return null;
  }

  @override
  Future<String> verifyRecoveryCode(String code) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl${ApiConstants.recoverySecretEndpoint}'),
        headers: ApiConstants.headers,
        body: jsonEncode({
          'code': code,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['totp_secret'];
      } else {
        final Map<String, dynamic> errorData = {};

        if (response.body.isNotEmpty) {
          errorData.addAll(jsonDecode(response.body));
        }

        final String errorMessage = errorData['message'] ?? S.current.errorUnknownError;
        final String? errorCode = errorData['errorCode'];

        if (response.statusCode == 401) {
          throw UnauthorizedException(errorMessage, errorCode: errorCode);
        } else if (response.statusCode == 404) {
          throw NotFoundException(errorMessage, errorCode: errorCode);
        } else {
          throw ServerException(errorMessage);
        }
      }
    } catch (e) {
      if (e is UnauthorizedException || e is NotFoundException || e is ServerException) {
        rethrow;
      }
      throw ServerException(S.current.errorFailedToConnectToServer);
    }
  }

  @override
  Future<void> resendRecoveryCode() async {
    return;
  }
}
