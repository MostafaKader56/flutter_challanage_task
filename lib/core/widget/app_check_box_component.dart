import 'package:flutter/material.dart';

class AppCheckBoxComponent extends StatefulWidget {
  const AppCheckBoxComponent({
    super.key,
    this.initialValue = false,
    this.reversed = false,
    this.onChanged,
    required this.text,
  });

  final bool initialValue;
  final bool reversed;
  final Function(bool?)? onChanged;
  final String text;

  @override
  State<AppCheckBoxComponent> createState() => _AppCheckBoxComponentState();
}

class _AppCheckBoxComponentState extends State<AppCheckBoxComponent> {
  late bool? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> childs = [
      Checkbox(
        value: _value,
        activeColor: Theme.of(context).colorScheme.primary,
        onChanged: (value) {
          setState(() {
            _value = value;
          });
          widget.onChanged?.call(value);
        },
      ),
      Text(widget.text),
    ];
    if (widget.reversed) {
      return Row(children: childs.reversed.toList());
    } else {
      return Row(children: childs);
    }
  }
}
