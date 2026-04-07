import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppLocalStorage {
  AppLocalStorage._privateConstructor();

  static final AppLocalStorage _secureStorageApp =
      AppLocalStorage._privateConstructor();
  factory AppLocalStorage() {
    return _secureStorageApp;
  }

  static saveData(String? key, dynamic value) async {
    if (key == null || key.isEmpty) return;
    const storage = FlutterSecureStorage();
    String s = value.toString();
    await storage.write(key: key, value: s);
  }

  static Future<String?> getData(String? key) async {
    if (key == null || key.isEmpty) return null;
    const storage = FlutterSecureStorage();
    return await storage.read(key: key);
  }

  static saveListData(String? key, dynamic value) async {
    if (key == null || key.isEmpty) return;
    const storage = FlutterSecureStorage();
    List<String> listViewerBuilderString = value;
    await storage.write(key: key, value: jsonEncode(listViewerBuilderString));
  }

  static Future<List<String>?> getDataList(String? key) async {
    if (key == null || key.isEmpty) return null;
    const storage = FlutterSecureStorage();
    String? stringOfItems = await storage.read(key: key);
    if (stringOfItems == null) return null;
    return (jsonDecode(stringOfItems) as List).cast<String>();
  }

  static Future<void> clearByKey(String key) async {
    const storage = FlutterSecureStorage();
    return await storage.delete(key: key);
  }

  static clearAll() async {
    const storage = FlutterSecureStorage();
    return await storage.deleteAll();
  }
}
