import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/home_page.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    HomePage(),
    Center(child: Text("Wishlist")),
    Center(child: Text("Cart")),
    Center(child: Text("Search")),
    Center(child: Text("Settings")),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.textPrimary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'cart',
          ),

          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:shop_app/constants/app_color.dart';
// import 'package:shop_app/home_page.dart';

// class CustomBottomNavBar extends StatefulWidget {
//   const CustomBottomNavBar({super.key});

//   @override
//   State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
// }

// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   int _selectedIndex = 0;

//   static const List<Widget> _screens = [
//     HomePage(),
//     Center(child: Text("Wishlist")),
//     Center(child: Text("Cart")),
//     Center(child: Text("Search")),
//     Center(child: Text("Settings")),
//   ];

//   void _onTabTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_selectedIndex],

//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _onTabTapped(2),
//         backgroundColor: _selectedIndex == 2
//             ? AppColor.primary
//             : AppColor.textonsecondary,
//         elevation: 8,
//         shape: const CircleBorder(),
//         child: Icon(
//           Icons.shopping_cart_outlined,
//           color: _selectedIndex == 2
//               ? AppColor.textonsecondary
//               : AppColor.textPrimary,
//           size: 28,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 10,
//         elevation: 8,
//         color: AppColor.textonsecondary,
//         child: SizedBox(
//           height: 70,
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildNavItem(Icons.home, "Home", 0),
//                     _buildNavItem(Icons.favorite_border, "Wishlist", 1),
//                   ],
//                 ),
//               ),

//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildNavItem(Icons.search, "Search", 3),
//                     _buildNavItem(Icons.settings, "Setting", 4),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(IconData icon, String label, int index) {
//     final isSelected = _selectedIndex == index;

//     return GestureDetector(
//       onTap: () => _onTabTapped(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             color: isSelected ? AppColor.primary : AppColor.textPrimary,
//             size: 24,
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: isSelected ? AppColor.primary : AppColor.textPrimary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
