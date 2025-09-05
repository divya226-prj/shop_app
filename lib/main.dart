import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Filter/bloc/category_bloc.dart';
import 'package:shop_app/bloc/bloc/bloc/bloc/wishlist_bloc.dart';
import 'package:shop_app/bloc/bloc/bloc/cart_bloc.dart';
import 'package:shop_app/bloc/bloc/product_bloc.dart';
import 'package:shop_app/repository/apprepository.dart';
import 'package:shop_app/routes/app_routes.dart';
import 'package:shop_app/viewModel/settings_viewmodel.dart';
import 'package:shop_app/constants/app_theme.dart';
import 'package:shop_app/providers/application_provider.dart';
import 'package:shop_app/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    RepositoryProvider(
      create: (context) => Apprepository(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SettingsViewmodel()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => ApplicationProvider()),
          BlocProvider(
            create: (context) => ProductBloc(context.read<Apprepository>()),
          ),
          BlocProvider(
            create: (context) => CartBloc(context.read<Apprepository>()),
          ),
          BlocProvider(
            create: (context) => WishlistBloc(context.read<Apprepository>()),
          ),
          BlocProvider(
            create: (context) => CategoryBloc(context.read<Apprepository>()),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop app',
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.first,

      theme: AppTheme.lightTheme,
    );
  }
}
