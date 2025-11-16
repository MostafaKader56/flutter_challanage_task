import 'package:flutter/material.dart';

import '../model/custom_dropdown_item.dart';

/// Generic CustomDropDown Widget using type parameter T.
class CustomDropDown<T> extends StatefulWidget {
  const CustomDropDown({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
    required this.onItemSelected,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 4,
    ),
    this.isFilled,
    this.fillColor,
    this.initialSelectedIndex,
    this.value,
  });

  final String label;
  final String hint;
  final List<CustomDropdownItem<T>> items;
  final Function(CustomDropdownItem<T>?) onItemSelected;
  final EdgeInsetsGeometry contentPadding;
  final bool? isFilled;
  final Color? fillColor;
  final int? initialSelectedIndex;
  final CustomDropdownItem<T>? value;

  @override
  State<CustomDropDown<T>> createState() => CustomDropDownState<T>();
}

class CustomDropDownState<T> extends State<CustomDropDown<T>> {
  CustomDropdownItem<T>? selectedItem;

  @override
  void initState() {
    super.initState();
    _updateSelected(); // initial pass
  }

  @override
  void didUpdateWidget(CustomDropDown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // items just arrived or initial index changed:
    if (widget.items != oldWidget.items ||
        widget.initialSelectedIndex != oldWidget.initialSelectedIndex) {
      _updateSelected();
    }
  }

  void _updateSelected() {
    final idx = widget.initialSelectedIndex;
    if (idx != null && idx >= 0 && idx < widget.items.length) {
      setState(() => selectedItem = widget.items[idx]);
    }
  }

  void changeSelectedItem(T newSelectedItemId) {
    for (var item in widget.items) {
      if (item.id == newSelectedItemId) {
        setState(() {
          selectedItem = item;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          border: const OutlineInputBorder(),
          contentPadding: widget.contentPadding,
          hintText: widget.hint,
          filled: widget.isFilled,
          fillColor: widget.fillColor,
          suffixIconConstraints: const BoxConstraints(
            minHeight: 30,
            minWidth: 30,
          ),
          suffixIcon: selectedItem != null
              ? InkWell(
                  onTap: () {
                    setState(() {
                      selectedItem = null;
                    });
                    widget.onItemSelected(null);
                  },
                  child: const Icon(Icons.clear, size: 20, color: Colors.red),
                )
              : null,
        ),
        child: DropdownButton<CustomDropdownItem<T>>(
          value: selectedItem,
          isExpanded: true,
          hint: Text(widget.hint),
          items: widget.items.map((item) {
            return DropdownMenuItem<CustomDropdownItem<T>>(
              value: item,
              child: Text(item.text),
            );
          }).toList(),
          onChanged: (item) {
            if (item != null) {
              setState(() {
                selectedItem = item;
              });
              widget.onItemSelected(item);
            }
          },
        ),
      ),
    );
  }
}
