import 'package:flutter/material.dart';
import 'package:palate_prestige/components/components.dart';
import 'package:palate_prestige/components/my_sliver_app_bar.dart';
import 'package:palate_prestige/test/test.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;

  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Palate Prestige")),
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                MySliverTabBar(
                  title: MyTabBar(tabController: _tabcontroller),
                  child: Image.asset(
                    "assets/cover_image.jpg",
                    height: 150,
                  ),
                ),
              ],
          body: TabBarView(
            
            controller: _tabcontroller,
            children: [
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Colors.green,
              ),
              Container(
                color: Colors.purple,
              ),
              Container(
                color: Colors.yellow,
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getItemsFromCategory('drinks');
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
