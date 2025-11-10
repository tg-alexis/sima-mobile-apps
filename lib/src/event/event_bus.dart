import 'package:event_bus/event_bus.dart';

class EventBusInstance {
  static final EventBus _bus = EventBus();
  static EventBus get instance => _bus;
}