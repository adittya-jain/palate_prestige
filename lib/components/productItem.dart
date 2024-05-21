import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final String category;
  final String price;
  final String imageUrl;
  final VoidCallback? onAddToCart;

  const ProductItem({super.key, 
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(imageUrl,height: 150,), // Display image
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category: $category'),
            Text('Price: Rs $price'),
          ],
        ),
        trailing: ElevatedButton(
           onPressed: () {
            if (onAddToCart != null) {
              onAddToCart!();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to cart'),duration: Duration(seconds: 1),),
              );
            }
          },
          child: const Text('+'),
        ),
      ),
    );
  }
}
