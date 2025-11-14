import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasources/product_remote_data_source.dart';
import 'data/repositories/product_repository.dart';
import 'domain/repositories/product_repository.dart';
import 'presentation/bloc/product_cubit.dart';
import 'presentation/theme.dart';
import 'presentation/screens/home_page.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ProductRepositoryImpl(
      remoteDataSource: ProductRemoteDataSource(),
    );

    return RepositoryProvider<ProductRepository>.value(
      value: repository,
      child: BlocProvider(
        create: (context) => ProductCubit(context.read<ProductRepository>())..loadProducts(),
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
