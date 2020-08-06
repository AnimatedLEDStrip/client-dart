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
import 'package:animatedledstrip/src/running_animation_map.dart';
import 'package:animatedledstrip/src/section.dart';
import 'package:animatedledstrip/src/strip_info.dart';

class AnimationSender {
  String address;
  int port;
  Socket connection;
  bool connected = false;
  RunningAnimationMap runningAnimations = RunningAnimationMap();
  Map<String, AnimationInfo> supportedAnimations = {};
  Map<String, Section> sections = {};
  StripInfo stripInfo;

  String _partialData = '';

  AnimationSender(String address, int port)
      : address = address,
        port = port;

  void receiveData(data) {
    var dataStr = String.fromCharCodes(data).trim();
    print(dataStr);

    var tokens = (_partialData + dataStr).split(';;;');
    _partialData = '';
    if (!dataStr.endsWith(';;;')) {
      // We are assuming that the lack of a ';;;' at the end of
      //  the data means that the buffer was full and not all
      //  data has been received yet.
      // Therefore we will store the partial data and only
      //  process the complete data.
      // During the next callback, the partial data will be
      //  appended to the beginning to reunite it with the rest
      //  of itself.
      print(tokens.length);
      _partialData = tokens.last;
      tokens.removeLast();
    }

    for (var token in tokens) {
      if (token == '') continue;
      if (token.startsWith('DATA:')) {
        var data = AnimationData.fromJson(token);
        runningAnimations.put(data);
      } else if (token.startsWith('AINF:')) {
        var info = AnimationInfo.fromJson(token);
        supportedAnimations[info.name] = info;
      } else if (token.startsWith('END :')) {
        var end = EndAnimation.fromJson(token);
        runningAnimations.delete(end.id);
      } else if (token.startsWith('SECT:')) {
        var sect = Section.fromJson(token);
        sections[sect.name] = sect;
      } else if (token.startsWith('SINF:')) {
        var info = StripInfo.fromJson(token);
        stripInfo = info;
      }
    }
  }

  void start() async {
    connection =
    await Socket.connect(address, port, timeout: Duration(seconds: 10));

    connected = true;
    connection.listen(receiveData);
  }

  void end() {
    connection?.destroy();
    connected = false;
    supportedAnimations.clear();
  }

  void sendAnimationData(AnimationData data) {
    if (connected) {
      connection.write(data.json() + ';;;');
    } else {
      throw IOException;
    }
  }
}
