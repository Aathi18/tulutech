import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../../models/product.dart';
import '../../services/product_service.dart';
import '../../services/auth_service.dart'; 
import '../../providers/cart_provider.dart'; 
import '../cart/cart_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductService _productService = ProductService();
  final ScrollController _scrollController = ScrollController();
  List<Product> products = [];
  int skip = 0;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    // Listener for infinite scrolling/pagination 
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      final newProducts = await _productService.fetchProducts(skip: skip);
      
      if (newProducts.isEmpty) {
        hasMore = false;
      } else {
        products.addAll(newProducts);
        skip += newProducts.length; 
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading products: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _onScroll() {
    // Check if the user reached the end of the list to load more 
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoading) {
      _loadProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItemCount = context.watch<CartProvider>().cart.length; 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products (Tulu Tech)'),
        actions: [
          // Cart Navigation and Badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              if (cartItemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '$cartItemCount',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          // Logout Button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
            },
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: products.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < products.length) {
            final product = products[index];
            return ListTile( // No positional arguments used here, fixing the previous error.
              // Show product name, price, thumbnail, and rating
              leading: Image.network(product.thumbnail, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(product.title),
              subtitle: Text('\$${product.price.toStringAsFixed(2)} - Rating: ${product.rating}'),
              trailing: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () {
                  // Add to Cart Logic 
                  context.read<CartProvider>().addItem(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.title} added to cart!'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            );
          } else {
            // Show loading indicator at the bottom
            return const Center(child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ));
          }
        },
      ),
    );
  }
}