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

import 'package:animatedledstrip/src/color_container.dart';
import 'dart:convert';

enum Direction { FORWARD, BACKWARD }

Direction directionFromString(String dir) {
  switch (dir?.toUpperCase()) {
    case 'FORWARD':
      return Direction.FORWARD;
    case 'BACKWARD':
      return Direction.BACKWARD;
    default:
      return Direction.FORWARD;
  }
}

class AnimationData {
  String animation = 'Color';
  List<ColorContainer> colors = [];
  int center = -1;
  bool continuous;
  int delay = -1;
  double delayMod = 1.0;
  Direction direction = Direction.FORWARD;
  int distance = -1;
  String id = '';
  String section = '';
  int spacing = -1;

  void addColor(ColorContainer c) {
    colors.add(c);
  }

  String _colorsJson() {
    if (colors.isEmpty) {
      return '';
    } else {
      var cols = '';
      for (var c in colors) {
        cols += c.json();
        cols += ',';
      }
      return cols.substring(0, cols.length - 1);
    }
  }

  String json() {
    return 'DATA:{"animation":"$animation",'
        '"colors":[${_colorsJson()}],"center":$center,"continuous":$continuous,'
        '"delay":$delay,"delayMod":$delayMod,'
        '"direction":"${direction.toString().replaceFirst("Direction.", "")}",'
        '"distance":$distance,"id":"$id","section":"$section",'
        '"spacing":$spacing}';
  }

  static AnimationData fromJson(String jsonStr) {
    var data = AnimationData();
    var jsonData = jsonDecode(jsonStr.substring(5));

    data.animation = jsonData['animation'] ?? 'Color';
    if (jsonData['colors'] != null) {
      for (var ccStr in jsonData['colors']) {
        var cc = ColorContainer();
        if (ccStr['colors'] != null) {
          for (var col in ccStr['colors']) {
            cc.addColor(col);
          }
        }
        data.addColor(cc);
      }
    }
    data.center = jsonData['center'] ?? -1;
    data.continuous = jsonData['continuous'];
    data.delay = jsonData['delay'] ?? -1;
    data.delayMod = jsonData['delayMod'] ?? 1.0;
    data.direction = directionFromString(jsonData['direction']);
    data.distance = jsonData['distance'] ?? -1;
    data.id = jsonData['id'] ?? '';
    data.section = jsonData['section'] ?? '';
    data.spacing = jsonData['spacing'] ?? -1;

    return data;
  }
}
