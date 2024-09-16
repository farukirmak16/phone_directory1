import 'package:hive/hive.dart';

class TokenStorage {
  final Box _box;

  TokenStorage(this._box);

  Future<void> saveToken(String token) async {
    await _box.put('token', token);
  }

  Future<String?> getToken() async {
    return _box.get('token');
  }

  Future<void> deleteToken() async {
    await _box.delete('token');
  }

  Future<void> saveUserId(String id) async {
    await _box.put('id', id);
  }

  Future<String?> getUserId() async {
    return _box.get('id');
  }

  Future<void> deleteUserId() async {
    await _box.delete('id');
  }
}
