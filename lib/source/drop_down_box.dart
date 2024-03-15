import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final int? selectedValue;
  final ValueChanged<int?>? onChanged;

  MyDropdown({Key? key, required this.selectedValue, this.onChanged})
      : super(key: key);

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: widget.selectedValue,
      onChanged: (int? newValue) {
        setState(() {
          if (newValue != null) {
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          }
        });
      },
      items: List.generate(
        10,
        (index) => DropdownMenuItem(
          value: index + 1,
          child: Text(' ${index + 1}'),
        ),
      ),
    );
  }
}
