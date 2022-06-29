import 'package:flutter/material.dart';

class ContactMe extends StatelessWidget {
  const ContactMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700.0,
      color: Colors.pink[30],
      child: const Center(
        child: Text("Contact Me section"),
      ),
    );
  }
}
