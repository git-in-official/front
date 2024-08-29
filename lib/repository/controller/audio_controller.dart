import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart' as sound;
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

import '../../ui/view_model/write_edit_view_model.dart';


class AudioController extends GetxController {

  final WriteEditViewModel writeEditViewModel = Get.find<WriteEditViewModel>();


  var duration = Duration.zero.obs; // 총 시간
  var position = Duration.zero.obs; // 진행 중인 시간

  final recorder = sound.FlutterSoundRecorder();
  var isRecording = false.obs; // RxBool로 확인
  var audioPath = ''.obs; // 녹음 중단 시 경로 받아올 변수
  var playAudioPath = ''.obs; // 저장할 때 받아올 변수, 재생 시 필요

  // 재생에 필요한 것들
  final AudioPlayer audioPlayer = AudioPlayer(); // 오디오 파일을 재생하는 기능 제공
  var isPlaying = false.obs; // 현재 재생 중인지

  @override
  void onInit() {
    super.onInit();
    initRecorder();
    // playAudio(); // 첫 실행 시 자동 재생을 원하지 않으면 이 줄을 주석

    // 재생 상태가 변경될 때마다 상태를 감지하는 이벤트 핸들러
    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });

    // 재생 파일의 전체 길이를 감지하는 이벤트 핸들러
    audioPlayer.onDurationChanged.listen((newDuration) {
      duration.value = newDuration;
    });

    // 재생 중인 파일의 현재 위치를 감지하는 이벤트 핸들러
    audioPlayer.onPositionChanged.listen((newPosition) {
      position.value = newPosition;
    });
  }

  Future<void> playAudio() async {
    try {
      if (isPlaying.value) {
        await audioPlayer.stop(); // 이미 재생 중인 경우 정지
      }


      final source = DeviceFileSource(playAudioPath.value);
      await audioPlayer.setSource(source);

      await audioPlayer.setVolume(1.0);  // 볼륨을 최대치로 설정

      duration.value = duration.value;
      isPlaying.value = true;

      await audioPlayer.resume();

    } catch (e) {
      print("오디오 재생 중 오류 발생: $e");
    }
  }




  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();

    if (status.isDenied) {
      if (await Permission.microphone.shouldShowRequestRationale) {
        print('마이크 권한을 허용해 주세요.');
      } else {
        print('앱 설정에서 마이크 권한을 허용해 주세요.');
      }
    } else if (status.isPermanentlyDenied) {
      print('마이크 권한이 영구적으로 거부되었습니다. 앱 설정에서 권한을 허용해 주세요.');
      openAppSettings();
    } else if (status.isGranted) {
      print('마이크 권한이 허용되었습니다.');
      try {
        await recorder.openRecorder();
        recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
      } catch (e) {
        print('녹음기 초기화 중 오류 발생: $e');
      }
    } else {
      print('기타 권한 상태: ${status.toString()}');
    }
  }


  Future<String> saveRecordingLocally() async {
    if (audioPath.value.isEmpty) return ''; // 녹음된 오디오 경로가 비어있으면 빈 문자열 반환

    final audioFile = File(audioPath.value);
    if (!audioFile.existsSync()) return ''; // 파일이 존재하지 않으면 빈 문자열 반환

    try {
      final directory = await getApplicationDocumentsDirectory();
      final newPath = p.join(directory.path, 'recordings'); // recordings 디렉토리 생성
      final newFile = File(p.join(newPath, 'audio.mp3'));

      if (!(await newFile.parent.exists())) {
        await newFile.parent.create(recursive: true); // recordings 디렉터리가 없으면 생성
      }

      await audioFile.copy(newFile.path); // 기존 파일을 새로운 위치로 복사
      playAudioPath.value = newFile.path;

      writeEditViewModel.updateAudioFile(newFile.path);


      print('Audio saved at: ${newFile.path}'); // 저장 경로 출력
      return newFile.path; // 새로운 파일의 경로 반환
    } catch (e) {
      print('Error saving recording: $e');
      return '';
    }
  }



  Future<void> stop() async {
    final path = await recorder.stopRecorder(); // 녹음 중지하고, 녹음된 오디오 파일의 경로를 얻음
    audioPath.value = path!;

    isRecording.value = false;

    print('Recording stopped. File saved at: $path');

  }


  Future<void> record() async {
    if (!isRecording.value) {
      await recorder.startRecorder(toFile: 'audio');
      isRecording.value = true; // RxBool 값을 업데이트
    }
  }

  Future<void> deleteRecording() async {
    try {
      if (audioPath.value.isNotEmpty) {
        final audioFile = File(audioPath.value);
        if (audioFile.existsSync()) {
          await audioFile.delete(); // 파일 삭제
          audioPath.value = ''; // 경로를 빈 문자열로 설정
          playAudioPath.value = ''; // 재생 경로도 빈 문자열로 설정
        }
      }
    } catch (e) {
      print('Error deleting recording: $e');
    }
  }



  String formatTime(Duration duration) {
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
