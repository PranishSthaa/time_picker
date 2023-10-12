class TimeModel {
  final List<String> hour;
  final List<String> minute;
  final List<String> seconds;

  TimeModel({required this.hour, required this.minute, required this.seconds});

  TimeModel copyWith({
    List<String>? hour,
    List<String>? minute,
    List<String>? seconds,
  }) {
    return TimeModel(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      seconds: seconds ?? this.seconds,
    );
  }
}
