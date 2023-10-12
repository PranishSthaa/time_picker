import 'package:bloc/bloc.dart';
import 'package:time_picker/models/time_model.dart';

part 'time_state.dart';

enum SelectorType { hour, minute, second }

class TimeCubit extends Cubit<TimeState> {
  TimeCubit()
      : super(TimeState(
            selectedHr: DateTime.now().hour,
            selectedMinus: DateTime.now().minute,
            selectedSeconds: DateTime.now().second));

  void setInitDate() {
    emit(state.copyWith(
        selectedHr: DateTime.now().hour,
        selectedMinus: DateTime.now().minute,
        selectedSeconds: DateTime.now().second));
  }

  void setTime(String hour, String min, String sec) {
    print('$hour:$min:$sec');
    emit(state.copyWith(selectedTime: '$hour:$min:$sec'));
  }

  void onSelectedItemChanged(int index, SelectorType type) {
    DateTime temp = DateTime.now();

    switch (type) {
      case SelectorType.hour:
        temp = DateTime(temp.year, temp.month, temp.day, index,
            state.selectedMinus, state.selectedSeconds);
        break;
      case SelectorType.minute:
        temp = DateTime(temp.year, temp.month, temp.day, state.selectedHr,
            index, state.selectedSeconds);
        break;
      case SelectorType.second:
        temp = DateTime(temp.year, temp.month, temp.day, state.selectedHr,
            state.selectedMinus, index);
        break;
    }
    emit(state.copyWith(
        selectedHr: temp.hour,
        selectedMinus: temp.minute,
        selectedSeconds: temp.second));
  }

  initValues() {
    final List<String> _hours = [
      '00',
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23'
    ];
    final List<String> _minutes = [
      '00',
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
      '31',
      '32',
      '33',
      '34',
      '35',
      '36',
      '37',
      '38',
      '39',
      '40',
      '41',
      '42',
      '43',
      '44',
      '45',
      '46',
      '47',
      '48',
      '49',
      '50',
      '51',
      '52',
      '53',
      '54',
      '55',
      '56',
      '57',
      '58',
      '59'
    ];
    final List<String> _seconds = [
      '00',
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
      '31',
      '32',
      '33',
      '34',
      '35',
      '36',
      '37',
      '38',
      '39',
      '40',
      '41',
      '42',
      '43',
      '44',
      '45',
      '46',
      '47',
      '48',
      '49',
      '50',
      '51',
      '52',
      '53',
      '54',
      '55',
      '56',
      '57',
      '58',
      '59'
    ];
    emit(state.copyWith(
        timeModel:
            TimeModel(hour: _hours, minute: _minutes, seconds: _seconds)));
  }
}
