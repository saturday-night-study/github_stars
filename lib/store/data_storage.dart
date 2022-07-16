import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataStorage {
  static const _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  static final _instance = DataStorage._internal();

  static const _storage = FlutterSecureStorage();

  factory DataStorage() {
    return _instance;
  }

  DataStorage._internal();

  Future<void> write(String key, String value) async {
    await _storage.write(
      key: key,
      value: value,
      aOptions: _androidOptions,
    );
  }

  Future<String> read(String key) async {
    final value = await _storage.read(
      key: key,
      aOptions: _androidOptions,
    );

    return value ?? "";
  }

  Future<void> delete(String key) async {
    await _storage.delete(
      key: key,
      aOptions: _androidOptions,
    );
  }

  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }
}
