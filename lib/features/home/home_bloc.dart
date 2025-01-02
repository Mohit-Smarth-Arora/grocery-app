import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:grocery/Data/cart_items.dart';
import 'package:grocery/Data/wishlist_items.dart';
import 'package:grocery/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:grocery/Data/grocery_data.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  List<ProductDataModel> GrocerryInfo = [];
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);

    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);

    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);

    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);

    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }
  Future<void> fetchGroceries() async {
    final url = Uri.parse('https://raw.githubusercontent.com/Mohit-Smarth-Arora/grocerry-app/refs/heads/main/grocerry_data');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> data = jsonDecode(response.body);
          GrocerryInfo = data.map((json) => ProductDataModel.fromJson(json)).toList();
      } else {
        print('Failed to load groceries');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));

    await fetchGroceries();

    emit(HomeLoadedSuccessState(
        products: GrocerryInfo));
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    wishlistItems.add(event.clickedProduct);
    // wishlistItems.remove(event.clickedProduct);
    print("wishlist clicked");
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    addProductToCart(event.clickedProduct);
    print("Cart Clicked");
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartPageActionState());
  }
}
