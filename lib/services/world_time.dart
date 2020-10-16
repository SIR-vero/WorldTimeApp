import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;  // Location name for the UI
  String time;      //time in that location
  String flag;      //URL to flag image
  String url;       //url to time api (loc/loc)
  bool isDayTime;   //is it day or night

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try {
      //make request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offsethrs = data['utc_offset'].substring(1, 3);
      String offsetmin = data['utc_offset'].substring(4, 6);

      //create a datetime obj
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsethrs)));
      now = now.add(Duration(minutes: int.parse(offsetmin)));

      //setting time property
      isDayTime = now.hour > 6 && now.hour < 19 ? true : false ;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      time = 'Could Not Get Time';
    }

  }
}