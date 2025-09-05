import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/bloc/bloc/cart_bloc.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/model/category_model.dart';
import 'package:shop_app/views/home/cart_screen.dart';
import 'package:shop_app/views/home/home_page.dart';
import 'package:shop_app/views/home/search_screen.dart';
import 'package:shop_app/views/home/wishlist_screen.dart';
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
    SearchScreen(),
    CartScreen(),
    WishlistScreen(),

    Settings(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(FetchProducts());
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
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                int count = 0;
                if (state is CartLoaded) {
                  count = state.cartItems.length;
                }
                return Badge(
                  label: Text('${count}'),

                  child: Icon(Icons.shopping_cart_outlined),
                );
              },
            ),
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
