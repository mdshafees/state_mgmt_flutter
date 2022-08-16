import 'package:flutter/material.dart';

class ProviderManagement extends ChangeNotifier {
  int count = 0;
  List<String> cartList = [];

  int get number => count;
  List get lists => cartList;

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    count--;
    notifyListeners();
  }

  void addList(String item) {
    cartList.add(item);
    notifyListeners();
  }

  void removeList(String item) {
    cartList.remove(item);
    notifyListeners();
  }
}

class EventProvider extends ChangeNotifier {
  List<Event> listofEvents = [];
  List<Event> selectedEvents = [];
  DateTime selectedDate = DateTime.now();

  List get events => listofEvents;
  List get dateEvents => selectedEvents;

  DateTime get getDate => selectedDate;

  void setDate(DateTime date) => selectedDate = date;

  void filterEvent(DateTime date) {
    selectedEvents = [];
    for (var i = 0; i < listofEvents.length; i++) {
      if (listofEvents[i].from.day == date.day) {
        selectedEvents.add(Event(
            title: listofEvents[i].title,
            description: listofEvents[i].description,
            from: listofEvents[i].from,
            to: listofEvents[i].to));
      }
    }
    notifyListeners();
  }

  addEvent(Event event) {
    listofEvents.add(Event(
        title: event.title,
        description: event.description,
        from: event.from,
        to: event.to));
    filterEvent(event.from);
    notifyListeners();
  }
}

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;

  const Event({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
  });
}
