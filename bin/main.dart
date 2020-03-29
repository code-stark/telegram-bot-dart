import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() async {
  var teledart = TeleDart(
      Telegram('1130742925:AAG9NTkhMiDomTtXqKstAL87tTvQxM55fKA'),
      Event());
  var url =
      'https://raw.githubusercontent.com/Bowserinator/Periodic-Table-JSON/master/PeriodicTableJSON.json';
  await teledart
      .start()
      .then((me) => print('${me.username} is initialised'));

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var itemCount = jsonResponse['elements'];
    teledart.onCommand('start').listen(((message) =>
        teledart.replyMessage(
            message, itemCount.toString().substring(0, 8))));
    // print('Number of books about http: $itemCount');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
 
  // teledart
  //     .onHashtag('follower')
  //     .listen((message) => teledart.replyMessage(message, filedata));
}
