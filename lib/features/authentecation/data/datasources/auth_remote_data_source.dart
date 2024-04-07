import 'package:appwrite/appwrite.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/features/authentecation/data/models/auth_model.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('6550991fddf45e3c1d2e')
    .setSelfSigned(status: true);

abstract class AuthRemoteDataSource {
  Future<bool> createUser(AuthModel authModel);
  Future<LoadedStateCheckParam> loginUser(AuthModel authModel);
  Future<Unit> logoutUser();
  Future<LoadedStateCheckParam> checkUserAuth();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Account account;
  final SharedPreferences sharedPreferences;

  AuthRemoteDataSourceImpl(this.account, this.sharedPreferences);

  @override
  Future<bool> createUser(AuthModel authModel) async {
    try {
      final user = await account.create(
        userId: ID.unique(),
        email: authModel.email,
        password: authModel.password,
        name: authModel.name,
      );
      sharedPreferences.setString('email', authModel.email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<LoadedStateCheckParam> loginUser(AuthModel authModel) async {
    try {
      final user = await account.createEmailSession(
          email: authModel.email, password: authModel.password);
      sharedPreferences.setString('email', authModel.email);
      return LoadedStateCheckParam(check: true, email: authModel.email ?? '');
    } catch (e) {
      print(e);
      print('exception');
      return LoadedStateCheckParam(check: false, email: '');
    }
  }

  @override
  Future<LoadedStateCheckParam> checkUserAuth() async {
    try {
      final email = sharedPreferences.getString('email');
      await account.getSession(sessionId: 'current');
      return LoadedStateCheckParam(check: true, email: email ?? '');
    } catch (e) {
      print(e);
      return LoadedStateCheckParam(check: false, email: '');
    }
  }

  @override
  Future<Unit> logoutUser() async {
    sharedPreferences.remove('email');
    // await account.deleteSessions();
    await account.deleteSession(sessionId: 'current');
    return Future.value(unit);
  }
}
