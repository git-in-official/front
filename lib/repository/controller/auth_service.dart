import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'global_controller.dart';

class AuthService {
  final _global = Get.find<GlobalController>();

  // 구글 토큰 저장
  Future<void> saveToken(String googleAccessToken) async {
    await _global.storage
        .write(key: 'googleAccessToken', value: googleAccessToken);
  }

  // 구글 토큰 불러오기
  Future<Map<String, String?>> loadTokens() async {
    final googleAccessToken =
    await _global.storage.read(key: 'googleAccessToken');
    return {'googleAccessToken': googleAccessToken};
  }

  // 구글 토큰 삭제
  Future<void> deleteToken() async {
    await _global.storage.delete(key: 'googleAccessToken');
  }

  // 서비스 토큰 저장
  Future<void> saveServiceToken(String accessToken) async {
    await _global.storage.write(key: 'accessToken', value: accessToken);
  }

  // 서비스 토큰 불러오기
  Future<String?> loadServiceTokens() async {
    return _global.storage.read(key : 'accessToken');
  }

  // 서비스 이름 저장
  Future<void> saveServiceName(String name) async {
    await _global.storage.write(key: 'name', value: name);
  }

  // 서비스 이름 불러오기
  Future<String?> loadServiceName() async {
    return _global.storage.read(key : 'name');
  }



}