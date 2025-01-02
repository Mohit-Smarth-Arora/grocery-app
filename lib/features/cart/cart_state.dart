part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitialState extends CartState {}

class CartSuccessState extends CartState {
  final Set<ProductDataModel> cartItems;

  CartSuccessState({required this.cartItems});
}

class CartButtonClickedAtHomeProductState extends CartState {}

class CartProductRemovedState extends CartActionState {}

// class CartProductAddedState extends CartActionState {}
