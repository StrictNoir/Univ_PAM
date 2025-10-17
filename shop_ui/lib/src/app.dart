import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/product_cubit.dart';
import 'repositories/product_repository.dart';
import 'theme.dart';
import 'screens/home_page.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => ProductRepository(),
      child: BlocProvider(
        create: (context) =>
            ProductCubit(context.read<ProductRepository>())..loadProducts(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop UI',
          theme: buildTheme(),
          home: const HomePage(),
        ),
      ),
    );
  }
}
