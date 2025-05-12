import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:memoiree/app/configs/global.dart';
import 'package:memoiree/app/notification_service.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum CalendarView { loading, loaded, error }

class CalendarController extends GetxController {
  var calendarView = CalendarView.loading.obs;
  List<EventsModel> calendarEvents = [];
  Rx<DateTime> datetime = Rx<DateTime>(DateTime.now());
  DateTime selectedDay = DateTime.now();
  RxList<EventsModel> events = <EventsModel>[].obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;

  var title = TextEditingController(text: "sample");
  var description = TextEditingController(text: "sample desc");

  @override
  void onInit() async {
    await loadEvents();
    calendarView(CalendarView.loaded);

    super.onInit();
  }

  loadEvents() async {
    var res = await GetConnect().get(
      "${GlobalConfigs.baseUrl}event-by-creator/${GlobalConfigs.settings.user!.id}",
    );

    if (res.statusCode == 200) {
      calendarEvents =
          res.body['events']
              .map<EventsModel>((event) => EventsModel.fromJson(event))
              .toList();
    }
    print(res.body);
  }

  upsertEvent(context, {id}) async {
    var notificationService = NotificationService();

    var res = await GetConnect()
        .post("${GlobalConfigs.baseUrl}event/${id ?? ""}", {
          'title': title.text,
          'description': description.text,
          'datetime': datetime.value.toIso8601String(),
          'created_by': GlobalConfigs.settings.user!.id,
        });

    notificationService.scheduleReminder(
      title: title.text,
      scheduledDate: datetime.value,
      id: res.body['events']['id'],
      body: description.text,
    );

    // await loadEvents();
    Navigator.pop(context);
  }

  changeEvents(DateTime date) {
    events.clear();
    events.value =
        calendarEvents.where((e) => e.datetime.isSameDay(date)).toList();
  }

  deleteEvent(id) async {
    var res = GetConnect().get("${GlobalConfigs.baseUrl}delete-event/$id");
    await loadEvents();
    changeEvents(selectedDay);
  }
}

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalendarController());
  }
}

class EventsModel {
  int id;
  String title;
  String description;
  DateTime datetime;
  EventsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.datetime,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      datetime: DateTime.parse(json['datetime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'datetime': datetime.toIso8601String(),
    };
  }
}
