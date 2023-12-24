import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mnjz_assignment/bloc/product_bloc.dart';
import 'package:mnjz_assignment/models/product_model.dart';
import 'package:mnjz_assignment/models/rating_model.dart';
import 'package:mnjz_assignment/repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'widget_test.mocks.dart';
// Import the ProductBloc class from your implementation

// Create a mock class for Repository using Mockito
@GenerateMocks([Repository])
final List<Product> mockProducts = [
  Product(
    id: 1,
    title: "Sample Product",
    price: 99.99,
    description: "This is a sample product description.",
    category: "Sample Category",
    image: "https://example.com/sample-image.jpg",
    rating: Rating(
      rate: 4.5,
      count: 100,
    ),
  ),
  Product(
    id: 2,
    title: "Sample Product",
    price: 99.99,
    description: "This is a sample product description.",
    category: "Sample Category",
    image: "https://example.com/sample-image.jpg",
    rating: Rating(
      rate: 4.5,
      count: 100,
    ),
  )
];

void main() {
  late ProductBloc productBloc;
  late Repository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    productBloc = ProductBloc(mockRepository);
  });

  tearDown(() {
    productBloc.close();
  });

  group('ProductBloc', () {
    // Mock the fetchProducts method to return a list of products

    // Expect ProductsLoading and ProductsLoaded states when LoadProducts event is added
    blocTest<ProductBloc, ProductState>(
      'emits [ProductsLoading, ProductsLoaded] when LoadProducts event is added',
      build: () {
        when(mockRepository.fetchProducts())
            .thenAnswer((_) async => await Future.value(mockProducts));
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadProducts()),
      expect: () => [
        ProductsLoading(),
        ProductsLoaded(products: mockProducts),
      ],
    );
    blocTest(
        'emits [ProductsLoading, ProductsError when LoadProducts event is added]',
        build: () {
          when(mockRepository.fetchProducts())
              .thenThrow(Exception("Something went wrong"));
          return productBloc;
        },
        act: (bloc) => bloc.add(LoadProducts()),
        expect: () => [
              ProductsLoading(),
              const ProductError(message: 'Exception: Something went wrong'),
            ]);
  });
}
