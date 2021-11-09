import 'package:flutter/material.dart';
import 'package:siepex/src/eventos/geral/geralView.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
//import 'package:url_launcher/url_launcher.dart'

class GeralPage extends StatelessWidget {
  const GeralPage({Key key}) : super(key: key);

/*class GeralPage extends StatefulWidget {
  @override
  _GeralPageState createState() => _GeralPageState();
}

class _GeralPageState extends State<GeralPage> {

  DateTime selectedDay;
  List <CleanCalendarEvent> selectedEvent;

  final Map<DateTime,List<CleanCalendarEvent>> events = {
    DateTime (DateTime.now().year,DateTime.now().month,DateTime.now().day):
    [
      CleanCalendarEvent('Evento A',
          startTime: DateTime(
              DateTime.now().year,DateTime.now().month,DateTime.now().day,10,0),
          endTime:  DateTime(
              DateTime.now().year,DateTime.now().month,DateTime.now().day,12,0),
          description: 'reunião',
          url:'https://www.youtube.com/watch?v=DEDxTZhdbAs',
          color: Colors.blue[700],
          ),


    ],

    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
    [
      CleanCalendarEvent('Evento C',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 12, 0),
          color: Colors.orange),
      CleanCalendarEvent('Evento D',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.pink),
    ],
  };

  void _handleData(date){
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
    });
    print(selectedDay);
    //print(DateFormat.yMMMd('pt_BR').format(DateTime.now()));
  }
  @override
  void initState() {
    // TODO: implement initState
    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda do Evento'),
        //centerTitle: true,
      ),
      body:  SafeArea(
        child: Container(
          child: Calendar(
            locale: 'pt_BR',
            startOnMonday: true,
            selectedColor: Colors.blue,
            todayColor: Colors.red,
            eventColor: Colors.green,
            eventDoneColor: Colors.amber,
            bottomBarColor: Colors.deepOrange,
            onRangeSelected: (range) {
              print('selected Day ${range.from},${range.to}');
            },
            onDateSelected: (date){
              return _handleData(date);

            },
            events: events,
            isExpanded: true,
            dayOfWeekStyle: TextStyle(
              fontSize: 15,
              color: Colors.black12,
              fontWeight: FontWeight.w100,
            ),
            bottomBarTextStyle: TextStyle(
              color: Colors.white,
            ),
            hideBottomBar: false,
            hideArrows: false,
            weekDays: ['Seg','Ter','Qua','Qui','Sex','Sab','Dom'],
          ),
        ),
      ),
    );
  }
}*/

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda do evento"),
        centerTitle: true,

      ),
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 0,
        //initialDisplayDate: DateTime(2021, 09, 25, 10, 00),
        //initialSelectedDate: DateTime(2021, 09, 25, 10, 00),
        dataSource: MeetingDataSource(getAppointments()),
      ),
    );
  }


}
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

List<Appointment> getAppointments(){
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, 12, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Siepex Reunião',
      color: Colors.blue));

  return meetings;

}*/


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Agenda do evento'),
            bottom: tabs(),
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/img/arte_uergs/Background_App_Siepex.png'),
                      fit: BoxFit.cover)),
              child: TabBarView(
                children: <Widget>[
                  ListagemGeral(dia: "26/06/2019"),
                  ListagemGeral(dia: "27/06/2019"),
                  ListagemGeral(dia: "28/06/2019"),
                ],
              )),
        ));
  }

  Widget tabs() {
    return TabBar(indicatorColor: Colors.white, tabs: [
      Tab(child: Text("26/06")),
      Tab(child: Text("27/06")),
      Tab(child: Text("28/06"))
    ]);
  }
}
