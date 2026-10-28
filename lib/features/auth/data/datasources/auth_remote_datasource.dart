import '../models/user_model.dart';

/// Contract for the remote auth data source.
abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();
}

/// Concrete implementation — wire up your HTTP client here.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // TODO: inject ApiClient
  // const AuthRemoteDataSourceImpl(this._apiClient);
  // final ApiClient _apiClient;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) {
    // TODO: implement remote login call
    throw UnimplementedError('login not implemented');
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) {
    // TODO: implement remote register call
    throw UnimplementedError('register not implemented');
  }

  @override
  Future<void> logout() {
    // TODO: implement remote logout call
    throw UnimplementedError('logout not implemented');
  }
}
