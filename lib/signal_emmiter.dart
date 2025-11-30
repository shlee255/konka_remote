import 'dart:convert';
// import 'dart:math';

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
  void eps();
  void menu();
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
  void emit81();
  void emit82();
  void emit83();
  void emit84();
  void emit85();
  void emit31();
  void emit32();
  void emit77();
  void emit78();  
  void emit99();
  void hdmi();
  void dtv();
}

class LgRemoteSignalEmmiter implements SignalEmmiter {
  static const int hdrMark  = 3000;
  static const int hdrSpace = 3000;

  static const int mark        = 500;
  static const int oneSpace    = 2500;
  static const int zeroSpace   = 1500;

  static const int end1Space = 4000;
  static const int end2Space = 23300;

  static const int konka0 = 0x0200;
  static const int konka1 = 0x0201;
  static const int konka2 = 0x0202;
  static const int konka3 = 0x0203;
  static const int konka4 = 0x0204;
  static const int konka5 = 0x0205;
  static const int konka6 = 0x0206;
  static const int konka7 = 0x0207;
  static const int konka8 = 0x0208;
  static const int konka9 = 0x0209;

  static const int konkaInfo   = 0x020A;   // Program Information
  static const int konkaPower  = 0x020B;
  static const int konkaYellow = 0x020C;
  static const int konkaSound  = 0x020D;
  static const int konkaRecDec = 0x020E;
  static const int konkaFav    = 0x020F;

  static const int konkaChannelDown = 0x0210;
  static const int konkaChannelUp   = 0x0211;
  static const int konkaVolumeDown  = 0x0212;
  static const int konkaVolumeUp    = 0x0213;

  static const int konkaMute   = 0x0214;
  static const int konkaMenu   = 0x0215;
  static const int konkaBlue   = 0x0216;
  static const int konkaMTS    = 0x0217;  // Select Audio Channel
  static const int konkaEPS    = 0x0218;
  static const int konkaFreeze = 0x0219;

  static const int konkaRed     = 0x021A;   // @@@@@ NOT KNOWN @@@@@
  static const int konkaList    = 0x021B;    // Channel List
  static const int konkaInput   = 0x021C;
  static const int konkaPicture = 0x021D;  // Video Normal, Soft,
  static const int konkaZoom    = 0x021E;   // 16:9, 4:3 ... ... No use for DTV
  static const int konkaGreen   = 0x021F;   // @@@@@ NOT KNOWN @@@@@

  static const int konkaIndex    = 0x0220;
  static const int konkaRadio    = 0x0221;
  static const int konkaFB       = 0x0222;
  static const int konkaFF       = 0x0223;
  static const int konkaBackward = 0x0224;
  static const int konkaPlay     = 0x0225;
  static const int konkaPause    = 0x0226;
  static const int konkaRec      = 0x0227;
  static const int konkaForward  = 0x0228;
  static const int konkaUnknown  = 0x0229;
  static const int konkaStop     = 0x022A;

  static const int konkaUp    = 0x022B;
  static const int konkaDown  = 0x022C;
  static const int konkaLeft  = 0x022D;
  static const int konkaRight = 0x022E;
  static const int konkaOk    = 0x022F;

  static const int konkaExit = 0x0230;
  static const int konkaHdmi = 0x0231;
  static const int konkaATV  = 0x0232;
  static const int konkaDTV  = 0x0233;
  static const int konka3D   = 0x0234;

  @override
  void backwards() {
    emitKonka(konkaFB);
    // emmit(LgSignalCodes.fastBackward);
  }

  @override
  void forward() {
    emitKonka(konkaFF);
    // emmit(LgSignalCodes.fastForward);
  }

  @override
  void home() {
    emmit(LgSignalCodes.home);
  }

  @override
  void info() {
    emitKonka(konkaInfo);
    // emmit(LgSignalCodes.info);
  }

  @override
  void mute() {
    emitKonka(konkaMute);
    // emmit(LgSignalCodes.mute);
  }

  @override
  void navigateDown() {
    emitKonka(konkaDown);
    // emmit(LgSignalCodes.navigateDown);
  }

  @override
  void navigateLeft() {
    emitKonka(konkaLeft);
    // emmit(LgSignalCodes.navigateLeft);
  }

  @override
  void navigateRight() {
    emitKonka(konkaRight);
    // emmit(LgSignalCodes.navigateRight);
  }

  @override
  void navigateUp() {
    emitKonka(konkaUp);
    // emmit(LgSignalCodes.navigateUp);
  }

  @override
  void nextChannel() {
    emitKonka(konkaChannelUp);
    // emmit(LgSignalCodes.channelUp);
  }

  @override
  void ok() {
    emitKonka(konkaOk);
    // emmit(LgSignalCodes.ok);
  }

  @override
  void eps() {
    emitKonka(konkaEPS);
    // emmit(LgSignalCodes.ok);
  }

  @override
  void menu() {
    emitKonka(konkaMenu);
    // emmit(LgSignalCodes.ok);
  }

  @override
  void play() {
    emitKonka(konkaPlay);
    // emmit(LgSignalCodes.play);
  }

  @override
  void previousChannel() {
    emitKonka(konkaChannelDown);
    // emmit(LgSignalCodes.channelDown);
  }

  @override
  void pause() {
    emitKonka(konkaPause);
    // emmit(LgSignalCodes.pause);
  }

  @override
  void turnOnOff() {
    emitKonka(konkaPower);
    //emmit(LgSignalCodes.turnOnOff);
  }

  @override
  void volumeDown() {
    emitKonka(konkaVolumeDown);
    // emmit(LgSignalCodes.volumeDown);
  }

  @override
  void volumeUp() {
    emitKonka(konkaVolumeUp);
    // emmit(LgSignalCodes.volumeUp);
  }

  @override
  void back() {
    emmit(LgSignalCodes.back);
  }

  @override
  void exit() {
    emitKonka(konkaExit);
    // emmit(LgSignalCodes.exit);
  }

  @override
  void blue() {
    emitKonka(konkaBlue);
    // emmit(LgSignalCodes.blue);
  }

  @override
  void green() {
    emitKonka(konkaGreen);
    // emmit(LgSignalCodes.green);
  }

  @override
  void red() {
    emitKonka(konkaRed);
    // emmit(LgSignalCodes.red);
  }

  @override
  void yellow() {
    emitKonka(konkaYellow);
    // emmit(LgSignalCodes.yellow);
    // emitKonka(konka8);
    // emitKonka(konka1);
    // emitKonka(konkaOk);
//    emitKonka(0x0200);
  }

  @override
  void emit81() {
    emitKonka(konka8);
    emitKonka(konka1);
    emitKonka(konkaOk);    
  }

  @override
  void emit82() {
    emitKonka(konka8);
    emitKonka(konka2);
    emitKonka(konkaOk);    
  }

  @override
  void emit83() {
    emitKonka(konka8);
    emitKonka(konka3);
    emitKonka(konkaOk);    
  }

  @override
  void emit84() {
    emitKonka(konka8);
    emitKonka(konka4);
    emitKonka(konkaOk);    
  }

  @override
  void emit85() {
    emitKonka(konka8);
    emitKonka(konka5);
    emitKonka(konkaOk);    
  }

  @override
  void emit31() {
    emitKonka(konka3);
    emitKonka(konka1);
    emitKonka(konkaOk);    
  }

  @override
  void emit32() {
    emitKonka(konka3);
    emitKonka(konka2);
    emitKonka(konkaOk);    
  }

  @override
  void emit77() {
    emitKonka(konka7);
    emitKonka(konka3D);
    emitKonka(konka7);
    emitKonka(konkaOk);    
  }

  @override
  void emit78() {
    emitKonka(konka7);
    emitKonka(konka8);
    emitKonka(konkaOk);    
  }
  
  @override
  void emit99() {
    emitKonka(konka9);
    emitKonka(konka3D);
    emitKonka(konka9);
    emitKonka(konkaOk);    
  }

  @override
  void hdmi() {
    emitKonka(konkaHdmi);
  }

  @override
  void dtv() {
    emitKonka(konkaDTV);
  }

  void emitKonka(int command) {
    List<int> list = [];
    list.add(hdrMark);
    list.add(hdrSpace);

    List<int>values = decodeInt(command,16);

    list.addAll(values);

    list.add(mark);
    list.add(end1Space);
    list.add(mark);
    list.add(end2Space);
    emitInt(list);
  }

  List<int> decodeInt(int num, int bits) {
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
  }
}