import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;
  const MyTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        isScrollable: true,
        controller: tabController,
        tabs: [
          Tab(
            icon: Icon(Icons.home),
          ),
          Tab(
            icon: Icon(Icons.ac_unit_outlined),
          ),
          Tab(
            icon: Icon(Icons.accessibility),
          ),
          Tab(
            icon: Icon(Icons.account_balance_wallet_rounded),
          )
        ],
      ),
    );
  }
}
