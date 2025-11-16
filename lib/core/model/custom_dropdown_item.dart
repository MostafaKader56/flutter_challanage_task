class CustomDropdownItem<T> {
  final T id;
  final String text;

  const CustomDropdownItem({required this.id, required this.text});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomDropdownItem<T> &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
