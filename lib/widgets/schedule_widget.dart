import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class RallySchedule extends StatefulWidget {
  const RallySchedule({Key? key}) : super(key: key);

  @override
  State<RallySchedule> createState() => _RallyScheduleState();
}

class _RallyScheduleState extends State<RallySchedule> {
  DateTime _selectedDay = DateTime.parse("2023-06-21");
  DateTime _focusedDay = DateTime.now().isBefore(DateTime.parse("2023-06-21"))
      ? DateTime.parse("2023-06-21")
      : DateTime.now();
  ValueNotifier<List<String>>? _selectedEvents;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents!.dispose();
    super.dispose();
  }


  Map<DateTime, List<String>> schedule = {
    DateTime(2023, 6, 21): [
      "10:01: Shakedown(Loldia)",
      "13:01: Shakedown(Loldia)"
    ],
    DateTime(2023, 6, 22): [
      "12:46: Ceremonial Start(Uhuru Park)",
      "14:05: SSS1 - Kasarani"
    ],
    DateTime(2023, 6, 23): [
      "08:00: SS2 - Loldia 1",
      "09:18: SS3 - Geothermal 1",
      "10:11: SS4 - Kedong 1",
      "13:09: SS5 - Loldia 2",
      "14:27: SS6 - Geothermal 2",
      "15:20: SS7 - Kedong 2",
    ],
    DateTime(2023, 6, 24): [
      "08:01: SS8 - Soysambu 1",
      "09:05: SS9 - Elmenteita 1",
      "10:03: SS10 - Sleeping Warrior 1",
      "14:01: SS11 - Soysambu 2",
      "15:05: SS12 - Elmenteita 2",
      "16:03: SS13 - Sleeping Warrior 2",
    ],
    DateTime(2023, 6, 25): [
      "06:55: SS14 - Malewa 1",
      "07:51: SS15 - Oserian 1",
      "09:05: SS16 - Hell's Gate 1",
      "11:12: SS17 - Malewa 2",
      "12:08: SS18 - Oserian 2",
      "14:15: SS19 - Hell's Gate 2",
    ],
  };

  List<String> _getEventsForDay(DateTime day){
    return schedule[DateTime.parse(day.toString().substring(0, 10))] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents!.value = _getEventsForDay(selectedDay);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime.parse("2023-06-21"),
          lastDay: DateTime.parse("2023-06-25"),
          calendarFormat: CalendarFormat.week,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          eventLoader: _getEventsForDay,
          onDaySelected: _onDaySelected,
        ),
        const SizedBox(height: 10,),
        Expanded(
          child: ValueListenableBuilder<List<String>>(
            valueListenable: _selectedEvents!,
            builder: (BuildContext context, List<String> value, _) {
              return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index){
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        shape: Border.all(),
                        titleTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18
                        ),
                        tileColor: Colors.transparent,
                        onTap: () {},
                        title: Text(value[index]),
                      ),
                    );
                  }
              );
            },
          ),
        )
      ],
    );
  }
}
