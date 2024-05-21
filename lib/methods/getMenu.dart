import 'dart:convert';
import 'package:palate_prestige/models/models.dart';
import 'package:http/http.dart' as http;

Future<List<Category>> fetchCategoriesAndItems() async {
  var response = await http.get(
    Uri.parse(
        'https://afosfr-admin-v6lq.vercel.app/api/category_items'), // Modify the endpoint to fetch both categories and items
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (data != null &&
        data['data'] != null &&
        data['data']['categories'] != null) {
      List<dynamic> categoriesData = data['data']['categories'];
      List<Category> categories = categoriesData.map((categoryData) {
        return Category(
          name: categoryData['name'],
          items: List<Item>.from(categoryData['items'].map((itemData) {
            return Item(
              // id: itemData['_id'],
              foodname: itemData['foodname'],
              price: itemData['price'],
              fooding: itemData['fooding'],
              avlb: itemData['avlb'],
              foodimg: itemData['foodimg']??"https://img.icons8.com/ios/50/no-image.png",
            );
          })),
        );
      }).toList();
      return categories;
    } else {
      print('Error: Categories and items data is null or empty');
      return [];
    }
  } else {
    print('Error fetching categories and items: ${response.statusCode}');
    return [];
  }
}

//  Future<void> fetchCategories() async {
//     var response = await http.get(
//       Uri.parse(
//           'http://localhost:3000/api/product'), // Replace this with your API endpoint
//     );

//     if (response.statusCode == 200) {
//       // The request was successful, parse the JSON response
//       // print(response.body);
//       var data = jsonDecode(response.body);
//       List<dynamic> products = data['products'];
//       // Extract unique category names from the list of products
//       Set<String> categories =
//           products.map((product) => product['category'] as String).toSet();
//       setState(() {
//         // Update tabTexts with the fetched categories
//         tabTexts = categories.toList();
//         // Generate tabs and tabsContent based on fetched categories
//         tabs = tabTexts.map((text) => Tab(child: Text(text))).toList();
//         tabsContent = List.generate(tabTexts.length, (index) => []);
//         // Fetch items for each category
//         for (int i = 0; i < tabs.length; i++) {
//           getItemsForTab(i, tabTexts[i]);
//         }
//       });
//     } else {
//       print('Error fetching categories: ${response.statusCode}');
//     }
//   }

//   //get request
//   Future<void> getItemsForTab(int tabIndex, String category) async {
//     // Create a GET request to the specified URL

//     var response = await http.get(
//       Uri.parse('http://localhost:3000/api/product?category=$category'),
//     );

//     // Check the status code to see if the request was successful
//     if (response.statusCode == 200) {
//       // The request was successful, parse the JSON response
//       var data = jsonDecode(response.body);
//       // print(data);
//       setState(() {
//         tabsContent[tabIndex] = data['products'];
//       });
//     } else {
//       // The request was not successful, handle the error
//       print('Error: ${response.statusCode}');
//     }
//   }

