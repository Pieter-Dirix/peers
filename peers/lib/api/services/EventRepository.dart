import 'package:peers/api/services/BaseService.dart';
import 'package:peers/api/services/EventService.dart';
import 'package:peers/models/Event.dart';
import 'package:peers/util/DBHelper.dart';

DBHelper localDB = DBHelper();

class EventRepository {
  BaseService _eventService = EventService();

  Future<List> getEvents(String userId, List<String> tags) async {
    print('/getevents/$userId');
    try {

      dynamic response = await _eventService.getResponse('/getevents/$userId');
      print(response);
      List events = response['events'].map((event) => Event.fromJson(event)).toList();
      return events;
    } catch (e) {
      print(e.toString());
      throw "getting events failed";
    }
  }

  Future<Event> addEvent(Map<String, dynamic> event) async{

    try {
      dynamic response = await _eventService.postRequest("/addevent", event);

      Event result = Event.fromJson(response);
      return result;
    } catch (e) {
      print(e.toString());
      throw "add event failed";
    }

  }
}
