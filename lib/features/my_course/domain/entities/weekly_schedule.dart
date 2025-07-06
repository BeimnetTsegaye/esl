class WeeklySchedule {
  final Map<String, List<ScheduleEntry>> schedule;

  WeeklySchedule({required this.schedule});

  factory WeeklySchedule.fromJson(Map<String, dynamic> json) {
    final schedule = <String, List<ScheduleEntry>>{};
    json.forEach((day, entries) {
      schedule[day] = (entries as List)
          .map((entry) => ScheduleEntry.fromJson(entry as Map<String, dynamic>))
          .toList();
    });
    return WeeklySchedule(schedule: schedule);
  }
}

class ScheduleEntry {
  final String id;
  final String timeSlot;
  final String dayOfWeek;
  final String course;

  ScheduleEntry({
    required this.id,
    required this.timeSlot,
    required this.dayOfWeek,
    required this.course,
  });

  factory ScheduleEntry.fromJson(Map<String, dynamic> json) {
    return ScheduleEntry(
      id: json['id'] as String,
      timeSlot: json['timeSlot'] as String,
      dayOfWeek: json['dayOfWeek'] as String,
      course: json['course']['title'] as String,
    );
  }
}
