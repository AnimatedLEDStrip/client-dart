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

import 'package:mutex/mutex.dart';
import 'package:animatedledstrip/src/animation_data.dart';


class RunningAnimationMap {
  final Map _runningAnimations = Map();
  final ReadWriteMutex _mux = ReadWriteMutex();

  void put(AnimationData data) async {
    await _mux.acquireWrite();
    _runningAnimations[data.id] = data;
    _mux.release();
  }

  void putWithId(String id, AnimationData data) async {
    await _mux.acquireWrite();
    _runningAnimations[id] = data;
    _mux.release();
  }
  
  Future<AnimationData> get(String id) async {
    await _mux.acquireRead();
    var data = _runningAnimations[id];
    _mux.release();
    return data;
  }
  
  void delete(String id) async {
    await _mux.acquireWrite();
    _runningAnimations.remove(id);
    _mux.release();
  }

  Future<List<dynamic>> ids() async {
    await _mux.acquireRead();
    var ids = _runningAnimations.keys.toList();
    _mux.release();
    return ids;
  }

  void clear() async {
    await _mux.acquireWrite();
    _runningAnimations.clear();
    _mux.release();
  }
}