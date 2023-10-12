part of 'time_cubit.dart';

class TimeState {
  final TimeModel? timeModel;
  final int selectedHr;
  final int selectedMinus;
  final int selectedSeconds;
  final dynamic selectedTime;

  TimeState({
    this.selectedTime = "",
    this.timeModel,
    required this.selectedHr,
    required this.selectedMinus,
    required this.selectedSeconds,
  });

  TimeState copyWith({
    TimeModel? timeModel,
    int? selectedHr,
    int? selectedMinus,
    int? selectedSeconds,
    dynamic selectedTime,
  }) {
    return TimeState(
      timeModel: timeModel ?? this.timeModel,
      selectedHr: selectedHr ?? this.selectedHr,
      selectedMinus: selectedMinus ?? this.selectedMinus,
      selectedSeconds: selectedSeconds ?? this.selectedSeconds,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }
}
