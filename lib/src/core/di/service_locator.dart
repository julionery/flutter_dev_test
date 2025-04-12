import 'package:flutter_dev_test/src/core/utils/constants/api_constants.dart';
import 'package:flutter_dev_test/src/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_dev_test/src/data/datasources/auth_remote_datasource_impl.dart';
import 'package:flutter_dev_test/src/data/repositories/auth_repository_impl.dart';
import 'package:flutter_dev_test/src/domain/repositories/auth_repository.dart';
import 'package:flutter_dev_test/src/domain/usecases/login_usecase.dart';
import 'package:http/http.dart' as http;

class ServiceLocator {
  // Singleton instance
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  // Http client
  final http.Client _httpClient = http.Client();

  // Data sources
  late final AuthRemoteDataSource _authRemoteDataSource = AuthRemoteDataSourceImpl(
    client: _httpClient,
    baseUrl: ApiConstants.baseUrl,
  );

  // Repositories
  late final AuthRepository _authRepository = AuthRepositoryImpl(
    remoteDataSource: _authRemoteDataSource,
  );

  // Use cases
  late final LoginUseCase _loginUseCase = LoginUseCase(_authRepository);

  // Getters
  http.Client get httpClient => _httpClient;
  AuthRemoteDataSource get authRemoteDataSource => _authRemoteDataSource;
  AuthRepository get authRepository => _authRepository;
  LoginUseCase get loginUseCase => _loginUseCase;

  // Initialize services
  void init() {}

  // Clean up resources
  void dispose() {
    _httpClient.close();
  }
}
