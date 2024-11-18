import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onix_bot/core/injection/injector.dart';

abstract class CachingService {
  cache(String key, var value);
  getCached(String key);
  removeCached(String key);

  cacheMap(String key, Map<String, dynamic> map);
  getCachedMap(String key);
  removeCachedMap(String key);

  clearAll();
}

class CachingServiceImpl implements CachingService {
  FlutterSecureStorage get storage => getIt<FlutterSecureStorage>();

  @override
  cache(String key, var value) async {
    await storage.write(key: key, value: value);
  }

  @override
  getCached(String key) async {
    return await storage.read(key: key);
  }

  @override
  removeCached(String key) async {
    await storage.delete(key: key);
  }

  @override
  cacheMap(String key, Map<String, dynamic> map) async {
    await storage.write(key: key, value: jsonEncode(map));
  }

  @override
  getCachedMap(String key) async {
    dynamic data = await storage.read(key: key);
    return data == null || data.isEmpty ? {} : jsonDecode(data) as Map<String, dynamic>;
  }

  @override
  removeCachedMap(String key) async {
    await storage.delete(key: key);
  }

  @override
  clearAll() async {
    await storage.deleteAll();
  }
}