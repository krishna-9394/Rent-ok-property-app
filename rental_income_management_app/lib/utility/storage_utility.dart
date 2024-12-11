import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class TLocalStorage {
  late final GetStorage _storage;

  // singleton instance
  static TLocalStorage? _instance;

  TLocalStorage._internal();

  factory TLocalStorage.instance() {
    _instance ??= TLocalStorage._internal();
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = TLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  // Generic method to save data
  Future<void> writeData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  // Generic method to read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Method to save UserModel
  Future<void> saveUser(UserModel user) async {
    await _storage.write('user', user.toJson());
  }

  // Method to get UserModel
  UserModel? getUser() {
    final userData = _storage.read<Map<String, dynamic>>('user');
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }

  // Method to cache the profile picture
  Future<void> cacheProfilePicture(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // Convert image to bytes and store it in GetStorage
        await _storage.write(imageUrl, response.bodyBytes);
      }
    } catch (e) {
      throw "Something went wrong while caching profile picture";
    }
  }

  // Method to get cached profile picture as bytes
  Uint8List getCachedProfilePicture(String imageUrl) {
    Uint8List? cachedImageArray = _storage.read<Uint8List>(imageUrl);
    // if cachedImageArray is null then i fill the image with specific imageUrl and store the image with imageUrl
    if (cachedImageArray == null) {
      cacheProfilePicture(imageUrl);
      cachedImageArray = _storage.read<Uint8List>(imageUrl);
    }
    return cachedImageArray!;
  }

  // Method to remove UserModel
  Future<void> removeUser() async {
    await _storage.remove('user');
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
