import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mnjz_assignment/bloc/product_bloc.dart';
import 'package:mnjz_assignment/models/product_model.dart';
import 'package:mnjz_assignment/models/rating_model.dart';
import 'package:mnjz_assignment/presentation/home_page.dart';
import 'package:mnjz_assignment/repository.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter<Product>(ProductAdapter());
  Hive.registerAdapter<Rating>(RatingAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repository(),
      child: BlocProvider(
        create: (context) => ProductBloc(context.read<Repository>()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
