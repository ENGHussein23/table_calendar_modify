import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Table Calendar Demo',
      home: CalendarPage(),
    );
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}
class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<DateTime> _markedDates = [
    DateTime(2023, 6, 1),
    DateTime(2023, 6, 5),
    DateTime(2023, 6, 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Calendar Demo'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2021),
            lastDay: DateTime(2025),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            selectedDayPredicate: (day) {
              return _selectedDay == day;
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getEvents,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.rectangle,
              ),
              markerDecoration: BoxDecoration(
                color: Color.fromARGB(100, 255, 0, 0),
                shape: BoxShape.rectangle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
              ),
                markersAnchor: 1,
              markerSize: 42
            ),
          ),
          SizedBox(height: 20),
          Text('Selected Day: ${_selectedDay.toString()}'),
        ],
      ),
    );
  }

  List<DateTime> _getEvents(DateTime day) {
    if (_markedDates.contains(day)) {
      return [day];
    } else {
      return _markedDates.where((date) => date.day == day.day && date.month == day.month && date.year == day.year).toList();
    }
  }
}