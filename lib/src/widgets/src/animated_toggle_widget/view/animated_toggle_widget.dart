import 'package:flutter/material.dart';

import '../animated_toggle_widget.dart';

class AnimatedToggleWidget<T> extends StatefulWidget {
  final T initialValue;
  final void Function(T value) onChanged;
  final List<AnimatedToggleWidgetItem<T>> items;
  final AnimatedToggleWidgetProps props;

  const AnimatedToggleWidget({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.items,
    required this.props,
  }) : assert(items.length > 1, 'Items count should be at least 2');

  @override
  State<AnimatedToggleWidget<T>> createState() =>
      _AnimatedToggleWidgetState<T>();
}

class _AnimatedToggleWidgetState<T> extends State<AnimatedToggleWidget<T>> {
  late T selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    selectedValue = widget.props.selectedValue ?? selectedValue;
    return LayoutBuilder(
      builder: (context, constraints) {
        final buttonWidth =
            (constraints.maxWidth - widget.props.padding.horizontal * 2) /
                widget.items.length;

        return Container(
          height: widget.props.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.props.cornerRadius),
            color: Theme.of(context).colorScheme.secondary,
          ),
          padding: widget.props.padding,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedAlign(
                alignment: Alignment(
                  -1 +
                      (2 *
                          widget.items
                              .indexWhere((el) => el.value == selectedValue) /
                          (widget.items.length - 1)),
                  0,
                ),
                duration: widget.props.animationDuration,
                child: Container(
                  height: widget.props.height - widget.props.padding.vertical,
                  width: buttonWidth,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(widget.props.innerCornerRadius),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Row(
                children: widget.items.map((item) {
                  final isSelected = item.value == selectedValue;
                  return Expanded(
                    child: InkWell(
                      onTap: item.isDisabled
                          ? null
                          : () {
                              if (isSelected) return;
                              setState(() => selectedValue = item.value);
                              widget.onChanged(selectedValue);
                            },
                      child: Center(
                        child: Text(
                          item.title,
                          style: item.textStyle ??
                              widget.props.textStyle ??
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: item.isDisabled
                                        ? Theme.of(context).disabledColor
                                        : Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
