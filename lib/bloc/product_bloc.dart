import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mnjz_assignment/models/product_model.dart';
import 'package:mnjz_assignment/repository.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(
    Repository repo,
  ) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      try {
        emit(ProductsLoading());
        List<Product> products = await repo.fetchProducts();
        emit(ProductsLoaded(products: products));
      } on Exception catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });
  }
}
