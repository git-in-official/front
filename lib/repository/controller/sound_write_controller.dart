import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:to_morrow_front/repository/controller/topic_controller.dart';

class SoundWriteController extends GetxController {
  // GetX 상태 관리
  final RxBool isPlaying = false.obs;
  final Rx<Duration> position = Duration.zero.obs;
  final Rx<Duration> duration = Duration.zero.obs;

  // AudioPlayer 인스턴스 생성
  final AudioPlayer player = AudioPlayer();

  void setupAudioPlayer() {
    player.onPlayerStateChanged.listen((PlayerState state) {
      isPlaying.value = state == PlayerState.playing;
    });

    player.onPositionChanged.listen((Duration newPosition) {
      position.value = newPosition;
    });

    player.onDurationChanged.listen((Duration newDuration) {
      duration.value = newDuration;
    });
  }

  void stopAudio() {
    player.stop();
    isPlaying.value = false;
    position.value = Duration.zero;
    duration.value = Duration.zero;
  }
}
