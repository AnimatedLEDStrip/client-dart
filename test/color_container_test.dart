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
    var cc = ColorContainer();
    expect(cc.colors, isEmpty);
  });

  test("Add Color", () {
    var cc = ColorContainer();
    expect(cc.colors, isEmpty);
    cc.addColor(0xFF);
    cc.addColor(0xFF00);
    expect(cc.colors, isNotEmpty);
    expect(cc.colors[0], 0xFF);
    expect(cc.colors[1], 0xFF00);
  });

  test("JSON", () {
    var cc = ColorContainer()
        ..addColor(0xFF0000)
        ..addColor(0xFF00);

    expect('{"colors":[16711680, 65280]}', cc.json());
    
    var cc2 = ColorContainer();
    expect('{"colors":[]}', cc2.json());
  });
}