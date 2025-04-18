import 'package:flutter/material.dart';
import 'index.dart';
import 'shop.dart';
import 'listpage.dart';
import 'profilepage.dart';

class RiceSeedpage extends StatefulWidget {
  const RiceSeedpage({Key? key}) : super(key: key);

  @override
  _RiceSeedpageState createState() => _RiceSeedpageState();
}

class _RiceSeedpageState extends State<RiceSeedpage> {
  int _selectedIndex = 2;
  String _searchQuery = '';
  String _kgFilter = '';
  String _locationFilter = '';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0: // Home
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
        break;
      case 1: // List
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ListPage()),
        );
        break;
      case 2: // Shop
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ShopPage()),
        );
        break;
      case 3: // Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: const Color(0xFF055B1D),
          elevation: 0,
          automaticallyImplyLeading: false, // Prevents default back button
          flexibleSpace: SafeArea(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                'Rice Seeds',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Advanced Search Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search product name...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() => _kgFilter = value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Kg range...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() => _locationFilter = value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Location...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Product List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: _filteredProducts()
                  .map((product) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ProductCard(
                          image: product.image,
                          name: product.name,
                          family: product.family,
                          location: product.location,
                          price: product.price,
                          color: const Color(0xFFE0EAD8),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF006400),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  List<Product> _filteredProducts() {
    List<Product> allProducts = [
      Product('assets/riceseedpremimum.jpg', 'Rice Seeds - Elite', 'Muthiah  family', 'Karur', 'Rs 40/Kg'),
      Product('assets/riceseeddrum.jpg', 'Rice Seeds - Durum', 'Chinnasamy family', 'Tirunelveli', 'Rs 55/Kg'),
      Product('assets/riceseeedhybrid.jpg', 'Rice Seeds - Hybrid', 'Karuppan family', 'Palakkad', 'Rs 30/Kg'),
      Product('assets/riceseedlocal.jpg', 'Rice Seeds - Local', 'Periyasamy family', 'Tiruppur', 'Rs 25/Kg'),
      Product('assets/riceseedorganic.jpg', 'Rice Seeds - Organic', 'Muthulakshmi family', 'Coimbatore', 'Rs 50/Kg'),
      Product('assets/riceseedpremimum.jpg', 'Rice Seeds - Elite', 'Velu family', 'Madurai', 'Rs 45/Kg'),
      Product('assets/riceseedsoft.jpg', 'Rice Seeds - Soft', 'Ponnamma family', 'Salem', 'Rs 35/Kg'),
      Product('assets/riceseedspring.jpg', 'Rice Seeds - Spring', 'Vellaiyamma family', 'Erode', 'Rs 60/Kg'),
    ];

    return allProducts.where((product) {
      final matchesName = product.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesLocation = _locationFilter.isEmpty || 
          product.location.toLowerCase().contains(_locationFilter.toLowerCase());
      final matchesKg = _kgFilter.isEmpty || 
          product.price.toLowerCase().contains(_kgFilter.toLowerCase());
      return matchesName && matchesLocation && matchesKg;
    }).toList();
  }
}

class Product {
  final String image;
  final String name;
  final String family;
  final String location;
  final String price;

  Product(this.image, this.name, this.family, this.location, this.price);
}

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String family;
  final String location;
  final String price;
  final Color color;

  const ProductCard({
    Key? key,
    required this.image,
    required this.name,
    required this.family,
    required this.location,
    required this.price,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
            ),
            child: Image.asset(
              image,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 90,
                  height: 90,
                  color: Colors.grey[300],
                  child: const Center(child: Text('Image Not Found')),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    family,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              price,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}