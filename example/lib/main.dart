import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_picker/cubit/time_cubit.dart';
import 'package:time_picker/time_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimeCubit>(
      create: (context) => TimeCubit()..initValues(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Time Picker Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Time Picker Example'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selected Time: ' +
                context.watch<TimeCubit>().state.selectedTime),
            TextButton(
              onPressed: () {
                context.read<TimeCubit>().setInitDate();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Set time'),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      actions: [
                        MaterialButton(
                          color: Colors.redAccent,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 0.0,
                          onPressed: () {
                            String hour = context
                                .read<TimeCubit>()
                                .state
                                .selectedHr
                                .toString();
                            String minute = context
                                .read<TimeCubit>()
                                .state
                                .selectedMinus
                                .toString();
                            String second = context
                                .read<TimeCubit>()
                                .state
                                .selectedSeconds
                                .toString();
                            context
                                .read<TimeCubit>()
                                .setTime(hour, minute, second);
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        )
                      ],
                      content: SizedBox(
                        height: 200.0,
                        child: CustomTimePicker(
                          itemExtent: 50,
                          // selectedTime:
                          //     context.read<TimeCubit>().state.selectedTime,
                          selectionOverlay: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: const BoxDecoration(
                              border: Border.symmetric(
                                horizontal:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                            ),
                          ),
                          selectedStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                          unselectedStyle: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 18,
                          ),
                          disabledStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text("Click to open time picker"),
            ),
          ],
        ),
      ),
    );
  }
}
