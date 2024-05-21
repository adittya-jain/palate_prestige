import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> getItemsFromCategory(String category) async {
  // Create a GET request to the specified URL
  

  var response = await http.get(Uri.parse('http://localhost:3000/api/product?category=$category'), );

  // Check the status code to see if the request was successful
  if (response.statusCode == 200) {
    // The request was successful, parse the JSON response
    var data = jsonDecode(response.body);
    print(data);
  } else {
    // The request was not successful, handle the error
    print('Error: ${response.statusCode}');
  }
}