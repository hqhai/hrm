import 'package:flutter/material.dart';

class SideMenuTile extends StatelessWidget {
  final String text;
  final Widget icon;
  final bool checkSelect;
  final VoidCallback onTap;

  const SideMenuTile(
      {super.key, required this.text, required this.icon, required this.checkSelect, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          width: checkSelect? MediaQuery.of(context).size.width * 1 : 0,
          child: Container(
            height: 70,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color:  Color(0xff8ba5e8),
            ),
          ),
        ),
        ListTile(
          onTap: onTap,
          leading: icon,
          title: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }
}