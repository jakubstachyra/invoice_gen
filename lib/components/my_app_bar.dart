import 'package:flutter/material.dart';
import 'package:invoice_gen/components/buttons/my_icon_button.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.callback,
    required this.text,
  });

  final VoidCallback callback;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: MyIconButton(callback: callback),
      centerTitle: true,
      title: text,
      toolbarHeight: 100,
      foregroundColor: Colors.blue[900],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100); // Ustaw wysokość AppBar
}
