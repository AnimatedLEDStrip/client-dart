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
    var sect = Section();
    expect(sect.name, '');
    expect(sect.startPixel, -1);
    expect(sect.endPixel, -1);
    expect(sect.physicalStart, -1);
    expect(sect.numLEDs, 0);
  });

  test('JSON', () {
    var sect = Section()
      ..name = 'Section'
      ..startPixel = 25
      ..endPixel = 60;

    expect(
        sect.json(), 'SECT:{"name":"Section","startPixel":25,"endPixel":60}');
  });

  test('From JSON', () {
    var jsonStr =
        'SECT:{"physicalStart":0,"numLEDs":240,"name":"sect","startPixel":0,"endPixel":239}';
    var sect = Section.fromJson(jsonStr);

    expect(sect.name, 'sect');
    expect(sect.startPixel, 0);
    expect(sect.endPixel, 239);
    expect(sect.physicalStart, 0);
    expect(sect.numLEDs, 240);
  });

  test('Name from JSON', () {
    var jsonStr = 'SECT:{"name":"Section"}';
    var sect = Section.fromJson(jsonStr);
    expect(sect.name, 'Section');

    var jsonStr2 = 'SECT:{}';
    var sect2 = Section.fromJson(jsonStr2);
    expect(sect2.name, '');
  });

  test('StartPixel from JSON', () {
    var jsonStr = 'SECT:{"startPixel":5}';
    var sect = Section.fromJson(jsonStr);
    expect(sect.startPixel, 5);

    var jsonStr2 = 'SECT:{}';
    var sect2 = Section.fromJson(jsonStr2);
    expect(sect2.startPixel, -1);
  });

  test('EndPixel from JSON', () {
    var jsonStr = 'SECT:{"endPixel":5}';
    var sect = Section.fromJson(jsonStr);
    expect(sect.endPixel, 5);

    var jsonStr2 = 'SECT:{}';
    var sect2 = Section.fromJson(jsonStr2);
    expect(sect2.endPixel, -1);
  });

  test('PhysicalStart from JSON', () {
    var jsonStr = 'SECT:{"physicalStart":5}';
    var sect = Section.fromJson(jsonStr);
    expect(sect.physicalStart, 5);

    var jsonStr2 = 'SECT:{}';
    var sect2 = Section.fromJson(jsonStr2);
    expect(sect2.physicalStart, -1);
  });

  test('NumLEDs from JSON', () {
    var jsonStr = 'SECT:{"numLEDs":5}';
    var sect = Section.fromJson(jsonStr);
    expect(sect.numLEDs, 5);

    var jsonStr2 = 'SECT:{}';
    var sect2 = Section.fromJson(jsonStr2);
    expect(sect2.numLEDs, 0);
  });
}
