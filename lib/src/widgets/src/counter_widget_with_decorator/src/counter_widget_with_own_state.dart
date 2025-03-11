import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class CounterWidgetWithDecoratorWithOwnState extends StatefulWidget {
  final int value;
  final int step;
  final int minValue;
  final int maxValue;
  final void Function(int) onValueChanged;
  final String labelText;

  const CounterWidgetWithDecoratorWithOwnState({
    super.key,
    required this.value,
    required this.step,
    required this.minValue,
    required this.maxValue,
    required this.onValueChanged,
    required this.labelText,
  });

  @override
  State<CounterWidgetWithDecoratorWithOwnState> createState() =>
      _CounterWidgetWithDecoratorWithOwnStateState();
}

class _CounterWidgetWithDecoratorWithOwnStateState
    extends State<CounterWidgetWithDecoratorWithOwnState> {
  late TextEditingController _controller;
  final focus = FocusNode();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
  }

  void _updateValue(int delta) {
    final newValue = int.tryParse(_controller.text) ?? widget.value;
    final updatedValue = newValue + delta;
    if (updatedValue >= widget.minValue && updatedValue <= widget.maxValue) {
      setState(() {
        _controller.text = updatedValue.toString();
        widget.onValueChanged(updatedValue);
      });
    }
  }

  void _startLongPress(int delta) {
    _updateValue(delta);

    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      _updateValue(delta);
    });
  }

  void _stopLongPress() {
    _timer?.cancel();
  }

  void _onManualInput(String value) {
    final intValue = int.tryParse(value);
    if (intValue != null &&
        intValue >= widget.minValue &&
        intValue <= widget.maxValue) {
      widget.onValueChanged(intValue);
    } else {
      // Вернуть предыдущее значение, если ввод некорректен
      _controller.text = widget.value.toString();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: widget.labelText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTapDown: (_) => _startLongPress(-widget.step),
            onTapUp: (_) => _stopLongPress(),
            onTapCancel: _stopLongPress,
            child: IconButton(
              onPressed: () => _updateValue(-widget.step),
              icon: const Icon(Icons.remove),
              color: Theme.of(context).colorScheme.primary,
              visualDensity: VisualDensity.compact,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              focusNode: focus,
              onTapOutside: (_) {
                focus.unfocus();
              },
              style: const TextStyle(fontSize: 13.0),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                labelStyle: TextStyle(fontSize: 12.0),
              ),
              onFieldSubmitted: _onManualInput,
              onEditingComplete: () => FocusScope.of(context).unfocus(),
            ),
          ),
          GestureDetector(
            onTapDown: (_) => _startLongPress(widget.step),
            onTapUp: (_) => _stopLongPress(),
            onTapCancel: _stopLongPress,
            child: IconButton(
              onPressed: () => _updateValue(widget.step),
              icon: const Icon(Icons.add),
              color: Theme.of(context).colorScheme.primary,
              visualDensity: VisualDensity.compact,
            ),
          ),
        ],
      ),
    );
  }
}
