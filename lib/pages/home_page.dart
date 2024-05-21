import 'package:flutter/material.dart';
import 'package:palate_prestige/components/productItem.dart';
import 'package:palate_prestige/models/menu.dart';
import 'package:palate_prestige/methods/getMenu.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<String> tabTexts = [];
  late List<Tab> tabs = [];
  late List<List<dynamic>> tabsContent = [];
  List<Category> categories = [];

  void addToCart(Item item) {
    Provider.of<Menu>(context, listen: false).addToCart(item);
  }

  @override
  void initState() {
    super.initState();
    tabs = [];
    tabTexts = [];

    // Call the function to fetch categories from the API
    // fetchCategories();
    fetchData();
  }

  void fetchData() async {
    List<Category> categories = await fetchCategoriesAndItems();
    categories.forEach((category) {
      print('Category: ${category.name}');
      category.items.forEach((item) {
        print(
            'Item Name: ${item.foodname}, Price: ${item.price},Image: ${item.foodimg}');
        // Use item properties as needed
      });
    });
    setState(() {
      // Update tabTexts with category names
      tabTexts = categories.map((category) => category.name).toList();

      // Generate tabs based on tabTexts
      tabs = tabTexts.map((text) => Tab(child: Text(text))).toList();

      // Initialize tabsContent with empty lists
      tabsContent = List.generate(tabTexts.length, (index) => []);

      // Fetch items for each category
      for (int i = 0; i < categories.length; i++) {
        Category category = categories[i];
        List<dynamic> items = category.items
            .map((item) => {
                  'foodname': item.foodname,
                  'category': category.name,
                  'price': item.price,
                  'foodimg': item.foodimg,
                  'avlb': item.avlb,
                  'fooding': item.fooding
                })
            .toList();
        tabsContent[i] = items;
      }
    });
  }

  // Function to fetch categories from the API

  @override
  Widget build(BuildContext context) {
    return Consumer<Menu>(
      builder: (context, value, child) => SafeArea(child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Palate Prestige"),
              backgroundColor: Colors.grey[200],
              centerTitle: true,
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TabBar(
                  indicatorColor: Color.fromARGB(255, 22, 157, 172),
                  isScrollable: true,
                  tabs: tabs,
                ),
                Expanded(
                  child: TabBarView(
                    children: List.generate(
                      tabsContent.length,
                      (index) {
                        return ListView.builder(
                          itemCount: tabsContent[index].length,
                          itemBuilder: (context, itemIndex) {
                            return ProductItem(
                              name: tabsContent[index][itemIndex]['foodname'],
                              category: tabsContent[index][itemIndex]['category'],
                              price: tabsContent[index][itemIndex]['price'],
                              imageUrl:
                                  tabsContent[index][itemIndex]['foodimg'] ?? "",
                              onAddToCart: () => addToCart(
                                Item(
                                  foodname: tabsContent[index][itemIndex]
                                      ['foodname'],
                                  price: tabsContent[index][itemIndex]['price'],
                                  foodimg: tabsContent[index][itemIndex]
                                          ['foodimg'],
                                  avlb: tabsContent[index][itemIndex]['avlb'],
                                  fooding: tabsContent[index][itemIndex]
                                      ['fooding'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            //route to cart page
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              child: Icon(Icons.shopping_cart),
            )),
      ),)
    );
  }
}
