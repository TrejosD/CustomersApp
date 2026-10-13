

import 'package:flutter/material.dart';

class SideOptionTile extends StatelessWidget {
  final TextStyle textStyle;
  final String initialSelection;
  final List<String> dropDownMenuExtries;
  final String title;
  final IconData icon;
  final Function onSelected;

  const SideOptionTile({
    super.key,
    required this.textStyle,
    required this.initialSelection,
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
          menuStyle: MenuStyle(
          ),
          width: 110,
          initialSelection: initialSelection, //?? 'localeList.1'.tr(),
          onSelected: (selection) async {
            // todo implementar easy location
            // final prefs = await SharedPreferences.getInstance();
            // if (locale == 'localeList.1'.tr()) {
            //   prefs.remove('locale');
            //   Restart.restartApp();
            // } else {
            //   await prefs.setString('locale', locale.toString());
            //   Restart.restartApp();
            // }
          },
          dropdownMenuEntries: dropDownMenuExtries.map((option) {
            return DropdownMenuEntry(value: option, label: option);
          }).toList(),
        ),
      ],
    );
  }
}
