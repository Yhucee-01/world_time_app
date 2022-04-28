import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // this is the name of the location for the UI
  String time; // this is the time of the location
  String flag; //url to asset flag icon
  String url; //location for url endpoint
  bool isDaytime; //check whether or not it is daytime

  WorldTime({this.location = '', this.flag = '', this.url = '', this.time = '', this.isDaytime = true});

  Future<void> getTime() async {
    try {
      // make the request
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map res = jsonDecode(response.body);
      //print(data);

      //get information from the data
      String datetime = res['datetime'];
      String offset = res['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      //create a datetime object
      DateTime thisMoment = DateTime.parse(datetime);
      thisMoment = thisMoment.add(Duration(hours: int.parse(offset)));
      //print(thisMoment);

      isDaytime = thisMoment.hour > 6 && thisMoment.hour < 19 ? true : false;
      time = DateFormat.jm().format(thisMoment);
    } catch (error) {
      print('caught error $error');
      time = 'Could not get time data';
    }
  }
}
