import 'package:flutter/material.dart';

class SideOptionTile extends StatelessWidget {
  final TextStyle textStyle;
  final String initialSelection;
  final String hintText;
  final List<Map<String, String>> dropDownMenuExtries;
  final String title;
  final IconData icon;
  final Function onSelected;

  const SideOptionTile({
    super.key,
    required this.textStyle,
    required this.initialSelection,
    required this.hintText,
    required this.dropDownMenuExtries,
    required this.title,
    required this.icon,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 10),
        Text(title, style: textStyle),
        Spacer(),
        DropdownMenu(
          menuStyle: MenuStyle(),
          hintText: hintText,
          width: 130,
          initialSelection: initialSelection,
          onSelected: (selection) => onSelected(selection),
          dropdownMenuEntries: dropDownMenuExtries.map((option) {
            return DropdownMenuEntry(
              value: option['value'],
              label: option['label'] ?? '',
            );
          }).toList(),
        ),
      ],
    );
  }
}
