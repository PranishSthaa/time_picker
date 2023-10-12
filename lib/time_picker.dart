library time_picker;

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_picker/cubit/time_cubit.dart';

class CustomTimePicker extends StatefulWidget {
  final double itemExtent;
  final Widget selectionOverlay;
  final double diameterRatio;
  final Color? backgroundColor;
  final double offAxisFraction;
  final bool useMagnifier;
  final double magnification;
  final double squeeze;
  final TextStyle? selectedStyle;
  final TextStyle? unselectedStyle;
  final TextStyle? disabledStyle;
  const CustomTimePicker({
    Key? key,
    required this.itemExtent,
    this.selectedStyle,
    this.unselectedStyle,
    this.disabledStyle,
    this.backgroundColor,
    this.squeeze = 1.45,
    this.diameterRatio = 1.1,
    this.magnification = 1.0,
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.selectionOverlay = const CupertinoPickerDefaultSelectionOverlay(),
  }) : super(key: key);

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late final FixedExtentScrollController _hourScrollController;
  late final FixedExtentScrollController _minuteScrollController;
  late final FixedExtentScrollController _secondScrollController;

  @override
  void initState() {
    super.initState();
    _hourScrollController = FixedExtentScrollController();
    _minuteScrollController = FixedExtentScrollController();
    _secondScrollController = FixedExtentScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          _scrollList(_hourScrollController,
              context.read<TimeCubit>().state.selectedHr),
          _scrollList(_minuteScrollController,
              context.read<TimeCubit>().state.selectedMinus),
          _scrollList(_secondScrollController,
              context.read<TimeCubit>().state.selectedSeconds),
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeCubit, TimeState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(child: _hourSelector()),
            Expanded(child: _minuteSelector()),
            Expanded(child: _secondSelector()),
          ],
        );
      },
    );
  }

  void _scrollList(FixedExtentScrollController controller, int index) {
    controller.animateToItem(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  Widget _selector({
    required List<dynamic> values,
    required int selectedValueIndex,
    required bool Function(int) isDisabled,
    required void Function(int) onSelectedItemChanged,
    required FixedExtentScrollController scrollController,
  }) {
    return CupertinoPicker.builder(
      childCount: values.length,
      squeeze: widget.squeeze,
      itemExtent: widget.itemExtent,
      scrollController: scrollController,
      useMagnifier: widget.useMagnifier,
      diameterRatio: widget.diameterRatio,
      magnification: widget.magnification,
      backgroundColor: widget.backgroundColor,
      offAxisFraction: widget.offAxisFraction,
      selectionOverlay: widget.selectionOverlay,
      onSelectedItemChanged: onSelectedItemChanged,
      itemBuilder: (context, index) => Container(
        height: widget.itemExtent,
        alignment: Alignment.center,
        child: Text(
          '${values[index]}',
          style: index == selectedValueIndex
              ? widget.selectedStyle
              : isDisabled(index)
                  ? widget.disabledStyle
                  : widget.unselectedStyle,
        ),
      ),
    );
  }

  Widget _hourSelector() {
    return _selector(
        values: context.read<TimeCubit>().state.timeModel!.hour,
        selectedValueIndex: context.watch<TimeCubit>().state.selectedHr,
        isDisabled: (_) => false,
        onSelectedItemChanged: (index) => context
            .read<TimeCubit>()
            .onSelectedItemChanged(index, SelectorType.hour),
        scrollController: _hourScrollController);
  }

  Widget _minuteSelector() {
    return _selector(
        values: context.read<TimeCubit>().state.timeModel!.minute,
        selectedValueIndex: context.watch<TimeCubit>().state.selectedMinus,
        isDisabled: (_) => false,
        onSelectedItemChanged: (index) => context
            .read<TimeCubit>()
            .onSelectedItemChanged(index, SelectorType.minute),
        scrollController: _minuteScrollController);
  }

  Widget _secondSelector() {
    return _selector(
        values: context.read<TimeCubit>().state.timeModel!.minute,
        selectedValueIndex: context.watch<TimeCubit>().state.selectedSeconds,
        isDisabled: (_) => false,
        onSelectedItemChanged: (index) => context
            .read<TimeCubit>()
            .onSelectedItemChanged(index, SelectorType.second),
        scrollController: _secondScrollController);
  }

  @override
  void dispose() {
    _hourScrollController.dispose();
    _minuteScrollController.dispose();
    _secondScrollController.dispose();
    super.dispose();
  }
}
