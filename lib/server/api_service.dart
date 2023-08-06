import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getCohereOutput(String input) async {
  final url = Uri.parse('http://127.0.0.1:5000/cohere');
  final headers = {'Content-Type': 'application/json'};
  final body = json.encode({'input': input});

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    return responseBody['output'];
  } else {
    throw Exception('Failed to retrieve Cohere output');
  }
}
