// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unnecessary_brace_in_string_interps, avoid_print
import 'package:auditore_v4/constants.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  List<bool> items = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Values.PAGE_PADING),
      color: Colors.black,
      width: double.infinity,
      child: Row(children: [
        Expanded(child: Text("Auditore S.R.L.")),
        NavbarItem(
            key: UniqueKey(),
            title: "Home",
            isEnabled: items[0],
            onButtonPressed: (isEnabled) {
              setState(() {
                items = [false, false, false, false];
                items[0] = isEnabled;
                print(items);
              });
            }),
        NavbarItem(
            key: UniqueKey(),
            title: "Servicios",
            isEnabled: items[1],
            onButtonPressed: (isEnabled) {
              setState(() {
                items = [false, false, false, false];
                items[1] = isEnabled;
                print(items);
              });
            }),
        NavbarItem(
            key: UniqueKey(),
            title: "Publicaciones",
            isEnabled: items[2],
            onButtonPressed: (isEnabled) {
              setState(() {
                items = [false, false, false, false];
                items[2] = isEnabled;
                print(items);
              });
            }),
        NavbarItem(
            key: UniqueKey(),
            title: "Contacto",
            isEnabled: items[3],
            onButtonPressed: (isEnabled) {
              setState(() {
                items = [false, false, false, false];
                items[3] = isEnabled;
                print(items);
              });
            }),
      ]),
    );
  }
}

class NavbarItem extends StatefulWidget {
  final String title;
  final bool isEnabled;
  final Function(bool) onButtonPressed;
  const NavbarItem(
      {required Key key,
      required this.title,
      required this.isEnabled,
      required this.onButtonPressed})
      : super(key: key);

  @override
  State<NavbarItem> createState() => _NavbarItemState();
}

class _NavbarItemState extends State<NavbarItem> {
  late bool isEnabled = widget.isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: TextButton(
          onPressed: () {
            setState(() {
              if (isEnabled) return;
              isEnabled = !isEnabled;
              widget.onButtonPressed(isEnabled);
            });
          },
          child: Text(widget.title,
              style:
                  TextStyle(color: isEnabled ? Colors.orange : Colors.white)),
        ));
  }
}
