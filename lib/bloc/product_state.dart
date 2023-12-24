part of 'product_bloc.dart';

@immutable
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;

  const ProductsLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class ProductsLoading extends ProductState {}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});
  @override
  String toString() => message;
  @override
  List<Object?> get props => [message];
}
