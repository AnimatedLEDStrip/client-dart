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
    var info = StripInfo();
    expect(info.numLEDs, 0);
    expect(info.pin, -1);
    expect(info.imageDebugging, false);
    expect(info.fileName, '');
    expect(info.rendersBeforeSave, -1);
    expect(info.threadCount, 100);
  });

  test('From JSON', () {
    var jsonStr =
        'SINF:{"numLEDs":240,"pin":12,"imageDebugging":true,"rendersBeforeSave":1000,"threadCount":100}';
    var info = StripInfo.fromJson(jsonStr);

    expect(info.numLEDs, 240);
    expect(info.pin, 12);
    expect(info.imageDebugging, true);
    expect(info.rendersBeforeSave, 1000);
    expect(info.threadCount, 100);
  });

  test('NumLEDs from JSON', () {
    var jsonStr = 'SINF:{"numLEDs":5}';
    var info = StripInfo.fromJson(jsonStr);
    expect(info.numLEDs, 5);

    var jsonStr2 = 'SINF:{}';
    var info2 = StripInfo.fromJson(jsonStr2);
    expect(info2.numLEDs, 0);
  });

  test('Pin from JSON', () {
    var jsonStr = 'SINF:{"pin":5}';
    var info = StripInfo.fromJson(jsonStr);
    expect(info.pin, 5);

    var jsonStr2 = 'SINF:{}';
    var info2 = StripInfo.fromJson(jsonStr2);
    expect(info2.pin, -1);
  });

  test('ImageDebugging from JSON', () {
    var jsonStr = 'SINF:{"imageDebugging":true}';
    var info = StripInfo.fromJson(jsonStr);
    expect(info.imageDebugging, true);

    var jsonStr2 = 'SINF:{}';
    var info2 = StripInfo.fromJson(jsonStr2);
    expect(info2.imageDebugging, false);
  });

  test('FileName from JSON', () {
    var jsonStr = 'SINF:{"fileName":"file"}';
    var info = StripInfo.fromJson(jsonStr);
    expect(info.fileName, 'file');

    var jsonStr2 = 'SINF:{}';
    var info2 = StripInfo.fromJson(jsonStr2);
    expect(info2.fileName, '');
  });

  test('RendersBeforeSave from JSON', () {
    var jsonStr = 'SINF:{"rendersBeforeSave":5}';
    var info = StripInfo.fromJson(jsonStr);
    expect(info.rendersBeforeSave, 5);

    var jsonStr2 = 'SINF:{}';
    var info2 = StripInfo.fromJson(jsonStr2);
    expect(info2.rendersBeforeSave, -1);
  });

  test('ThreadCount from JSON', () {
    var jsonStr = 'SINF:{"threadCount":5}';
    var info = StripInfo.fromJson(jsonStr);
    expect(info.threadCount, 5);

    var jsonStr2 = 'SINF:{}';
    var info2 = StripInfo.fromJson(jsonStr2);
    expect(info2.threadCount, 100);
  });
}
