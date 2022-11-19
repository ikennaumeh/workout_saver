import 'dart:async';
import 'package:flutter/material.dart';


class ServiceEvent {
  ServiceEventType type;
  dynamic payload;

  ServiceEvent({required this.type, this.payload});
}


/// Update this when a new event type is added.
enum ServiceEventType {

  /// Fired when a workout is successfully added or removed
  workout
}

class ServiceEventStream<T extends ServiceEvent> {
  late StreamController<T> _streamController;

  @visibleForTesting
  bool hasListener = false;

  /// Stores events that arrive before listeners are ready.
  List<T> pendingServiceEvents = [];

  /// Optional [streamController] param is when we desire to use another
  /// type of StreamController with a different behavior.
  /// We are setting a StreamController.broadcast as the default behavior.
  ServiceEventStream() {
    _streamController = StreamController<T>.broadcast(onListen: () {
      hasListener = true;
    }, onCancel: () {
      hasListener = false;
    });
  }

  Stream<T> get stream => _streamController.stream;

  void add(T e) {
    if (!hasListener) {
      pendingServiceEvents.add(e);
      return;
    }
    _streamController.add(e);
  }

  void close() {
    if (_streamController.isClosed) return;
    _streamController.close();
  }

  StreamSubscription<T>? listen(void Function(T event) onData) {
    if (_streamController.isClosed) return null;

    while (pendingServiceEvents.isNotEmpty) {
      // Flushes any events that arrived before any listeners subscribed.
      // Note that only the first listener will receive these events.
      final event = pendingServiceEvents.removeAt(0);
      onData(event);
    }
    return stream.listen(onData);
  }

  void addStream(Stream<T> stream) async {
    await _streamController.addStream(stream);
  }
}
