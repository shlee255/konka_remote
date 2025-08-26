import 'dart:convert';
import 'dart:math';

import 'lg_signal_codes.dart';
import 'package:ir_sensor_plugin/ir_sensor_plugin.dart';
import 'package:isolate_handler/isolate_handler.dart';
import 'package:riverpod/riverpod.dart';

IsolateHandler _isolates = IsolateHandler();

@pragma("vm:_entryPoint")
void _entryPoint(Map<String, dynamic> context) {
  final _messenger = HandledIsolate.initialize(context);

  _messenger.listen((pattern) {
    _emmit(pattern);
  });
}

void _emmit(String json) async {
  final _map = jsonDecode(json);

  await IrSensorPlugin.transmitString(pattern: _map['pattern']!);

  _isolates.kill(_map['isolate']!);
}

final signalEmmiter = Provider<SignalEmmiter>((ref) => LgRemoteSignalEmmiter());

abstract class SignalEmmiter {
  void turnOnOff();
  void home();
  void info();
  void navigateUp();
  void navigateDown();
  void navigateLeft();
  void navigateRight();
  void ok();
  void exit();
  void back();
  void volumeUp();
  void volumeDown();
  void mute();
  void nextChannel();
  void previousChannel();
  void backwards();
  void forward();
  void play();
  void pause();
  void red();
  void green();
  void yellow();
  void blue();
}

class LgRemoteSignalEmmiter implements SignalEmmiter {
  static const int hdrMark  = 3000;
  static const int hdrSpace = 3000;

  static const int mark        = 500;
  static const int oneSpace    = 2500;
  static const int zeroSpace   = 1500;

  static const int end1Space = 4000;
  static const int end2Space = 23300;

  @override
  void backwards() {
    emmit(LgSignalCodes.fastBackward);
  }

  @override
  void forward() {
    emmit(LgSignalCodes.fastForward);
  }

  @override
  void home() {
    emmit(LgSignalCodes.home);
  }

  @override
  void info() {
    emmit(LgSignalCodes.info);
  }

  @override
  void mute() {
    emmit(LgSignalCodes.mute);
  }

  @override
  void navigateDown() {
    emmit(LgSignalCodes.navigateDown);
  }

  @override
  void navigateLeft() {
    emmit(LgSignalCodes.navigateLeft);
  }

  @override
  void navigateRight() {
    emmit(LgSignalCodes.navigateRight);
  }

  @override
  void navigateUp() {
    emmit(LgSignalCodes.navigateUp);
  }

  @override
  void nextChannel() {
    emmit(LgSignalCodes.channelUp);
  }

  @override
  void ok() {
    emmit(LgSignalCodes.ok);
  }

  @override
  void play() {
    emmit(LgSignalCodes.play);
  }

  @override
  void previousChannel() {
    emmit(LgSignalCodes.channelDown);
  }

  @override
  void pause() {
    emmit(LgSignalCodes.pause);
  }

  @override
  void turnOnOff() {
    emmit(LgSignalCodes.turnOnOff);
  }

  @override
  void volumeDown() {
    emmit(LgSignalCodes.volumeDown);
  }

  @override
  void volumeUp() {
    emmit(LgSignalCodes.volumeUp);
  }

  @override
  void back() {
    emmit(LgSignalCodes.back);
  }

  @override
  void exit() {
    emmit(LgSignalCodes.exit);
  }

  @override
  void blue() {
    emmit(LgSignalCodes.blue);
  }

  @override
  void green() {
    emmit(LgSignalCodes.green);
  }

  @override
  void red() {
    emmit(LgSignalCodes.red);
  }

  @override
  void yellow() {
    // emmit(LgSignalCodes.yellow);

git    emitInt(list);
  }

  List<int> decodeInt(int num, int bits)
    {
        List<int> values = [];
        for (int i = bits - 1; i >= 0; i--)
        {
            values.add(mark);
            values.add(((num & (1 << i)) == 0)?zeroSpace:oneSpace);
        }
        return values;
    }

  void emitInt(List<int> list) {
    IrSensorPlugin.transmitListInt(list: list);
  }

  void emmit(String pattern) {
    IrSensorPlugin.transmitString(pattern: pattern);

/*
    final isolateName = Random().nextInt(100).toString();

    _isolates = IsolateHandler();

    _isolates.spawn(
      _entryPoint,
      name: isolateName,
      onInitialized: () => _isolates.send(
        jsonEncode({
          'isolate': isolateName,
          'pattern': pattern,
        }),
        to: isolateName,
      ),
    );
*/    
  }
}
