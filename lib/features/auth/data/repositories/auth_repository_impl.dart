import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    return _remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return _remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    return _remoteDataSource.logout();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    // TODO: implement get current user from local cache / secure storage
    return null;
  }

  @override
  Future<bool> get isLoggedIn async {
    final user = await getCurrentUser();
    return user != null;
  }
}
