import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/bloc/product_bloc.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/repository/apprepository.dart';
import 'package:shop_app/views/home/productdetail_screen.dart';
import 'package:shop_app/views/home/home_page.dart';
import 'package:shop_app/views/home/search_screen.dart';
import 'package:shop_app/views/settings&detail/settings.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    HomePage(),
    RepositoryProvider(
      create: (context) => Apprepository(),
      child: BlocProvider(
        create: (context) => ProductBloc(context.read<Apprepository>()),
        child: SearchScreen(),
      ),
    ),
    // BlocProvider(
    //   create: (context) => ProductBloc(context.read<Apprepository>()),
    //   child: CartScreen(),
    // ),
    Center(child: Text("Cart")),
    Center(child: Text("Search")),
    Settings(),
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
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'cart',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}
