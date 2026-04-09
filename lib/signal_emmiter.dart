//import 'dart:convert';
// import 'dart:math';

import 'lg_signal_codes.dart';
import 'package:ir_sensor_plugin/ir_sensor_plugin.dart';
//import 'package:isolate_handler/isolate_handler.dart';
import 'package:riverpod/riverpod.dart';

/*
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
*/

final signalEmmiter = Provider<SignalEmmiter>((ref) => LgRemoteSignalEmmiter());

abstract class SignalEmmiter {
  void turnOnOff(); // Power
  void emit1();
  void emit2();
  void emit3();
  void emit4();
  void emit5();
  void emit6();
  void emit7();
  void emit8();
  void emit9();
  void emit0();
  void emitAD();
  void input();
  void text();
  void fav();
  void settings();
  void tv();
  void netFlix();
  void youTube();
  void primeVideo();
  void myTV();

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
  // Skyworth
  static const int hdrMark  = 4500;
  static const int hdrSpace = 4500;

  static const int mark        = 562;
  static const int oneSpace    = 1687;
  static const int zeroSpace   = 562;

  static const int end1Space = 48200;
  static const int end2Space = 23300;

  static const int skyworthAddress = 0x70;

  static const int skyworthPower = 0x30;

  static const int skyworth0 = 0x00;
  static const int skyworth1 = 0x80;
  static const int skyworth2 = 0x40;
  static const int skyworth3 = 0xC0;
  static const int skyworth4 = 0x20;
  static const int skyworth5 = 0xA0;
  static const int skyworth6 = 0x60;
  static const int skyworth7 = 0xE0;
  static const int skyworth8 = 0x10;
  static const int skyworth9 = 0x90;

  static const int skyworthInfo = 0x68;
  static const int skyworthAD = 0xE6;
  static const int skyworthInput = 0xF0;
  static const int skyworthText = 0xD5;
  static const int skyworthFav = 0xB5;
  static const int skyworthSettings = 0x08;

  static const int skyworthUp = 0x42;
  static const int skyworhtDown = 0xC2;
  static const int skyworthLeft= 0x22;
  static const int skyworthRight= 0xA2;
  static const int skyworthOK= 0x62;

  static const int skyworthBack = 0x62;
  static const int skyworthHome = 0x1E;
  static const int skyworthTV = 0x2D;
  static const int skyworthExit = 0xAD;
  static const int skyworthMute = 0xB0;
  static const int skyworthVolumeUp = 0x28;
  static const int skyworthVolumeDown = 0xA8;
  static const int skyworthFB = 0x02;
  static const int skyworthFF = 0x82;
  static const int skyworthRed = 0x05;
  static const int skyworthGreen = 0x85;
  static const int skyworthYellow = 0x45;
  static const int skyworthBlue = 0xC5;
  static const int skyworthNetFlix = 0x2B;
  static const int skyworthYouTube = 0x07;
  static const int skyworthPrimeVideo = 0x6B;
  static const int skyworthMyTV = 0x3E;
 
/*
  // Konka
  static const int hdrMark  = 3000;
  static const int hdrSpace = 3000;

  static const int mark        = 500;
  static const int oneSpace    = 2500;
  static const int zeroSpace   = 1500;

  static const int end1Space = 4000;
  static const int end2Space = 23300;
*/

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
  void emit0(){
    emitSkyworth(skyworth0);
  }

  @override
  void emit1(){
    emitSkyworth(skyworth1);
  }

  @override
  void emit2(){
    emitSkyworth(skyworth2);
  }

  @override
  void emit3(){
    emitSkyworth(skyworth3);
  }

  @override
  void emit4(){
    emitSkyworth(skyworth4);
  }

  @override
  void emit5(){
    emitSkyworth(skyworth5);
  }

  @override
  void emit6(){
    emitSkyworth(skyworth6);
  }

  @override
  void emit7(){
    emitSkyworth(skyworth7);
  }

  @override
  void emit8(){
    emitSkyworth(skyworth8);
  }

  @override
  void emit9(){
    emitSkyworth(skyworth9);
  }

  @override
  void emitAD(){
    emitSkyworth(skyworthAD);
  }

  @override
  void input(){
    emitSkyworth(skyworthInput);
  }

  @override
  void text(){
    emitSkyworth(skyworthText);
  }

  @override
  void fav(){
    emitSkyworth(skyworthFav);
  }

  @override
  void settings(){
    emitSkyworth(skyworthSettings);
  }

  @override
  void tv(){
    emitSkyworth(skyworthTV);
  }

  @override
  void netFlix() {
    emitSkyworth(skyworthNetFlix);
  }

  @override
  void youTube() {
    emitSkyworth(skyworthYouTube);
  }

  @override
  void primeVideo() {
    emitSkyworth(skyworthPrimeVideo);
  }

  @override
  void myTV() {
    emitSkyworth(skyworthMyTV);
  }

  @override
  void backwards() {
    emitSkyworth(skyworthFB);
    // emmit(LgSignalCodes.fastBackward);
  }

  @override
  void forward() {
    emitSkyworth(skyworthFF);
    // emitKonka(konkaFF);
    // emmit(LgSignalCodes.fastForward);
  }

  @override
  void home() {
    emitSkyworth(skyworthHome);    
    emmit(LgSignalCodes.home);
  }

  @override
  void info() {
    emitSkyworth(skyworthInfo);
    emitKonka(konkaInfo);
    // emmit(LgSignalCodes.info);
  }

  @override
  void mute() {
    emitSkyworth(skyworthMute);
    // emitKonka(konkaMute);
    // emmit(LgSignalCodes.mute);
  }

  @override
  void navigateDown() {
    emitSkyworth(skyworhtDown);
    // emitKonka(konkaDown);
    // emmit(LgSignalCodes.navigateDown);
  }

  @override
  void navigateLeft() {
    emitSkyworth(skyworthLeft);
    //    emitKonka(konkaLeft);
    // emmit(LgSignalCodes.navigateLeft);
  }

  @override
  void navigateRight() {
    emitSkyworth(skyworthRight);
    // emitKonka(konkaRight);
    // emmit(LgSignalCodes.navigateRight);
  }

  @override
  void navigateUp() {
    emitSkyworth(skyworthUp);
    //emitKonka(konkaUp);
    // emmit(LgSignalCodes.navigateUp);
  }

  @override
  void nextChannel() {
    emitKonka(konkaChannelUp);
    // emmit(LgSignalCodes.channelUp);
  }

  @override
  void ok() {
    emitSkyworth(skyworthOK);
    //    emitKonka(konkaOk);
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
    emitSkyworth(skyworthPower);
    //emitKonka(konkaPower);
    //emmit(LgSignalCodes.turnOnOff);
  }

  @override
  void volumeDown() {
    emitSkyworth(skyworthVolumeDown);
    // emitKonka(konkaVolumeDown);
    // emmit(LgSignalCodes.volumeDown);
  }

  @override
  void volumeUp() {
    emitSkyworth(skyworthVolumeUp);
    // emitKonka(konkaVolumeUp);
    // emmit(LgSignalCodes.volumeUp);
  }

  @override
  void back() {
    emitSkyworth(skyworthBack);
    // emmit(LgSignalCodes.back);
  }

  @override
  void exit() {
    emitSkyworth(skyworthExit);
    // emitKonka(konkaExit);
    // emmit(LgSignalCodes.exit);
  }

  @override
  void blue() {
    emitSkyworth(skyworthBlue);
    // emitKonka(konkaBlue);
    // emmit(LgSignalCodes.blue);
  }

  @override
  void green() {
    emitSkyworth(skyworthGreen);
    // emitKonka(konkaGreen);
    // emmit(LgSignalCodes.green);
  }

  @override
  void red() {
    emitSkyworth(skyworthRed);
    // emitKonka(konkaRed);
    // emmit(LgSignalCodes.red);
  }

  @override
  void yellow() {
    emitSkyworth(skyworthYellow);
    // emitKonka(konkaYellow);
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

  void emitSkyworth(int command) {
    List<int> list = [];
    list.add(hdrMark);
    list.add(hdrSpace);

    List<int> header1 = decodeInt(skyworthAddress,8);
    List<int> header2 = decodeInt(skyworthAddress,8);

    List<int> data1 = decodeInt(command,8);
    List<int> data2 = decodeInt(~command,8);

    list.addAll(header1);
    list.addAll(header2);
    list.addAll(data1);
    list.addAll(data2);

    list.add(mark);
    list.add(end1Space);    

/*
    int messageTime=0;
    for(int a=0;a<list.size();++a) {
      messageTime += list.get(a).intValue();
    }

    for(int a=0;a<repeats;a++)
    {
        message.add(HDR_MARK);
        message.add(REPEAT_SPACE);
        message.add(SPACE);
        message.add(REPEAT_TIME - (HDR_MARK + REPEAT_SPACE +SPACE));
    }
*/
    emitInt(list);
  }

  List<int> decodeInt(int num, int bits) {
    List<int> values = [];

    for (int i = bits - 1; i >= 0; i--) {
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