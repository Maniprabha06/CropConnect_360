import 'package:flutter/material.dart';
import 'package:niral_prj/drychilly.dart';
import 'package:niral_prj/lemon.dart';
import 'package:niral_prj/listpage.dart';
import 'package:niral_prj/mango.dart';
import 'package:niral_prj/profilepage.dart';
import 'package:niral_prj/index.dart';
import 'package:niral_prj/wheat.dart';
import 'rice.dart';
import 'cherry.dart';
class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _selectedIndex = 2; // Shop is index 2

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
        // Already on ShopPage, do nothing
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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: const Color(0xFF055B1D),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'Explore Your Wishes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
          actions: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.white),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Favorite pressed')),
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cart opened')),
                  );
                },
              ),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF055B1D),
                  Color(0xFF077A2F),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFDCE8D6)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: const [
                  ProductCard(
                    name: 'Rice Seed',
                    imagePath: 'assets/Rice_Seed.jpeg',
                  ),
                  ProductCard(
                    name: 'Lemon Tree',
                    imagePath: 'assets/lemon_tree.jpeg',
                  ),
                  ProductCard(
                    name: 'Weat Seed',
                    imagePath: 'assets/wheat.jpeg',
                  ),
                  ProductCard(
                    name: 'Cherry Tree',
                    imagePath: 'assets/cherry.jpeg',
                  ),
                  ProductCard(
                    name: 'Dry Chilly',
                    imagePath: 'assets/drychilly2.jpeg',
                  ),
                  ProductCard(
                    name: 'Mango',
                    imagePath: 'assets/mango.jpeg',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF055B1D),
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.shopping_cart),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF055B1D),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              label: 'Shop',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String imagePath;

  const ProductCard({
    Key? key,
    required this.name,
    required this.imagePath,
  }) : super(key: key);

  // Function to determine which page to navigate to based on product name
  void _navigateToProductPage(BuildContext context) {
    switch (name) {
      case 'Rice Seed':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RiceSeedpage(),
          ),
        );
        break;
      case 'Lemon Tree':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LemonSeedPage(),
          ),
        );
        break;
      case 'Weat Seed':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WheatSeedPage(),
          ),
        );
        break;
      case 'Cherry Tree':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>CherrySeedPage(),
          ),
        );
        break;
      case 'Dry Chilly':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DryChillySeedPage(),
          ),
        );
        break;
      case 'Mango':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MangoSeedPage(),
          ),
        );
        break;
      default:
        // Fallback in case a product doesn't match
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title: const Text('Unknown Product')),
              body: const Center(child: Text('No page for this product')),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToProductPage(context),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFDCE8D6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10), // Fixed syntax error here
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(child: Text('Image')),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder pages for each product (customize these as needed)



// Cherry Tree Page
class CherryTreePage extends StatelessWidget {
  final String imagePath;
  const CherryTreePage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cherry Tree')),
      body: Center(
        child: Text('Design your Cherry Tree page here\nImage: $imagePath'),
      ),
    );
  }
}

// Mango Page
