import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grocery/Data/cart_items.dart';
import 'package:grocery/features/home/home_bloc.dart';
import 'package:grocery/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';
import 'package:grocery/features/cart/ui/cart_page.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    print("removed from cart");

    countTotal(cartItems);
    removeProductFromCart(event.cartProductDataModel);
    emit(CartProductRemovedState());
    emit(CartSuccessState(cartItems: cartItems));
  }
}
