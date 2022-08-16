import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventCalander extends StatelessWidget {
  const EventCalander({super.key});
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).listofEvents;
    var date = DateTime.now();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              height: MediaQuery.of(context).size.height / 1.5,
              child: SfCalendar(
                dataSource: EventDataSource(events),
                view: CalendarView.month,
                onTap: (detail) {
                  context.read<EventProvider>().setDate(detail.date!);
                  context.read<EventProvider>().filterEvent(detail.date!);
                },
              ),
            ),
            context.watch<EventProvider>().dateEvents.isEmpty
                ? Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      "No Events",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: context.watch<EventProvider>().dateEvents.length,
                    itemBuilder: (context, index) {
                      var event =
                          context.watch<EventProvider>().dateEvents[index];
                      return Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          padding: EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(event.title),
                            subtitle: Text(event.description),
                            trailing: Text(
                                "${DateFormat("hh:mm a").format(event.from)} - ${DateFormat("hh:mm a").format(event.to)}"),
                          ));
                    })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => context.read<EventProvider>().addEvent(Event(
            title: "New Task",
            description: "Fix Bugs ASAP",
            from: Provider.of<EventProvider>(context, listen: false).getDate,
            to: Provider.of<EventProvider>(context, listen: false)
                .getDate
                .add(const Duration(hours: 2)))),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> allEvents) {
    appointments = allEvents;
  }
  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).title;
}
