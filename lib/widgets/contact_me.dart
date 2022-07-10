import 'package:auditore_v4/constants.dart';
import 'package:auditore_v4/utils/api_manager.dart';
import 'package:flutter/material.dart';

import '../utils/extensions.dart';

class ContactMe extends StatefulWidget {
  const ContactMe({Key? key}) : super(key: key);

  @override
  State<ContactMe> createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Message message = Message();
  double spacerSize = 10.0;
  bool messageSent = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 780.0,
      color: Colors.blueGrey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Center(
              child: Text(
                ContactMeInfo.TITLE,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: HexColor.fromHex(PageColors.CONTACT_US_TITLE_COLOR),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              width: 500,
              margin: const EdgeInsets.all(30.0),
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
              child: Column(children: [
                Container(
                  height: 130,
                  child: Center(
                    child: Text(
                      ContactMeInfo.BODY,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nombre',
                          ),
                          onChanged: (text) {
                            setState(() {
                              message.name = text;
                              messageSent = false;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa tu nombre';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: spacerSize,
                        ),
                        TextFormField(
                          controller: mailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Correo',
                          ),
                          onChanged: (text) {
                            setState(() {
                              message.mail = text;
                              messageSent = false;
                            });
                          },
                          validator: (value) {
                            if (value != null) {
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return 'Por favor ingresa un correo valido';
                              }
                              return null;
                            }
                            return 'Por favor ingresa tu correo';
                          },
                        ),
                        SizedBox(
                          height: spacerSize,
                        ),
                        TextFormField(
                          controller: messageController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mensaje',
                          ),
                          minLines: 4,
                          maxLines: 4,
                          onChanged: (text) {
                            setState(() {
                              message.message = text;
                              messageSent = false;
                            });
                          },
                        ),
                        SizedBox(
                          height: spacerSize,
                        ),
                        TextButton(
                          child: Text("Enviar"),
                          style: TextButton.styleFrom(
                            fixedSize: Size(100.0, 40.0),
                            primary: Colors.white,
                            backgroundColor:
                                HexColor.fromHex(PageColors.BUTTON_COLOR),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              message.sendMessage();
                              setState(() {
                                message.resetMessage();
                                nameController.clear();
                                mailController.clear();
                                messageController.clear();
                                messageSent = true;
                              });
                            }
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            messageSent ? "Mensaje Enviado" : "",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  String name = "";
  String mail = "";
  String message = "";

  void sendMessage() {
    print("Message sent!");
    ApiManager.shared.sendMessage(this);
  }

  void resetMessage() {
    name = "";
    mail = "";
    message = "";
  }

  String format() {
    String formattedMessage =
        "$name tiene un mensaje para ti:\n$message\ncorreo: $mail";
    formattedMessage = Uri.encodeComponent(formattedMessage);
    print(formattedMessage);
    return formattedMessage;
  }
}
