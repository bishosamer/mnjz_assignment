import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnjz_assignment/bloc/product_bloc.dart';
import 'package:mnjz_assignment/presentation/widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Products'),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial) {
            context.read<ProductBloc>().add(LoadProducts());
          }
          if (state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductsLoaded) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    (MediaQuery.of(context).size.width ~/ 250).toInt(),
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: state.products[index]);
              },
            );
          } else {
            return const Center(
              child: Text('something went wrong please try again'),
            );
          }
        },
        listener: (BuildContext context, ProductState state) {
          if (state is ProductError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
      ),
    );
  }
}
