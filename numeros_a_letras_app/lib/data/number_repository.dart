import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:numeros_a_letras_app/models/number.dart';

class NumberRepository {
  Future<Number> getNumber(double number) async {
    var queryParameters = {
      'num': number.toString(),
    };
    
    var uri =
        Uri.https("nal.azurewebsites.net", "/api/NAL", queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return Number.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load number');
    }
  }
}