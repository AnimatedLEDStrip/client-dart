/*
 *  Copyright (c) 2019-2020 AnimatedLEDStrip
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 */

import 'dart:io';
import 'package:animatedledstrip/src/animation_data.dart';
import 'package:animatedledstrip/src/animation_info.dart';
import 'package:animatedledstrip/src/end_animation.dart';
import 'package:animatedledstrip/src/message.dart';
import 'package:animatedledstrip/src/running_animation_map.dart';
import 'package:animatedledstrip/src/section.dart';
import 'package:animatedledstrip/src/strip_info.dart';

import 'command.dart';

class AnimationSender {
  String address;
  int port;
  Socket connection;

  bool started = false;
  bool connected = false;

  RunningAnimationMap runningAnimations = RunningAnimationMap();
  Map<String, Section> sections = {};
  Map<String, AnimationInfo> supportedAnimations = {};
  StripInfo stripInfo;

  Function(String, int) onConnectCallback;
  Function(String, int) onDisconnectCallback;
  Function(String, int) onUnableToConnectCallback;

  Function(String) onReceiveCallback;
  Function(AnimationData) onNewAnimationDataCallback;
  Function(AnimationInfo) onNewAnimationInfoCallback;
  Function(EndAnimation) onNewEndAnimationCallback;
  Function(Message) onNewMessageCallback;
  Function(Section) onNewSectionCallback;
  Function(StripInfo) onNewStripInfoCallback;

  String _partialData = '';

  AnimationSender(String address, int port)
      : address = address,
        port = port;

  void start() async {
    if (started) return;

    runningAnimations.clear();
    sections.clear();
    supportedAnimations.clear();
    stripInfo = null;

    started = true;

    try {
      connection =
          await Socket.connect(address, port, timeout: Duration(seconds: 10));

      connection.handleError(handleDisconnect);
    } catch (e) {
      onUnableToConnectCallback?.call(address, port);
      started = false;
      connected = false;
      return;
    }

    connected = true;
    onConnectCallback?.call(address, port);

    connection.listen(receiveData);
  }

  void end() {
    started = false;
    connected = false;
    connection?.destroy();
  }

  void handleDisconnect(SocketException e) {
    started = false;
    connected = false;
    onDisconnectCallback?.call(address, port);
  }

  void receiveData(data) {
    var dataStr = String.fromCharCodes(data).trim();

    var tokens = (_partialData + dataStr).split(';;;');
    _partialData = '';
    if (!dataStr.endsWith(';;;')) {
      _partialData = tokens.last;
      tokens.removeLast();
    }

    for (var token in tokens) {
      if (token == '') continue;

      onReceiveCallback?.call(token);

      if (token.startsWith('DATA:')) {
        var data = AnimationData.fromJson(token);
        onNewAnimationDataCallback?.call(data);
        runningAnimations.put(data);
      } else if (token.startsWith('AINF:')) {
        var info = AnimationInfo.fromJson(token);
        supportedAnimations[info.name] = info;
        onNewAnimationInfoCallback?.call(info);
      } else if (token.startsWith('CMD :')) {
        print('Receiving Command is not supported by client');
      } else if (token.startsWith('END :')) {
        var end = EndAnimation.fromJson(token);
        onNewEndAnimationCallback?.call(end);
        runningAnimations.delete(end.id);
      } else if (token.startsWith('MSG :')) {
        var msg = Message.fromJson(token);
        onNewMessageCallback?.call(msg);
      } else if (token.startsWith('SECT:')) {
        var sect = Section.fromJson(token);
        onNewSectionCallback?.call(sect);
        sections[sect.name] = sect;
      } else if (token.startsWith('SINF:')) {
        var info = StripInfo.fromJson(token);
        stripInfo = info;
        onNewStripInfoCallback?.call(info);
      } else {
        print('Unrecognized data type: ' + token.substring(0, 5));
      }
    }
  }

  void _send(String str) {
    connection.write('$str;;;');
  }

  void sendAnimationData(AnimationData data) {
    _send(data.json());
  }

  void sendCommand(Command cmd) {
    _send(cmd.json());
  }

  void sendEndAnimation(EndAnimation end) {
    _send(end.json());
  }

  void sendSection(Section sect) {
    _send(sect.json());
  }

  void setOnConnectAction(dynamic Function(String, int) action) =>
      onConnectCallback = action;

  void setOnDisconnectAction(dynamic Function(String, int) action) =>
      onDisconnectCallback = action;

  void setOnUnableToConnectAction(dynamic Function(String, int) action) =>
      onUnableToConnectCallback = action;

  void setOnReceiveAction(dynamic Function(String) action) =>
      onReceiveCallback = action;

  void setOnNewAnimationDataAction(dynamic Function(AnimationData) action) =>
      onNewAnimationDataCallback = action;

  void setOnNewAnimationInfoAction(dynamic Function(AnimationInfo) action) =>
      onNewAnimationInfoCallback = action;

  void setOnNewEndAnimationAction(dynamic Function(EndAnimation) action) =>
      onNewEndAnimationCallback = action;

  void setOnNewMessageAction(dynamic Function(Message) action) =>
      onNewMessageCallback = action;

  void setOnNewSectionAction(dynamic Function(Section) action) =>
      onNewSectionCallback = action;

  void setOnNewStripInfoAction(dynamic Function(StripInfo) action) =>
      onNewStripInfoCallback = action;
}
