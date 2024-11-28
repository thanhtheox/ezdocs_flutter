import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final List<String> items;
  final String selectedItem;
  final Color backgroundColor;
  final Color textColor;
  final double? width; // Thêm thuộc tính width
  final double? height;

  const Dropdown({super.key, 
    required this.items,
    required this.selectedItem,
    required this.backgroundColor,
    required this.textColor,
    this.width, // Khai báo width là tùy chọn
    this.height, // 
  });

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        icon: Icon(Icons.arrow_drop_down, color: widget.textColor),
        iconSize: 24,
        underline: const SizedBox(), // Xóa gạch chân mặc định
        style: TextStyle(color: widget.textColor, fontSize: 16),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
