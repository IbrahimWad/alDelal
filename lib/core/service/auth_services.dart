import 'dart:convert';
import 'package:aldlal/view/widget/urls.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  auth({required String phone}) async {
    var response = await http.post(Uri.parse(Urls.auth),
        body: jsonEncode({
          'phone': phone,
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });

    var responseBody = jsonDecode(response.body);

    if (response.statusCode == 201 || response.statusCode == 500) {
      return responseBody;
    }

    if (response.statusCode == 403) {
      return responseBody;
    }

    if (response.statusCode == 200) {
      return responseBody;
    }

    return responseBody;
  }
}
