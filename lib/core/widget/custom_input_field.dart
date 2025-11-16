import 'package:flutter/material.dart';
import '../utils/size_config.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.controller,
    this.hint,
    this.icon,
    this.keyboardType,
    this.error,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String label;
  final bool isRequired;
  final String? hint;
  final String? error;
  final Widget? icon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  String? _currentError;

  @override
  void initState() {
    super.initState();
    _currentError = widget.error;
  }

  @override
  void didUpdateWidget(CustomInputField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If parent-provided error changed, reflect it in internal state
    if (widget.error != oldWidget.error && widget.error != _currentError) {
      setState(() {
        _currentError = widget.error;
      });
    }
  }

  void _onTextChanged(String value) {
    // Clear error when user starts typing
    if (_currentError != null) {
      setState(() {
        _currentError = null;
      });
    }

    // propagate to the external onChanged if provided
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.label}${widget.isRequired ? ' *' : ''}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: SizeConfig.defaultSize * 1),
        TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          onChanged: _onTextChanged,
          decoration: InputDecoration(
            // Use errorText (String?) rather than error (Widget)
            errorText: _currentError,
            hintText: widget.hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).hintColor,
            ),
            prefixIcon: widget.icon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                SizeConfig.defaultSize * 1.25,
              ),
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
          ),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
