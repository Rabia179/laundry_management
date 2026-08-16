import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

  runApp(const LaundryManagementApp());
}

class LaundryManagementApp extends StatelessWidget {
  const LaundryManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laundry Management',

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F5F0),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8FAF99),
          brightness: Brightness.light,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F5F0),
          foregroundColor: Color(0xFF252525),
          elevation: 0,
          centerTitle: false,
        ),

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(22),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF8FAF99),
              width: 1.5,
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 13,
          ),
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF8FAF99),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),

      home: const LaundryHomeScreen(),
    );
  }
}

// ============================================================
// HOME SCREEN
// ============================================================

class LaundryHomeScreen extends StatefulWidget {
  const LaundryHomeScreen({super.key});

  @override
  State<LaundryHomeScreen> createState() =>
      _LaundryHomeScreenState();
}

class _LaundryHomeScreenState
    extends State<LaundryHomeScreen> {
  int selectedCategory = 0;

  final List<String> categories = [
    'All',
    'Shirts',
    'Hoodies',
    'Jackets',
    'T-Shirts',
  ];

  final List<LaundryItem> items = const [
    LaundryItem(
      name: 'Classic Hoodie',
      price: 450,
      image: 'assets/images/hoodie.png',
      category: 'Hoodies',
    ),
    LaundryItem(
      name: 'Cotton T-Shirt',
      price: 250,
      image: 'assets/images/tshirt.png',
      category: 'T-Shirts',
    ),
    LaundryItem(
      name: 'Formal Shirt',
      price: 300,
      image: 'assets/images/shirt.png',
      category: 'Shirts',
    ),
    LaundryItem(
      name: 'Casual Jacket',
      price: 600,
      image: 'assets/images/jacket.png',
      category: 'Jackets',
    ),
    LaundryItem(
      name: 'Warm Sweatshirt',
      price: 500,
      image: 'assets/images/sweatshirt.png',
      category: 'Hoodies',
    ),
    LaundryItem(
      name: 'Denim Jeans',
      price: 400,
      image: 'assets/images/jeans.png',
      category: 'All',
    ),
  ];

  List<LaundryItem> get filteredItems {
    if (selectedCategory == 0) {
      return items;
    }

    return items.where((item) {
      return item.category == categories[selectedCategory];
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Laundry Management',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Orders',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OrdersScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.local_laundry_service_outlined,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          20,
          8,
          20,
          30,
        ),
        children: [
          // HEADER CARD
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFFDDE8D5),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Clean & Fresh',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF405C48),
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Laundry made\nsimple.',
                  style: TextStyle(
                    fontSize: 28,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF263B2D),
                  ),
                ),
                SizedBox(height: 9),
                Text(
                  'Manage your laundry items and orders easily.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF5F6F64),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Laundry Services',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final selected =
                    selectedCategory == index;

                return Padding(
                  padding:
                  const EdgeInsets.only(right: 9),
                  child: ChoiceChip(
                    label: Text(categories[index]),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = index;
                      });
                    },
                    selectedColor:
                    const Color(0xFF405C48),
                    backgroundColor: Colors.white,
                    side: BorderSide.none,
                    labelStyle: TextStyle(
                      color: selected
                          ? Colors.white
                          : const Color(0xFF555555),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              const Expanded(
                child: Text(
                  'Laundry Items',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '${filteredItems.length} items',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            itemCount: filteredItems.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 14,
              childAspectRatio: .68,
            ),
            itemBuilder: (context, index) {
              final item = filteredItems[index];

              return LaundryCard(
                item: item,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          LaundryDetailsScreen(item: item),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MODEL
// ============================================================

class LaundryItem {
  final String name;
  final double price;
  final String image;
  final String category;

  const LaundryItem({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
  });
}

// ============================================================
// LAUNDRY CARD
// ============================================================

class LaundryCard extends StatefulWidget {
  final LaundryItem item;
  final VoidCallback onTap;

  const LaundryCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  State<LaundryCard> createState() =>
      _LaundryCardState();
}

class _LaundryCardState extends State<LaundryCard> {
  bool selected = false;

  Future<void> toggleSelected() async {
    final prefs =
    await SharedPreferences.getInstance();

    setState(() {
      selected = !selected;
    });

    await prefs.setBool(
      'laundry_${widget.item.name}',
      selected,
    );
  }

  @override
  void initState() {
    super.initState();
    loadSelected();
  }

  Future<void> loadSelected() async {
    final prefs =
    await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      selected = prefs.getBool(
        'laundry_${widget.item.name}',
      ) ??
          false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0EFEA),
                      borderRadius:
                      BorderRadius.circular(22),
                    ),
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(22),
                      child: Image.asset(
                        widget.item.image,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) {
                          return const Center(
                            child: Icon(
                              Icons.checkroom_outlined,
                              size: 45,
                              color:
                              Color(0xFF9A9A94),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Positioned(
                    top: 9,
                    right: 9,
                    child: Material(
                      color: Colors.white,
                      shape:
                      const CircleBorder(),
                      child: IconButton(
                        visualDensity:
                        VisualDensity.compact,
                        onPressed:
                        toggleSelected,
                        icon: Icon(
                          selected
                              ? Icons.check_circle
                              : Icons.add_circle_outline,
                          color: selected
                              ? const Color(
                            0xFF405C48,
                          )
                              : const Color(
                            0xFF555555,
                          ),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding:
              const EdgeInsets.fromLTRB(
                11,
                10,
                11,
                12,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight:
                      FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Rs. ${widget.item.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight:
                      FontWeight.w800,
                      color:
                      Color(0xFF405C48),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DETAILS
// ============================================================

class LaundryDetailsScreen
    extends StatelessWidget {
  final LaundryItem item;

  const LaundryDetailsScreen({
    super.key,
    required this.item,
  });

  Future<void> addLaundry(
      BuildContext context,
      ) async {
    final prefs =
    await SharedPreferences.getInstance();

    final list =
        prefs.getStringList('laundry_orders') ??
            [];

    if (!list.contains(item.name)) {
      list.add(item.name);
    }

    await prefs.setStringList(
      'laundry_orders',
      list,
    );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content:
        Text('Laundry item added successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFF7F5F0),
      appBar: AppBar(
        title: const Text(
          'Laundry Details',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 390,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EFEA),
              borderRadius:
              BorderRadius.circular(28),
            ),
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(28),
              child: Image.asset(
                item.image,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 22),

          Text(
            item.name,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Rs. ${item.price.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF405C48),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'Professional laundry service for clean, fresh and well-maintained clothes.',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF666666),
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 52,
            child: FilledButton.icon(
              onPressed: () =>
                  addLaundry(context),
              icon: const Icon(
                Icons.local_laundry_service,
              ),
              label: const Text(
                'Add to Laundry',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ORDERS
// ============================================================

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() =>
      _OrdersScreenState();
}

class _OrdersScreenState
    extends State<OrdersScreen> {
  List<String> orders = [];

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders() async {
    final prefs =
    await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      orders =
          prefs.getStringList('laundry_orders') ??
              [];
    });
  }

  Future<void> clearOrders() async {
    final prefs =
    await SharedPreferences.getInstance();

    await prefs.remove('laundry_orders');

    if (!mounted) return;

    setState(() {
      orders.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFF7F5F0),
      appBar: AppBar(
        title: const Text(
          'Laundry Orders',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          if (orders.isNotEmpty)
            IconButton(
              onPressed: clearOrders,
              icon: const Icon(
                Icons.delete_outline,
              ),
            ),
        ],
      ),
      body: orders.isEmpty
          ? const Center(
        child: Text(
          'No laundry orders yet.',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: orders.length,
        itemBuilder:
            (context, index) {
          return Container(
            margin:
            const EdgeInsets.only(
              bottom: 12,
            ),
            padding:
            const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(21),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons
                      .local_laundry_service_outlined,
                  color:
                  Color(0xFF405C48),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    orders[index],
                    style:
                    const TextStyle(
                      fontWeight:
                      FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}