import 'package:flutter/material.dart';
import '../utils/size_config.dart';

class CustomPasswordInputField extends StatefulWidget {
  const CustomPasswordInputField({
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
  final IconData? icon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  State<CustomPasswordInputField> createState() =>
      _CustomPasswordInputFieldState();
}

class _CustomPasswordInputFieldState extends State<CustomPasswordInputField> {
  String? _currentError;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _currentError = widget.error;
  }

  @override
  void didUpdateWidget(CustomPasswordInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update error when widget updates
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

    // Call the original onChanged callback if provided
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
          obscureText: _obscureText,
          decoration: InputDecoration(
            error: _currentError != null
                ? Text(_currentError!, style: TextStyle(color: Colors.red))
                : null,
            hintText: widget.hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).hintColor,
            ),
            suffixIcon: IconButton(
              // iconSize: SizeConfig.defaultSize,
              // padding: EdgeInsets.all(0),
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            prefixIcon: widget.icon != null
                ? Icon(widget.icon, color: Theme.of(context).iconTheme.color)
                : null,
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
