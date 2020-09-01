# AnimatedLEDStrip Client Library for Dart

[![Build Status](https://travis-ci.com/AnimatedLEDStrip/client-dart.svg?branch=master)](https://travis-ci.com/AnimatedLEDStrip/client-dart)
[![pub package](https://img.shields.io/pub/v/animatedledstripclient.svg)](https://pub.dev/packages/animatedledstripclient)
[![codecov](https://codecov.io/gh/AnimatedLEDStrip/AnimatedLEDStripClient/branch/master/graph/badge.svg?flag=dart)](https://codecov.io/gh/AnimatedLEDStrip/AnimatedLEDStripClient)

## Creating an `AnimationSender`
An `AnimationSender` is constructed with two arguments:
- `host`: The IP address of the server (as a string)
- `port`: The port that the client should connect to (as an integer)

```dart
var sender = AnimationSender("10.0.0.254", 5);
```

## Starting the `AnimationSender`
An `AnimationSender` is started by calling the `start()` method on the instance.

```dart
await sender.start();    // Note that this requires your 
                         // method to have the async keyword
```

## Stopping the `AnimationSender`
To stop the `AnimationSender`, call its `end()` method.

```dart
sender.end();
```

## Sending Data
An animation can be sent to the server by creating an `AnimationData` instance, then calling `sendAnimation` with the instance as the argument.

```dart
var cc = ColorContainer()
  ..addColor(0xFF)
  ..addColor(0xFF00);

var data = AnimationData()
  ..addColor(cc);

sender.sendAnimation(data);
```

#### `AnimationData` type notes
The Dart library uses the following values for `continuous` and `direction`:
- `continuous`: `null`, `true`, `false`
- `direction`: `Direction.FORWARD`, `Direction.BACKWARD`

## Receiving Data
Received animations are saved to `running_animations`, which is a `RunningAnimationMap` (which is a thread-safe map).

To retrieve an animation, use
```dart
var anim = await sender.running_animations.get(ID);
```
where `ID` is the string ID of the animation.

To get a list of all animation IDs, use
```dart
var ids = await sender.running_animations.ids();
```

