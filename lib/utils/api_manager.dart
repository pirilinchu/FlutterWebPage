import 'package:auditore_v4/widgets/contact_me.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  static var shared = ApiManager();

  Future<void> sendMessage(Message message) async {
    final http.Response response = await http.post(
      Uri.parse(
          'https://api.callmebot.com/whatsapp.php?phone=+59167406455&text=${message.format()}&apikey=619163'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
