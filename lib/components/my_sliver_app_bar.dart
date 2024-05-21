import 'package:flutter/material.dart';

class MySliverTabBar extends StatelessWidget {
  final Widget child;
  final Widget title;
  const MySliverTabBar({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 240,
      collapsedHeight: 60,
      pinned: true,
      floating: true  ,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart),
        )
      ],
      backgroundColor: Colors.deepOrangeAccent,
      title: Center(child: const Text("Palate Prestige"),),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: child,
        ),
        title: title,

      ),
    );
  }
}
