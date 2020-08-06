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
    var info = AnimationInfo();
    expect(info.name, '');
    expect(info.abbr, '');
    expect(info.description, '');
    expect(info.signatureFile, '');
    expect(info.repetitive, false);
    expect(info.minimumColors, 0);
    expect(info.unlimitedColors, false);
    expect(info.center, ParamUsage.NOTUSED);
    expect(info.delay, ParamUsage.NOTUSED);
    expect(info.direction, ParamUsage.NOTUSED);
    expect(info.distance, ParamUsage.NOTUSED);
    expect(info.spacing, ParamUsage.NOTUSED);
    expect(info.delayDefault, 50);
    expect(info.distanceDefault, -1);
    expect(info.spacingDefault, 3);
  });

  test('From JSON', () {
    var jsonStr = 'AINF:{"name":"Wipe","abbr":"WIP","description":"A description","signatureFile":"wipe.png","repetitive":false,"minimumColors":1,"unlimitedColors":false,"center":"NOTUSED","delay":"USED","direction":"USED","distance":"NOTUSED","spacing":"NOTUSED","delayDefault":10,"distanceDefault":-1,"spacingDefault":3}';
    var info = AnimationInfo.fromJson(jsonStr);

    expect(info.name, 'Wipe');
    expect(info.abbr, 'WIP');
    expect(info.description, 'A description');
    expect(info.signatureFile, 'wipe.png');
    expect(info.repetitive, false);
    expect(info.minimumColors, 1);
    expect(info.unlimitedColors, false);
    expect(info.center, ParamUsage.NOTUSED);
    expect(info.delay, ParamUsage.USED);
    expect(info.direction, ParamUsage.USED);
    expect(info.distance, ParamUsage.NOTUSED);
    expect(info.spacing, ParamUsage.NOTUSED);
    expect(info.delayDefault, 10);
    expect(info.distanceDefault, -1);
    expect(info.spacingDefault, 3);
  });

  test('ParamUsage from String', () {
    expect(paramUsageFromString('USED'), ParamUsage.USED);
    expect(paramUsageFromString('NOTUSED'), ParamUsage.NOTUSED);
    expect(paramUsageFromString('NONUSAGE'), ParamUsage.NOTUSED);
  });

  test('Name from JSON', () {
    var jsonStr = 'AINF:{"name":"Anim"}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.name, 'Anim');

    var jsonStr2 = 'AINF:{}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.name, '');
  });

  test('Abbr from JSON', () {
    var jsonStr = 'AINF:{"abbr":"abbrev"}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.abbr, 'abbrev');

    var jsonStr2 = 'AINF:{}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.abbr, '');
  });

  test('Description from JSON', () {
    var jsonStr = 'AINF:{"description":"Description"}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.description, 'Description');

    var jsonStr2 = 'AINF:{}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.description, '');
  });

  test('SignatureFile from JSON', () {
    var jsonStr = 'AINF:{"signatureFile":"sig.png"}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.signatureFile, 'sig.png');

    var jsonStr2 = 'AINF:{}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.signatureFile, '');
  });

  test('Repetitive from JSON', () {
    var jsonStr = 'AINF:{"repetitive":false}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.repetitive, false);

    var jsonStr2 = 'AINF:{"repetitive":true}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.repetitive, true);

    var jsonStr3 = 'AINF:{}';
    var info3 = AnimationInfo.fromJson(jsonStr3);
    expect(info3.repetitive, false);
  });

  test('MinimumColors from JSON', () {
    var jsonStr = 'AINF:{"minimumColors":5}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.minimumColors, 5);

    var jsonStr2 = 'AINF:{}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.minimumColors, 0);
  });

  test('UnlimitedColors from JSON', () {
    var jsonStr = 'AINF:{"unlimitedColors":false}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.unlimitedColors, false);

    var jsonStr2 = 'AINF:{"unlimitedColors":true}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.unlimitedColors, true);

    var jsonStr3 = 'AINF:{}';
    var info3 = AnimationInfo.fromJson(jsonStr3);
    expect(info3.unlimitedColors, false);
  });

  test('Center from JSON', () {
    var jsonStr = 'AINF:{"center":"USED"}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.center, ParamUsage.USED);

    var jsonStr2 = 'AINF:{"center":"NOTUSED"}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.center, ParamUsage.NOTUSED);

    var jsonStr3 = 'AINF:{}';
    var info3 = AnimationInfo.fromJson(jsonStr3);
    expect(info3.center, ParamUsage.NOTUSED);
  });

  test('Delay from JSON', () {
    var jsonStr = 'AINF:{"delay":"USED"}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.delay, ParamUsage.USED);

    var jsonStr2 = 'AINF:{"delay":"NOTUSED"}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.delay, ParamUsage.NOTUSED);

    var jsonStr3 = 'AINF:{}';
    var info3 = AnimationInfo.fromJson(jsonStr3);
    expect(info3.delay, ParamUsage.NOTUSED);
  });

  test('Direction from JSON', () {
    var jsonStr = 'AINF:{"direction":"USED"}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.direction, ParamUsage.USED);

    var jsonStr2 = 'AINF:{"direction":"NOTUSED"}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.direction, ParamUsage.NOTUSED);

    var jsonStr3 = 'AINF:{}';
    var info3 = AnimationInfo.fromJson(jsonStr3);
    expect(info3.direction, ParamUsage.NOTUSED);
  });

  test('Distance from JSON', () {
    var jsonStr = 'AINF:{"distance":"USED"}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.distance, ParamUsage.USED);

    var jsonStr2 = 'AINF:{"distance":"NOTUSED"}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.distance, ParamUsage.NOTUSED);

    var jsonStr3 = 'AINF:{}';
    var info3 = AnimationInfo.fromJson(jsonStr3);
    expect(info3.distance, ParamUsage.NOTUSED);
  });

  test('Spacing from JSON', () {
    var jsonStr = 'AINF:{"spacing":"USED"}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.spacing, ParamUsage.USED);

    var jsonStr2 = 'AINF:{"spacing":"NOTUSED"}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.spacing, ParamUsage.NOTUSED);

    var jsonStr3 = 'AINF:{}';
    var info3 = AnimationInfo.fromJson(jsonStr3);
    expect(info3.spacing, ParamUsage.NOTUSED);
  });

  test('DelayDefault from JSON', () {
    var jsonStr = 'AINF:{"delayDefault":5}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.delayDefault, 5);

    var jsonStr2 = 'AINF:{}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.delayDefault, 50);
  });

  test('DistanceDefault from JSON', () {
    var jsonStr = 'AINF:{"distanceDefault":5}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.distanceDefault, 5);

    var jsonStr2 = 'AINF:{}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.distanceDefault, -1);
  });

  test('SpacingDefault from JSON', () {
    var jsonStr = 'AINF:{"spacingDefault":5}';
    var info = AnimationInfo.fromJson(jsonStr);
    expect(info.spacingDefault, 5);

    var jsonStr2 = 'AINF:{}';
    var info2 = AnimationInfo.fromJson(jsonStr2);
    expect(info2.spacingDefault, 3);
  });
}
