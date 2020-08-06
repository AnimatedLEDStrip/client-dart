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

import 'package:animatedledstrip/animatedledstrip.dart';
import 'package:test/test.dart';

void main() {
  test('Default Construction', () {
    var data = AnimationData();
    expect(data.animation, 'Color');
    expect(data.colors, isEmpty);
    expect(data.center, -1);
    expect(data.continuous, isNull);
    expect(data.delay, -1);
    expect(data.delayMod, 1.0);
    expect(data.direction, Direction.FORWARD);
    expect(data.distance, -1);
    expect(data.id, '');
    expect(data.section, '');
    expect(data.spacing, -1);
  });

  test('Add Color', () {
    var data = AnimationData();
    expect(data.colors, isEmpty);

    var cc = ColorContainer()
      ..addColor(0xFF)..addColor(0xFF00);
    data.addColor(cc);
    expect(data.colors, isNotEmpty);
    expect(data.colors[0], cc);

    var cc2 = ColorContainer()
      ..addColor(0xFF00FF)..addColor(0xFF0000);
    data.addColor(cc2);
    expect(data.colors[0], cc);
    expect(data.colors[1], cc2);
  });

  test('JSON', () {
    var cc1 = ColorContainer()
      ..addColor(0xFF)..addColor(0xFF00);
    var cc2 = ColorContainer()
      ..addColor(0xFF0000);

    var data = AnimationData()
      ..animation = 'Meteor'
      ..addColor(cc1)..addColor(cc2)
      ..center = 50
      ..continuous = false
      ..delay = 10
      ..delayMod = 1.5
      ..direction = Direction.BACKWARD
      ..distance = 45
      ..id = 'TEST'
      ..section = 'SECT'
      ..spacing = 5;

    expect(data.json(),
        'DATA:{"animation":"Meteor","colors":[{"colors":[255, 65280]},{"colors":[16711680]}],"center":50,"continuous":false,"delay":10,"delayMod":1.5,"direction":"BACKWARD","distance":45,"id":"TEST","section":"SECT","spacing":5}');
  });

  test('JSON No Colors', () {
    var data = AnimationData();

    expect(data.json(),
        'DATA:{"animation":"Color","colors":[],"center":-1,"continuous":null,"delay":-1,"delayMod":1.0,"direction":"FORWARD","distance":-1,"id":"","section":"","spacing":-1}');
  });

  test('From JSON', () {
    var dataStr = 'DATA:{"animation":"Meteor","colors":[{"colors":[255, 65280]},{"colors":[16711680]}],"center":50,"continuous":false,"delay":10,"delayMod":1.5,"direction":"BACKWARD","distance":45,"id":"TEST","section":"test_sect","spacing":5}';
    
    var data = AnimationData.fromJson(dataStr);
    
    expect(data.animation, 'Meteor');
    expect(data.colors.length, 2);
    expect(data.colors[0].colors.length, 2);
    expect(data.colors[0].colors[0], 0xFF);
    expect(data.colors[0].colors[1], 0xFF00);
    expect(data.colors[1].colors.length, 1);
    expect(data.colors[1].colors[0], 0xFF0000);
    expect(data.center, 50);
    expect(data.continuous, false);
    expect(data.delay, 10);
    expect(data.delayMod, 1.5);
    expect(data.direction, Direction.BACKWARD);
    expect(data.distance, 45);
    expect(data.id, 'TEST');
    expect(data.section, 'test_sect');
    expect(data.spacing, 5);
  });

  test('Direction from String', () {
    expect(directionFromString('FORWARD'), Direction.FORWARD);
    expect(directionFromString('BACKWARD'), Direction.BACKWARD);
    expect(directionFromString('NONDIRECTION'), Direction.FORWARD);
  });

  test('Animation from JSON', () {
    var dataStr = 'DATA:{"animation":"Meteor"}';
    var data = AnimationData.fromJson(dataStr);
    expect(data.animation, 'Meteor');

    var dataStr2 = 'DATA:{}';
    var data2 = AnimationData.fromJson(dataStr2);
    expect(data2.animation, 'Color');
  });

  test('Center from JSON', () {
    var dataStr = 'DATA:{"center":10}';
    var data = AnimationData.fromJson(dataStr);
    expect(data.center, 10);

    var dataStr2 = 'DATA:{}';
    var data2 = AnimationData.fromJson(dataStr2);
    expect(data2.center, -1);
  });

  test('Continuous from JSON', () {
    var dataStr = 'DATA:{"continuous":true}';
    var data = AnimationData.fromJson(dataStr);
    expect(data.continuous, true);

    var dataStr2 = 'DATA:{"continuous":false}';
    var data2 = AnimationData.fromJson(dataStr2);
    expect(data2.continuous, false);

    var dataStr3 = 'DATA:{"continuous":null}';
    var data3 = AnimationData.fromJson(dataStr3);
    expect(data3.continuous, null);

    var dataStr4 = 'DATA:{}';
    var data4 = AnimationData.fromJson(dataStr4);
    expect(data4.continuous, null);
  });

  test('Delay from JSON', () {
    var dataStr = 'DATA:{"delay":10}';
    var data = AnimationData.fromJson(dataStr);
    expect(data.delay, 10);

    var dataStr2 = 'DATA:{}';
    var data2 = AnimationData.fromJson(dataStr2);
    expect(data2.delay, -1);
  });

  test('DelayMod from JSON', () {
    var dataStr = 'DATA:{"delayMod":2.0}';
    var data = AnimationData.fromJson(dataStr);
    expect(data.delayMod, 2.0);

    var dataStr2 = 'DATA:{}';
    var data2 = AnimationData.fromJson(dataStr2);
    expect(data2.delayMod, 1.0);
  });

  test('Distance from JSON', () {
    var dataStr = 'DATA:{"distance":10}';
    var data = AnimationData.fromJson(dataStr);
    expect(data.distance, 10);

    var dataStr2 = 'DATA:{}';
    var data2 = AnimationData.fromJson(dataStr2);
    expect(data2.distance, -1);
  });

  test('ID from JSON', () {
    var dataStr = 'DATA:{"id":"TEST"}';
    var data = AnimationData.fromJson(dataStr);
    expect(data.id, 'TEST');

    var dataStr2 = 'DATA:{}';
    var data2 = AnimationData.fromJson(dataStr2);
    expect(data2.id, '');
  });

  test('Section from JSON', () {
    var dataStr = 'DATA:{"section":"SECT"}';
    var data = AnimationData.fromJson(dataStr);
    expect(data.section, 'SECT');

    var dataStr2 = 'DATA:{}';
    var data2 = AnimationData.fromJson(dataStr2);
    expect(data2.section, '');
  });

  test('Spacing from JSON', () {
    var dataStr = 'DATA:{"spacing":10}';
    var data = AnimationData.fromJson(dataStr);
    expect(data.spacing, 10);

    var dataStr2 = 'DATA:{}';
    var data2 = AnimationData.fromJson(dataStr2);
    expect(data2.spacing, -1);
  });
}
