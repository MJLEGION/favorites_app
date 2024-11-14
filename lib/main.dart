import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorites.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Favorites(),
      child: MaterialApp(
        title: 'Product List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductListScreen(),
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  final List<String> products = List.generate(10, (index) => 'Product $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              title: Text(product),
              trailing: Consumer<Favorites>(
                builder: (context, favorites, child) {
                  final isFavorite = favorites.items.contains(product);
                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      isFavorite ? favorites.removeItem(product) : favorites.addItem(product);
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoritesScreen()),
          );
        },
        child: Icon(Icons.favorite),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Consumer<Favorites>(
        builder: (context, favorites, child) {
          return ListView.builder(
            itemCount: favorites.items.length,
            itemBuilder: (context, index) {
              final item = favorites.items[index];
              return Card(
                child: ListTile(
                  title: Text(item),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      favorites.removeItem(item);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
